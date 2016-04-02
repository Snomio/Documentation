# XML Definitions

Some phone settings can be defined using an XML definition, an XML definition is a ruleset (defined trough an XML syntax) specifying a particular setting behaviour.

For example you can customise the action taken during a key pressure (and the key release too), also you can instruct the phone to subscribe a SIP resource and then parse the XML body received into the in-dialog NOTIFY. The XML definition can setup various states and the phone can reacts to state changes and/or take action in different states.

## Example

The following example XML code can be applied to a function key setting in order to create a SUBSCRIBE dialog and their NOTIFY parsing rules.

```xml
<general type="BusyLampField" identity="1"/>

<initialization>
  <state value="initial"/>
  <variable name="subscr_uri" value="sip:424711@com.snom"/>
</initialization>

<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>

<NotifyParsingRules type="applies">     
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1>   
</NotifyParsingRules>   
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing">     
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1>   
</NotifyParsingRules>   
<NotifyParsingRules type="variable" id="remote_tag" state="ringing">     
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1>   
</NotifyParsingRules>   
<NotifyParsingRules type="variable" id="local_tag" state="ringing">     
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1>   
</NotifyParsingRules>   
<NotifyParsingRules type="variable" id="remote_uri" state="ringing">     
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1>   
</NotifyParsingRules>  
<NotifyParsingRules type="variable" id="remote_name" state="ringing">     
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1>   
</NotifyParsingRules>

<action>   
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <dial target="$(subscr_uri)" when="on press"/> 
</action>
```

# state(s)

**state** and **states** attributes are case sensitive and need to be written correctly (mostly lowercase). **states** conditions can contain multiple states which are a comma-separated list, **action** and **NotifyParsingRules** elements will only be executed if the current state value matches one of these in the list.

# require

**require** attribute consists of a comparison sign and two operands on either side. Each operand consists of alphanumeric constant characters and placeholders for dynamic variable insertion. The placeholders start with a $-sign followed by a pair of brackets enclosing the variable name. Curly brackets are used for inserting the variables of all the contexts currently referred to (i.e. all the contexts named via the context-attribute) while parentheses are used for the local xml entity context. The variables may actually be variables but may also insert array-members or the state or type of an xml-entity. See these examples for more clarity:

- `${type}==ResourceListBuddy`: only use context-entities whose type is set to "ResourceListBuddy"
- `${BuddyUri}==$(uri)`: only use context-entities that have a variable named BuddyUri which is set to the same value as the one stored in the variable "uri" of this xml-entity
- `${BuddyUri}==$(uris[$(index)])`: similar to previous example, but right-side operand is an array. The variable $(index) is available in destination-requirements whenever the source is an array.

# Setting Toggle example

Our first example is about how to create a "Settings Toggle", which on the end would auto assign the current value; display the text for the particular button and translate the Text if an another language is being used.

## Simple Setting Toggle Button

As the first step we need to define our XML Definition Code. To do so we need to write a **general** element as the first line of our code:

```xml
<general type="PrivacyToggle" />
```

In the **general** element we write the information's which are required by the phone to create a function and assign it to an identity if required.The **type** attribute is the name of our function and can be shown in the Phone User Interface as an Option or in some cases we use it to reference to this XML Definition code from another XML Definition code.

The next step would be to add the initialization and assign a state to our button:

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
</initialization>
```

The **initialization** element allows us to define an initial state for a button, a variable and/or an array. In this particular case we will just use the **state** and give it the value *off*. Which means on boot up of the phone this button would be in state *off*.

Now we are going to add the Actions which should happen when our Button is pressed. For this example we would like to execute a HTTP Request for the snom phone to change a setting. In this particular case to hide our outgoing number to *anonymous* and revert it back with a second press.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
</action>
```

All our functionalities need to be put in the **action** element container. We wrote two lines of Code inside our action element, both of them are **url** elements, which means they will execute HTTP Requests.The **target** attribute tells the phone which URL should be opened/executed, the **when** attribute says on which event the URL should be opened/executed and the last **states** attribute is the condition in which state of the button should these action be execute.At the moment if you press this XML Definition Button, the phone will open the following URL: *http://localhost/settings.htm?settings=save&privacy_out=on*

!!! WARNING
    The URL *http://localhost/settings.htm?settings=save* is used to change the setting *privacy_out* if your phone web server is secured with credentials you have to include such credentials into the URL: *http://username:password@localhost/settings.htm?settings=save*.

    In case your phone has the *admin_mode* disabled such URL will not work. In this case a workaround is to configure the **service mode credentials** trough the settings *service_mode_login* and *service_mode_password*.

But at the moment the button will not change the state to "ON" on the press and each time it will execute the same above URL. That is why we need to add some intelligence to the button, so that on a press the state of the button changes and different actions get executed.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

At this step we add the **assign** elements to our code, these elements are used to change the state of the Button and/or assign values to variables or arrays. Assign element has two sub-elements **source** (where we define where the value is coming from) and **destination** (where we define where to write/put our value to). **assign** has like all other action elements the two attributes to define on which event and in which state of the button should these assign action happen.

```xml
<assign when="on press" states="off">
  <source context="this entity" value="on"/>
  <destination context="this entity" id="state"/>
</assign>
```
*If the state of the Button is off and on press of that button, assign/set the value on to the variable state.*

**NOTE:** Depending of the value **state** the LED of that Button will be ON or OFF. More about the LED control will be described in a future part.

## Auto assignment

By using the above example you probably found out that, when the phone has been rebooted the button will get in the **state** we defined in the **initialization** tag. Even if the setting was already changed to a non-initial value. To get this solved we are going to add a **assign** element which would be executed **after-initialization**.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign when="after initialization">
    <source context="setting" id="privacy_out"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

As you see we added a new **assign** element to our XML Definition Code, which would be executed as soon as the initialization has been done (phone boot up). Also at this step we are facing another **context** in our **source** element, which tell the phone look for variables in the phone **setting**-s. Of course we needed also to define for which setting exactly are we looking, that's why we replaced the **value** attribute with the **id** attribute which is the name of our setting.

```xml
<assign when="after initialization">
  <source context="setting" id="privacy_out"/>
  <destination context="this entity" id="state"/>
</assign>
```
*After phone boot up, get from the phone settings the current value for privacy_out and assign it to our **state** variable.*

So now when you reboot the phone, the button will check the current (last set) value in the settings and update the state of our button. But what will happen when someone changes the setting over the phones Web User Interface or it gets provisioned with a different value!? To get the **state** update on setting changed we need to add one more attribute to our **assign** element.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign type="update on change" when="after initialization">
    <source context="setting" id="privacy_out"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

The new attribute **type** tells the phone that if a change on the phone happens, execute that particular **assign** element block again. In our case, get the new value from the setting **privacy_out** and assign it to our **state** variable.

## Labels

Our next step would be to show a text for our Button (snom 760 and 8xx phones). These texts are named **labels**. As first we are going to take our previous code and add the required arrays for the labeling.

**NOTE:** Virtual keys support two line labeling (only available on snom 8xx phones), Line Info Layer only supports one line labeling (only available on snom 760 and 82X phones). The example below is for virtual key labeling.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
  <array name='label' separator=',' value='Hide own outgoing ID,off'/>
  <array name='label_x' separator=',' value='5,5'/>
  <array name='label_y' separator=',' value='2,15'/>
  <array name='label_width' separator=',' value='74,95'/>
  <array name='label_height' separator=',' value='13,24'/>
  <array name='label_align' separator=',' value='left,center'/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign type="update on change" when="after initialization">
    <source context="setting" id="privacy_out"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

The added arrays contain the Text we would like to display; the positions, lengths and alignments of the Texts. If we put the above XML Definition Code on our phone and press the button it will always display *"Hide own outgoing ID"* in upper-left corner and *"off"* in the middle, because there is no intelligence which changes the *"off"* value to *"on"*. That would be our next step. But to explain the arrays a bit better, the **separator**: can be whatever you want (including " " -space). Also here a table for the above values:

|Variable name | 1st Value | 2nd Value |
|--------------|-----------|-----------|
|label|Hide own outgoing ID|	off|
|label_x|5|5|
|label_y|2|15|
|label_width|74|95|
|label_height|13|24|
|label_align|left|center|

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
  <array name='label' separator=',' value='Hide own outgoing ID,off'/>
  <array name='label_x' separator=',' value='5,5'/>
  <array name='label_y' separator=',' value='2,15'/>
  <array name='label_width' separator=',' value='74,95'/>
  <array name='label_height' separator=',' value='13,24'/>
  <array name='label_align' separator=',' value='left,center'/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign type="update on change" when="after initialization">
    <source context="setting" id="privacy_out"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign type="update on change" when="after initialization">
    <source context="this entity" id="state"/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

Now we added an **assign** element which would get the **state** value and assign or in our case rewrite the value no our label array on the second position (label[1]). 

NOTE: Arrays start to count with 0, which means **label[0]** would be "Hide own outgoing ID" and **label[1]** would be "off".

![Privacy toggle: label](img/privacytoggle-off.png)

## Language support

Our last part for this example is to add Language support to our Text from our previous part. To do so we would need also to change our existing **assign** element for the label and add one more.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
  <array name='label' separator=',' value='Hide own outgoing ID,off'/>
  <array name='label_x' separator=',' value='5,5'/>
  <array name='label_y' separator=',' value='2,15'/>
  <array name='label_width' separator=',' value='74,95'/>
  <array name='label_height' separator=',' value='13,24'/>
  <array name='label_align' separator=',' value='left,center'/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign type="update on change" when="after initialization">
    <source context="setting" id="privacy_out"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign states="off" when="after initialization">
    <source context="language" id="off"/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign states="on" when="after initialization">
    <source context="language" id="on"/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

We replaced the **type** with the **states** attribute on our **assign** element, which will always get us the translation when the phone boots up and the button is in the current state. Also we changed the **context** attribute to **language** which tells the phone to look for the translation of our **id** attribute. But we also need to handle the translation when the button is pressed, to do so, we are going to add two more **assign** elements.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
  <array name='label' separator=',' value='Hide own outgoing ID,off'/>
  <array name='label_x' separator=',' value='5,5'/>
  <array name='label_y' separator=',' value='2,15'/>
  <array name='label_width' separator=',' value='74,95'/>
  <array name='label_height' separator=',' value='13,24'/>
  <array name='label_align' separator=',' value='left,center'/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign type="update on change" when="after initialization">
    <source context="setting" id="privacy_out"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign states="off" when="after initialization">
    <source context="language" id="off"/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign states="on" when="after initialization">
    <source context="language" id="on"/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign when="on press" states="off">
    <source context='language' id='on'/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign when="on press" states="on">
    <source context='language' id='off'/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

The two new **assign** elements look similar to our XML Definition code from the part 1, where we are changing the value of the button **state**. But with the difference that we are now putting the translated value into our **label** array on the second position. The above XML Definition code is just for the **state** of our button. Now we are going to translate the **label** text from the first position and don't worry, since that part of our label is always static we just need to add one more **assign** for it.

```xml
<general type="PrivacyToggle" />
<initialization>
  <state value="off"/>
  <array name='label' separator=',' value='Hide own outgoing ID,Off'/>
  <array name='label_x' separator=',' value='5,5'/>
  <array name='label_y' separator=',' value='2,15'/>
  <array name='label_width' separator=',' value='74,95'/>
  <array name='label_height' separator=',' value='13,24'/>
  <array name='label_align' separator=',' value='left,center'/>
</initialization>
<action>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=on" when="on press" states="off"/>
  <url target="http://localhost/settings.htm?settings=save&privacy_out=off" when="on press" states="on"/>
  <assign type="update on change" when="after initialization">
    <source context="setting" id="privacy_out"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign states="off" when="after initialization">
    <source context="language" id="off"/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign states="on" when="after initialization">
    <source context="language" id="on"/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign when="on press" states="off">
    <source context='language' id='on'/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign when="on press" states="on">
    <source context='language' id='off'/>
    <destination context="this entity" id="label[1]"/>
  </assign>
  <assign type="update on change" when="after initialization">
    <source context="language" id="privacy_out"/>
    <destination context="this entity" id="label[0]"/>
  </assign>
  <assign when="on press" states="on">
    <source context="this entity" value="off"/>
    <destination context="this entity" id="state"/>
  </assign>
  <assign when="on press" states="off">
    <source context="this entity" value="on"/>
    <destination context="this entity" id="state"/>
  </assign>
</action>
```

This assign looks similar to our XML Definition Code we done in part 2, with the difference that we are now looking for the translation of our Text and by assigning it on the label's first position.As you already saw as you were writing the above code, we now have the **source: context** set to **language** and we are searching for the value of our Option **privacy_out**.
 
**NOTE:** To find the keyword you need to be translated please search for your text in the below XML file and use the **n** attribute value to but as the **id** in the translation **source** elements. 
*See the translation XML file at: http://provisioning.snom.com/config/snomlang-8.7.4/gui_lang_EN.xml*

# Extension Monitoring example

This example is about creating a XML Definition key which would monitor a remote extension and depending on its state light with different Color and performs different Actions on a Button press.

## Part 1: Busy Lamp Field

As the first step we need to define our XML Definition Code. To do so we need to write a **general** element as the first line of our code:

```xml
<general type="BusyLampField" identity="1"/>
```

In the **general** element we write the information's which are required by the phone to create a function and assign it to an identity.The **type** attribute is the name of our function and can be shown in the Phone User Interface as an Option or in some cases we use it to reference to this XML Definition code from another XML Definition code. 

The next step would be to add the initialization and assign a state to our button and add a variable for the remote extensions SIP URI:

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
```

The **initialization** element allows us to define an initial state for a button, a variable and/or an array. In this particular case we will add the **state** and give it the initial value **off** and add a **variable** named **subscr_uri** which would have the SIP URI of our remote monitored extension as value. 

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
<state value="off"/>
<variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
```

With the **subscription** element we told the phone to send a SIP SUBSCRIBE message, like the one below. To use our previous defined variables we put the name into $(...). 

**NOTE:** That depending on the PBX on which you want to subscribe there are a few different **types** which can be used. Also the values like "<" and ">" need to be encoded like "&lt;" and "&gt;".

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
```

At this step we added Parsing Rules to our XML Definition Code, which would take the SIP NOTIFY messages we receive on the phone and extract the data to our new variables.

```xml
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
```

The **NotifyParsingRules** element container has a few functionalities, but they all are parsing the incoming SIP NOTIFY messages. This rule with the **type** attribute set as **applies**, will tell the phone which SIP NOTIFY messages belong to that particular button. In the **NotifyParsingRules** element container we put new elements named **level**. This (**level**) elements are condition elements, if the condition inside the tags (*/dialog-info[@entity="$(subscr_uri)"]*) is matched, the **applies** element get the value (OK) which is defined in the **translates_to** attribute.

```xml
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
```

Here we do the same as in the part of code before it, we are matching for the conditions and if it is successful we assign the value to the state. However we have here multiple **level** elements, which if the first condition is matched we try to match the second one too.

```xml
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
```

At this part of the code we are fetching particular parts of our SIP NOTIFY message and assign them to our new variables (**call_id**), but like in **assign** elements we can say the phone in which state it should look for the call_id and then assign it. The same we did for **local_tag**, **remote_tag**, **remote_name** and **remote_uri**. This can be done for anything we receive in the SIP NOTIFY.
The last step would be to add some functionality to our button press.

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action> 
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on press"/> 
</action>
```

We added two **invite** elements in our **action** element container. Both of them will execute a call but with different parameters depending on the monitored extensions **state**. The first **invite** element will sent an INVITE message (initiate a call) if the remote monitored extension is in the **ringing** state and also adds to the INVITE message the required SIP headers like **request_uri** and **replaces** to pick up the ringing call. The second **invite** element will be execute just if the previous one isn't and will dial only the number from our remote monitored extension.

## Part 2: Limiting Actions on specific **states**

Most users would like to limit the actions depending on the state the called party is in. That is what we are going to do now for our second **invite** element.

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action> 
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on press" states="free,offhook"/> 
</action>
```

We added here the condition, that when our remote monitored extension is **free** (in idle) or in **offhook** we are going to dial the number of the remote extensions. In all other cases (in_a_call, etc.) we are going to ignore the button press.

## Part 3: LED Control

Sometimes we would like to change the default LED behavior and color depending on the **state** of our remote monitored extension. To do so, we use the **translate_to** attributes values (e.g. ringing, calling, in_a_call, free, etc.) which we defined in the **NotifyParsingRules** element container for the **type=state** and put them in the appropriate phone settings like **led_on, led_blink_slow, led_blink_medium, led_red, led_green, etc.**. Below a small example:

```
led_on!: ON BUSY IN_A_CALL CALLING IN_A_MEETING URGENT_INTERRUPTIONS_ONLY DND UNAVAILABLE ACTIVE INACTIVE BE_RIGHT_BACK AWAY SEIZED CONNECTED ON_HOLD OFFHOOK RINGBACK PhoneHasCall PhoneHasMissedCalls AVAILABLE CurrentIdentityHasVoiceMessages FREE
led_blink_slow!: PARKED HOLDING PhoneHasCallInStateHolding OFFHOOK
led_blink_medium!: RECORDING MESSAGE
led_blink_fast!: RINGING PICKUP PhoneHasCallInStateRinging
led_blink_short_off!: PhoneHasMissedCalls
led_red!: BUSY IN_A_CALL CALLING IN_A_MEETING URGENT_INTERRUPTIONS_ONLY HOLDING DND I-Am-Busy 
led_green!: AVAILABLEI-Am-Ready I-Am-Almost-Ready FREE
led_orange!: AWAY INACTIVE BE_RIGHT_BACK 
led_blue!: 
led_red_green!: OFFHOOK
led_red_orange!: 
led_green_orange!:
```

Since by default snom phones doesn't have the state **free** defined, we just added it to light green. Also above we changed the **offhook** from lighting red to be slow blinking red and green. So now we know what exactly is happening on the remote monitored extension.

**NOTE:** If you are using a predefined **state** like **OFFHOOK** and would like to assign it to another behavior or color, please take care that you remove it from the previous (old) setting.
The same can be done with Virtual keys on the snom 8xx phones, the only difference is that we use different settings:

```
vkey_red!: RINGING DND RECORDING PICKUP
vkey_green!: CONNECTED AVAILABLE 
vkey_orange!: HOLDING ON_HOLD PARKED ON CALLING RINGBACK SEIZED OFFHOOK MESSAGE
vkey_blue!:
```

## Part 4: Transferring call with SIP REFER depending on own state

In this part we are going to build in a transfer action if we are already in a call to the remote monitored extension. As first we are going to take our previous XML Definition Code from Part 1 and add our new transfer functionality. 

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action>
  <assign when="on press">
    <source context="this entry" value=""/>
    <destination context="this entry" id="transfer_id"/>
  </assign>
  <assign when="on press">
    <source context="call" id="id" require="${state}==connected"/>
    <destination context="this entry" id="transfer_id"/>
  </assign>
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on press" states="free,offhook"/> 
</action>
```

As first we added two **assign** elements, first one will clear our new variable **transfer_id** and the second one will populate with the internal ID of our connected call.

```xml
<assign when="on press">
  <source context="call" id="id" require="${state}==connected"/>
  <destination context="this entry" id="transfer_id"/>
</assign>
```

*Get the internal call id for the call which state is connected and put the value into our local variable named trasfered_id*

**NOTE:** The states in **require** tags are case sensitive and need to be written lower case.

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action>
  <assign when="on press">
    <source context="this entry" value=""/>
    <destination context="this entry" id="transfer_id"/>
  </assign>
  <assign when="on press">
    <source context="call" id="id" require="${state}==connected"/>
    <destination context="this entry" id="transfer_id"/>
  </assign>
  <assign when="on press">
    <source context="this entry" id="state"/> 
    <destination context="this entry" id="state_save"/>
  </assign>
  <assign when="on press">
    <source context="this entry" value="transferring"/> 
    <destination context="this entry" id="state" require="$(transfer_id)!= "/>
  </assign>
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on press" states="free,offhook"/> 
</action>
```

And we added two more **assign** elements to our XML Definition Code, the first one is going to backup (or save) our current state into our new variable **state_save** and the second assign is going to check if the **transfer_id** is set (and not EMPTY) to change our button state to **transferring**. 
Our last steps in this part of the example are to add our **refer** element which will set a SIP REFER message to our PBX to Transfer our connected call. Also it will revert our saved (backup) state back to the button.

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action>
  <assign when="on press">
    <source context="this entry" value=""/>
    <destination context="this entry" id="transfer_id"/>
  </assign>
  <assign when="on press">
    <source context="call" id="id" require="${state}==connected"/>
    <destination context="this entry" id="transfer_id"/>
  </assign>
  <assign when="on press">
    <source context="this entry" id="state"/> 
    <destination context="this entry" id="state_save"/>
  </assign>
  <assign when="on press">
    <source context="this entry" value="transferring"/> 
    <destination context="this entry" id="state" require="$(transfer_id)!= "/>
  </assign>
  <refer target="$(subscr_uri)" source="$(transfer_id)" when="on release" states="transferring"/>
  <invite target="$(remote_name)<$(remote_uri)>" when="on release" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on release" states="free,offhook"/>
  <assign when="on release">
    <source context="this entry" id="state_save"/> 
    <destination context="this entry" id="state"/>
  </assign>
</action>
```

Also we changed the **when** attributes on our **invite** elements to eliminate unexpected calls being done.

# Referencing to other XML Definition Codes

Sometimes it is very helpful to reference to a different XML Definition Code, no matter if it's another Function key or a **general_purpose_xml_descriptions**.  In this part of the example we are going to show you how perform different action depending on a **general_purpose_xml_descriptions** Code variable.

In Asterisk like environments you are able to to SUBSCRIBE to your oven Extension state to know if it is in a call or not. So that is what we are going to do now. So in this part we will create a XML Definition Code for monitoring our own state and put it into a **general_purpose_xml_descriptions** setting.

Then we will use our XML Definition code from the 1st part of the example and adopt it to reference to our own state which is in the **general_purpose_xml_descriptions** setting.

```xml
<general type='PhoneState'/>
<initialization>
  <variable name='current_state' value=''/>
  <variable name='own_subscr_uri' value='sip:102@pbx.local'/>
  <state value='initial'/>
</initialization>
<subscription type='dialog' to='&lt;$(own_subscr_uri)&gt;' for='$(own_subscr_uri)'/>
<NotifyParsingRules type='applies'>
  <level1 translates_to='OK'>/dialog-info[@entity='$(own_subscr_uri)']</level1>
</NotifyParsingRules>
<NotifyParsingRules type='state'>
  <level1 translates_to='me_in_a_call'>/dialog-info/dialog/state[.='early']</level1>
  <level2 translates_to='me_in_a_call'>/dialog-info/dialog/state[.='proceeding']</level2>
  <level3 translates_to='me_in_a_call'>/dialog-info/dialog/state[.='confirmed']</level3>
  <level4 translates_to='me_offhook'>/dialog-info/dialog/state[.='trying']</level4>
  <level5 translates_to='me_free'/>
</NotifyParsingRules>
<NotifyParsingRules type='variable' id='remote_name'>
  <level1 fetch_attribute='display'>/dialog-info/dialog/remote/identity[@display]</level1>
  <level2 fetch_attribute='uri'>/dialog-info/dialog/remote/target[@uri]</level2>
</NotifyParsingRules>
<NotifyParsingRules type='variable' id='local_name' states='offhook,free'>
  <level1 fetch_attribute='display'>/dialog-info/dialog/local/identity[@display]</level1>
  <level2 fetch_attribute='uri'>/dialog-info/dialog/local/target[@uri]</level2>
</NotifyParsingRules>
<NotifyParsingRules type='variable' id='call_id' states='ringing'>
  <level1 fetch_attribute='call-id'>/dialog-info/dialog[@call-id]</level1>
</NotifyParsingRules>
<NotifyParsingRules type='variable' id='remote_tag' states='ringing'>
  <level1 fetch_attribute='remote-tag'>/dialog-info/dialog[@remote-tag]</level1>
</NotifyParsingRules>
<NotifyParsingRules type='variable' id='local_tag' states='ringing'>
  <level1 fetch_attribute='local-tag'>/dialog-info/dialog[@local-tag]</level1>
</NotifyParsingRules>
<NotifyParsingRules type='variable' id='remote_uri' states='ringing'>
  <level1 fetch_attribute='uri'>/dialog-info/dialog/remote/target[@uri]</level1>
</NotifyParsingRules>
<action>
  <assign when='on notify'>
    <source context='local' id='state'/>
    <destination context='local' id='current_state'/>
  </assign>
</action> 
```

The XML Definition Code for our own extension state looks similar to the code from the 1st part. We changed the name of our XML Definition code in the **general** element, because we are going to use this name later on for referencing to this code and we added a new **variable** element which will contain our own state.

Also we changed the **translate_to** attributes values to contain **me_** in front.

That will help us later on to decide which action we are going to perform. And at the end of the code we added an **assign** element which will be executed **on notify**, when a SIP NOTIFY message arrives and puts the state of our monitored extension (our own SIP URI) into our new variable **current_state**.

Now our next step is to use the XML Definition Code from our 1st part and adopt it to reference to the above (own extension's state) XML Definition Code.

```xml
<general type="BusyLampField" identity="1"/>

<initialization>
  <state value="off"/>
  <variable name='subscr_state' value='initial'/>
  <variable name='subscr_num' value='' />
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>

<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>

<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>

<action> 
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on press"/> 
</action>
```

As first we added two new **variable** elements, which we are going to use to save the subscribers number and state.

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name='subscr_state' value='initial'/>
  <variable name='subscr_num' value='' />
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action>
  <assign when='on press'>
    <source context='local' id='subscr_uri' value_match='(sip:)?(.*)@.*' value_replace='$2'/>
    <destination context='local' id='subscr_num'/>
  </assign>
  <assign when='on press'>
    <source context='this entry' id='state'/>
    <destination context='this entry' id='subscr_state'/>
  </assign>
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on press"/> 
</action>
```

With the two new **assign** elements we are going to fill our new variables. The first one will take the **subscr_uri** value and extract the number from it, thanks to the RegEX we wrote in the **value_match** attribute and the **value_replace** attribute where we defined which part of the RegEx would be saved into the **subscr_num** variable. Also we copied the button **state** value into our new **subscr_state** variable. 

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name='subscr_state' value='initial'/>
  <variable name='subscr_num' value='' />
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action>
  <assign when='on press'>
    <source context='local' id='subscr_uri' value_match='(sip:)?(.*)@.*' value_replace='$2'/>
    <destination context='local' id='subscr_num'/>
  </assign>
  <assign when='on press'>
    <source context='this entry' id='state'/>
    <destination context='this entry' id='subscr_state'/>
  </assign>
  <assign when='on press'>
    <source context='all xml entities' id='current_state' require1='${type}==PhoneState' require2='${current_state}==me_in_a_call'/>
    <destination context='this entry' id='state'/>
  </assign>
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <invite target="$(subscr_uri)" when="on press"/> 
  <assign when='on release'>
    <source context='this entry' id='subscr_state'/>
    <destination context='this entry' id='state'/>
  </assign>
</action>
```

In the above code we added **assign** elements to get our own phones state and to revert the remote monitored extension state back, when we are done with our actions. The second assign will be executed on the release of the button.

```xml
<assign when='on press'>
  <source context='all xml entities' id='current_state' require1='${type}==PhoneState' require2='${current_state}==me_in_a_call'/>
  <destination context='this entry' id='state'/>
</assign>
```

*When the button gets pressed, get all XML Definition Codes where the type is PhoneState and if in that Code the current_state has the value of me_in_a_call, assign current_state value to our state variable.*

Our last step would be to add an Action if we are in a call.

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
  <state value="off"/>
  <variable name='subscr_state' value='initial'/>
  <variable name='subscr_num' value='' />
  <variable name="subscr_uri" value="sip:548@pbx.local"/>
</initialization>
<subscription type="dialog" to="&lt;$(subscr_uri)&gt;" for="$(subscr_uri)"/>
<NotifyParsingRules type="applies"> 
  <level1 translates_to='OK'>/dialog-info[@entity="$(subscr_uri)"]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="state">
  <level1 translates_to="ringing">/dialog-info/dialog/state[.="early"]</level1>
  <level1-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level1-1>
  <level2 translates_to="ringing">/dialog-info/dialog/state[.="proceeding"]</level2>
  <level2-1 translates_to="calling">/dialog-info/dialog[@direction="initiator"]</level2-1>
  <level3 translates_to="in_a_call">/dialog-info/dialog/state[.="confirmed"]</level3>
  <level4 translates_to="offhook">/dialog-info/dialog/state[.="trying"]</level4>
  <level5 translates_to="free"/>
</NotifyParsingRules>
<NotifyParsingRules type="variable" id="call_id" state="ringing"> 
  <level1 fetch_attribute="call-id">/dialog-info/dialog[@call-id]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_tag" state="ringing"> 
  <level1 fetch_attribute="remote-tag">/dialog-info/dialog[@remote-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="local_tag" state="ringing"> 
  <level1 fetch_attribute="local-tag">/dialog-info/dialog[@local-tag]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_uri" state="ringing"> 
  <level1 fetch_attribute="uri">/dialog-info/dialog/remote/target[@uri]</level1> 
</NotifyParsingRules> 
<NotifyParsingRules type="variable" id="remote_name" state="ringing"> 
  <level1 fetch_attribute="display">/dialog-info/dialog/remote/identity[@display]</level1> 
</NotifyParsingRules>
<action>
  <assign when='on press'>
    <source context='local' id='subscr_uri' value_match='(sip:)?(.*)@.*' value_replace='$2'/>
    <destination context='local' id='subscr_num'/>
  </assign>
  <assign when='on press'>
    <source context='this entry' id='state'/>
    <destination context='this entry' id='subscr_state'/>
  </assign>
  <assign when='on press'>
    <source context='all xml entities' id='current_state' require1='${type}==PhoneState' require2='${current_state}==me_in_a_call'/>
    <destination context='this entry' id='state'/>
  </assign>
  <invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
  <dtmf target='*$(subscr_num)' when='on release' states='me_in_a_call'/>
  <invite target="$(subscr_uri)" when="on press"/> 
  <assign when='on release'>
    <source context='this entry' id='subscr_state'/>
    <destination context='this entry' id='state'/>
  </assign>
</action>
```

Our new **dtmf** element which we also put into our **action** element container, will sent a DTMF code with a * (asterisk) and the number our remote monitored extension, but just if we (our phone) are in a call.
