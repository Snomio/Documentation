# Debugging

Very often it is required to debug the XML Definition Code to check why is something not working or to understand how something works for better development of the Code. There are a few ways to debug XML Definition Code.

## Syntax check XML Definition Code

The best way to check if your XML Definition Code has Syntax issues is by downloading the phone settings after the Code has been inserted onto the phone. 

The parts of our XML Definition Code where a Syntax error exists will not be saved on the phone.

I would suggest using the Plain text Settings, because it is easier to read the XML Definition code without the regular XML Settings. 


## Execution check 

To see if a part of you Code has been executed (mostly the action elements), you will find them in the Phone Regular Logs from Level 7+.  Below an example of a Setting Toggle XML Definition Code:

```
Apr  2 18:30:58  [DEBUG2] PHN: gui_object::OnKey(P1, 1), State Idle (29)
Apr  2 18:30:58  [DEBUG0] PHN: ReplaceQueryVariables in >http://localhost:80/settings.htm?settings=save&privacy_out=off<
Apr  2 18:30:58  [DEBUG0] PHN: ReplaceQueryVariables replaced: >http://localhost:80/settings.htm?settings=save&privacy_out=off<
Apr  2 18:30:58  [NOTICE] PHN: Sending post request http://localhost:80/settings.htm?settings=save&privacy_out=off
Apr  2 18:30:58  [NOTICE] PHN: Fetching URL: http://:...@localhost:80/settings.htm?...
Apr  2 18:30:58  [DEBUG2] WEBCLIENT: Send TCP none
Apr  2 18:30:58  [DEBUG2] WEBCLIENT: Socket 386 dns_resolving
Apr  2 18:30:58  [DEBUG2] PHN: TMR: setting up  'gui_state.cpp (792): [static void gui_object::DisplayStateCbAtNextLoop(void*, void*)]' 0x40879274 to fire periodically every 250 ms 
Apr  2 18:30:58  [DEBUG1] DNS: Add Cache: localhost.snom.com= (ttl=60, type=7)
Apr  2 18:30:58  [DEBUG0] DNS: AddrInfo for 'localhost.snom.com' invalid, error: Name or service not known (-2)
Apr  2 18:30:58  [WARN  ] PHN: Could not resolve host >localhost<
Apr  2 18:30:58  [DEBUG2] WEBCLIENT: Socket 386 dns_resolve_cache_lookup_has_failed
Apr  2 18:30:58  [WARN  ] WEBCLIENT: Could not resolve host localhost
Apr  2 18:30:58  [DEBUG2] WEBCLIENT: Socket 386 disconnected
Apr  2 18:30:58  [DEBUG2] WEBCLIENT: Socket 386 deleted
Apr  2 18:30:58  [NOTICE] PHN: Server rejected Action URL request with 400 ><
```

You may see here that "localhost" could not be resolved by our DNS server and that is why my Toggle is not working.

## Variable check
It might be useful to know which value or what variables have been used/set in the code. To do that we are going to open the following URL in our Browsers: http://PHONE_IP/xml_entities.htm

There we will find all the xml_entities split into categories of button and setting types:

- **LineKey** are the Free programmable Function keys
- **ContextKey** are the 4 keys below the Display
- **NaviKey** the navigation keys
- **HardKey** are the hardcoded keys like *dnd, directory, menu, transfer, etc*
- **SpringboardKey** are available only on snom 870 phones and are the Virtual Keys in idle
- **GeneralPurposeXml** are the **general_purpose_xml_descriptions** settings on the phone
- **XmlsForEventListUri** are the **user_event_list_uri** settings on the phone
By selecting a category you will get a list of index for that button or setting, each of them can contain a XML Definition Code.

Here is an example of our XML Definition Code from **Extension Monitoring** example the 4th part:

```
#type: 	BusyLampField
#state: 	free
#variables:
  call_id = 313339363334363736333230373839-axkw6vc64k0g
  identity = 1
  local_tag = 9th5orwan7
  remote_name = 2902
  remote_tag = lhbva8lq73
  remote_uri = sip:547@10.110.100.110:3072;line=wxecg2hg
  state_save = free
  subscr_uri = sip:548@pbx.local
  transfer_id = -15
#arrays:
```

Here we see all the values of our XML Definition Variables we defined in the code.
