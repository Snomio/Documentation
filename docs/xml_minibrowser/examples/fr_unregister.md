## unregister fragment 

!!! Demo
    [Try on your phone](xml/fr_unregister.xml)

Uregister the identity(user) in phone. Valid argument : number from *0* to last number before phone max registration, or *-1* to unregister all identity.

Create a menu for unregistering phone identity.
The index used here is different with the one used in WUI, as in WUI it start from 1 (to up to 12 depending pn thephone model) and index for *unregister* fragment start from 0.
As example to unregister identity 4 (from WUI), phone can use this url http://mb_nop#unregister=3.

```xml
{!docs/xml_minibrowser/examples/xml/fr_unregister.xml!}
```
