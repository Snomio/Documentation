## action_ifc fragment 

!!! Demo
    [Try on your phone](xml/fr_action_ifc.xml)

Example format:

```
action_ifc:moduleid=make_some_request,param1=true,param2=false->varname
url.com#action_ifc:module.matcher=request,param1=true,param2=false->result_name
```

Change time from *date_time* module. Don't forget to add the IP address or hostname as minibrowser trusted host, when running this example.

```xml
{!docs/xml_minibrowser/examples/xml/fr_action_ifc.xml!}
```
