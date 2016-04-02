# XML Definition Functions

At the moment there are two types of Function in the XML Definition Code.
 
- **join** is used to combine multiple sources before assigning them to a variable/array
- **find_index** which allows us to determinate the index(s) of where a value(s) can be found in an array

The **function** element is a part of the **assign** element container and has a **name** attribute where we write our type into (**join** or **find_index**). Also depending on the function there could be additional attributes.

## join

Sometimes it is very useful to combine two values into one and to do so we are going to use the **join** function. We are going to take our Basic BLF example and add Labels to it so that we can change them:

```xml
<general type="BusyLampField" identity="1"/>
<initialization>
	<state value="off"/>
	<array name='label' separator=',' value='Remote Extensions Name, caller'/>
	<array name='label_x' separator=',' value='5,5'/>
	<array name='label_y' separator=',' value='2,15'/>
	<array name='label_width' separator=',' value='74,95'/>
	<array name='label_height' separator=',' value='13,24'/>
	<array name='label_align' separator=',' value='left,center'/>
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
	<assign type="on notify">
		<source context="this entity" id="remote_name"/>
		<source context="this entity" id="remote_uri"/>
		<function name="join" pattern="$(src0) Tel:$(src1)"/>
		<destination context="this entity" id="label[1]"/>
	</assign>
	<assign type="on notify" states="free,offhook,calling">
		<source context="this entity" id="state"/>
		<destination context="this entity" id="label[1]"/>
	</assign>
	<invite target="$(remote_name)<$(remote_uri)>" when="on press" state="ringing" request_uri="$(remote_uri)" replaces="$(call_id);to-tag=$(remote_tag);from-tag=$(local_tag)"/>
	<invite target="$(subscr_uri)" when="on press"/> 
</action>
```

We took our two variables we parsed before with our **NotifyParsingRules** and combined them to get a new value which we put in our second position in our label array. 

The attribute **pattern** allow us to define how to combine the values we want, e.g:
*pattern="$(src0) Tel:$(src1)"*  would mean like this  *$(remote_name) Tel: $(remote_uri)*

Of course you can have more sources which you would like to combine, the indexing of the (src) start always from the top one and it index is 0. Also if you have 4 sources the last one would be "src3".

## find_index

Sometimes you have a value(s) (variable or array) and you would like to check if it already exists in an array. 

For such cases we have the **find_index** function, it allows us to search for a value in an array and if it's exists there it also gives us its index in it. This might be helpful if we would like to change it later.

It also supports arrays and will allow you to search for each value from the first array in the second array and give you a new array with the indexes of all found values.

```xml
<assign when="on notify">
<source context="this entity" id="uris[]"/>
<source context="this entity" id="full_uris[]"/>
<function name="find_index"/>
<destination context="this entity" id="full_idx[]"/>
</assign>
```
*On an incoming SIP NOTIFY message, check each value from my first source (uris) if it exist in my second source (full_uris) and if so write his position from the second source to my destination (full_idx)*


**NOTE:** The result (destination) array will always have the same number of positions like the first (top) source. And if one of the values from the first source is not found in the second source, the position in the result (destination) array will be filed with an empty value.


