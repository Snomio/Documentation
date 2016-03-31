## applyline fragment 

!!! Demo
    [Try on your phone](xml/fr_applyline.xml)

Two different user id setting with and without *applyline* fragment.

```xml
{!docs/xml_minibrowser/examples/xml/fr_applyline.xml!}
```

If option with 'applyline' fragment is chosen, phone got following log:

```
Mar 18 07:28:32  [INFO  ] PHN: Xpath applies: *[@name="set id5 with applyline"]
Mar 18 07:28:32  [INFO  ] PHN: Xpath applies: @name="set id5 with applyline"]
Mar 18 07:28:32  [INFO  ] SIP: Registered at registrar as random_one@10.110.22.37 (Expires: 3600 secs)
```
