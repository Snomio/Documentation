# Replacement plan

Sometimes the build-in Function key behaviors doesn't meet our requirements and we would not like to write a XML Definition Code each time again to put it on our phones. That is why snom phones have **replacement_plan** elements. Which allow you to change the default functionality of a Function key to your own (designed with XML Definition Code).

Below we are going to show you an example which is used by our Broadsoft customers and is replacing the **Contact Buddy List** option.

**NOTE:** That this needs to be uploaded to the phone with Provisioning, either in the *<settings>* tag or as an individual XML file which is being listed in the *<settings-files>* tag.

```xml
<ReplacementPlan>
  <key id="ResourceListBuddy" wui_translation_key="fkeys_ssi_buddy_from_server_list"/>
  </key>
  <setting_replacement id="user_event_list_uri"/>
  </setting_replacement>
</ReplacementPlan>
```

The replacement plans start with a **ReplacmentPlan** root element container, which can have one or more **key** and **setting_replacement** element containers.

**key** element container defines a key type which will be displayed in the Web User Interface on the Function key page and contains two attributes. **id** is a identifier which is used for deleting or altering the keys later and **wui_translation_key** is used to find the correct translation for the key when it's listed in the Web User Interface. 

**NOTE:** If the **wui_translation_key** is not part of the translation-map, it will be used directly to describe the key in the Web User Interface.

```xml
<ReplacementPlan>
	<key id="ResourceListBuddy" wui_translation_key="fkeys_ssi_buddy_from_server_list">
	<general type='ResourceListBuddy'/>
	<initialization>
		<variable name='ui_argument' value=''/>
		<variable name='ui_label' value=''/>
		<state value='initial'/>
	</initialization>
	<NotifyParsingRules type='applies'>
		<level1 translates_to='OK'>Header:Content-ID==<$(ResourceCid)></level1>
	</NotifyParsingRules>
	<NotifyParsingRules type='state'>
		<level1 translates_to='ringing'>/dialog-info/dialog/state[.='early']</level1>
		<level1-1 translates_to='calling'>/dialog-info/dialog[@direction='initiator']</level1-1>
		<level2 translates_to='ringing'>/dialog-info/dialog/state[.='proceeding']</level2>
		<level2-1 translates_to='calling'>/dialog-info/dialog[@direction='initiator']</level2-1>
		<level3 translates_to='in_a_call'>/dialog-info/dialog/state[.='confirmed']</level3>
		<level4 translates_to='offhook'>/dialog-info/dialog/state[.='trying']</level4>
		<default translates_to='free'/>
	</NotifyParsingRules>
	<NotifyParsingRules type='array' id='local_uris'>
		<level1 fetch_attribute='uri'>/dialog-info/dialog/local/target[@uri]</level1>
		<level2 fetch_content='true'>/dialog-info/dialog/local/identity</level2>
	</NotifyParsingRules>
	<NotifyParsingRules type='variable' id='label'>
		<level1 fetch_attribute='display'>/dialog-info/dialog/local/identity[@display]</level1>
	</NotifyParsingRules>
	<action>
		<assign when='on notify'>
			<source value=''/>
			<destination id='call_me_uri'/>
		</assign>
		<assign when='on notify'>
			<source id='local_uris'/>
			<destination id='call_me_uri' require1='$(local_uris[$(index)])>=tel:' require2='$(local_uris[$(index)])<tel;'/>
		</assign>
		<assign when='on notify'>
			<source id='local_uris'/>
			<destination id='call_me_uri' require1='$(call_me_uri)=='/>
		</assign>
		<assign when='on notify'>
			<source id='call_me_uri' value_match='.*ext=(.*)' value_replace='*97$1'/>
			<destination id='pick_up_tel'/>
		</assign>
		<dial target='$(pick_up_tel)' when='on press' state='ringing'/>
		<dial target='$(call_me_uri)' when='on press'/>
		</action>
	</key>
	<setting_replacement id="user_event_list_uri">
	</setting_replacement>
</ReplacementPlan>
```

We added a regular XML Definition Code into our **key** element container, which is parsing our NOTIFY and assign values to our variables. Maybe you already saw that in the above Code there is no **subscription** element and you ask yourselves how are we going to subscribe for notifies. So since we want it to be dynamic and allow users to enter their own value where to subscribe we are going to put it into the **settings_replacment** element container.

**setting_replacment** element container contains the XML Definition Code which will be used if the setting is set. This element container has one attribute named **id**, which tells the phone which setting behavior should be replaced. 

At the moment the only valid ID (setting) is **user_event_list_uri**. Also this element container has two Public variables which contain our Setting Value and index of our identity. 

```xml
<ReplacementPlan>
	<key id="ResourceListBuddy" wui_translation_key="fkeys_ssi_buddy_from_server_list">
	<general type='ResourceListBuddy'/>
	<initialization>
		<variable name='ui_argument' value=''/>
		<variable name='ui_label' value=''/>
		<state value='initial'/>
	</initialization>
	<NotifyParsingRules type='applies'>
		<level1 translates_to='OK'>Header:Content-ID==<$(ResourceCid)></level1>
	</NotifyParsingRules>
	<NotifyParsingRules type='state'>
		<level1 translates_to='ringing'>/dialog-info/dialog/state[.='early']</level1>
		<level1-1 translates_to='calling'>/dialog-info/dialog[@direction='initiator']</level1-1>
		<level2 translates_to='ringing'>/dialog-info/dialog/state[.='proceeding']</level2>
		<level2-1 translates_to='calling'>/dialog-info/dialog[@direction='initiator']</level2-1>
		<level3 translates_to='in_a_call'>/dialog-info/dialog/state[.='confirmed']</level3>
		<level4 translates_to='offhook'>/dialog-info/dialog/state[.='trying']</level4>
		<default translates_to='free'/>
	</NotifyParsingRules>
	<NotifyParsingRules type='array' id='local_uris'>
		<level1 fetch_attribute='uri'>/dialog-info/dialog/local/target[@uri]</level1>
		<level2 fetch_content='true'>/dialog-info/dialog/local/identity</level2>
	</NotifyParsingRules>
	<NotifyParsingRules type='variable' id='label'>
		<level1 fetch_attribute='display'>/dialog-info/dialog/local/identity[@display]</level1>
	</NotifyParsingRules>
	<action>
		<assign when='on notify'>
			<source value=''/>
			<destination id='call_me_uri'/>
		</assign>
		<assign when='on notify'>
			<source id='local_uris'/>
			<destination id='call_me_uri' require1='$(local_uris[$(index)])>=tel:' require2='$(local_uris[$(index)])<tel;'/>
		</assign>
		<assign when='on notify'>
			<source id='local_uris'/>
			<destination id='call_me_uri' require1='$(call_me_uri)=='/>
		</assign>
		<assign when='on notify'>
			<source id='call_me_uri' value_match='.*ext=(.*)' value_replace='*97$1'/>
			<destination id='pick_up_tel'/>
		</assign>
		<dial target='$(pick_up_tel)' when='on press' state='ringing'/>
		<dial target='$(call_me_uri)' when='on press'/>
		</action>
	</key>
	<setting_replacement id="user_event_list_uri">
		<general type='ResourceListSubscription'/>
		<initialization>
			<variable name='setting_value' value=''/>
			<variable name='setting_index' value=''/>
			<identity value='$(setting_index)'/>
			<variable name='subscr_uri' value='sip:$(setting_value);user=phone'/>
			<state value='initial'/>
		</initialization>
		<subscription type='dialog-list' to='<$(subscr_uri)>' for='$(subscr_uri)'/>
		<NotifyParsingRules type='applies'>
			<level1 translates_to='OK'>/list[@uri='$(subscr_uri)']</level1>
		</NotifyParsingRules>
		<NotifyParsingRules type='state'>
			<level1 translates_to='full'>/list[@fullState='true']</level1>
			<level2 translates_to='partial'/>
		</NotifyParsingRules>
		<NotifyParsingRules type='array' id='cids'>
			<level1 fetch_attribute='cid'>/list/resource/instance</level1>
		</NotifyParsingRules>
		<NotifyParsingRules type='array' id='uris'>
			<level1 fetch_attribute='uri'>/list/resource</level1>
		</NotifyParsingRules>
		<action>
			<assign state='full'>
				<source value='no buddy'/>
				<destination context='all' id='state' require1='${type}==ResourceListBuddy'/>
			</assign>
			<assign state='full'>
				<source value=''/>
				<destination context='all' id='BuddyUri' require1='${type}==ResourceListBuddy'/>
			</assign>
			<assign state='full'>
				<source context='local' id='uris'/>
				<destination context='all' id='BuddyUri' require1='${type}==ResourceListBuddy' require2='${BuddyUri}=='/>
			</assign>
			<assign when='on notify'>
				<source context='local' id='cids'/>
				<destination context='all' id='ResourceCid' require1='${type}==ResourceListBuddy' require2='${BuddyUri}==$(uris[$(index)])'/>
			</assign>
		</action>
	</setting_replacement>
</ReplacementPlan>
```

We added the XML Definition Code which will make a SUBSCRIBE to your **dialog-list** events and parse the NOTIFYs to our new Variables which we automatically thanks to the Referencing send to our Function keys with our type we defined in the **id** attribute of our **key** element container.

```xml
<initialization>
	<variable name='setting_value' value=''/>
	<variable name='setting_index' value=''/>
	<identity value='$(setting_index)'/>
	<variable name='subscr_uri' value='sip:$(setting_value);user=phone'/>
	<state value='initial'/>
</initialization>
```

These two new variables are not mandatory; if our XML Definition Code doesn't contain them in **initialization** element container then they will be automatically added to the code. Or if there already set, the values will be updated with the values of our setting. 


