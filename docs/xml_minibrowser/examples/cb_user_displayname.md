## user_displayname callback

!!! Demo
    [Try on your phone](xml/cb_user_displayname.xml)

Returns the displayname of given identity. Valid argument are number from 1 to 4 or 1 to 12 depending on your snom telephone max user registration

!!! Info
    * If no argument given, callback will return nothing.
    * If user_idle_text_idx is set, that value will be returned instead of user_realname_idx
    * See also [max_registrations](cb_max_registrations.md) example for better implementation of this example

```xml
{!docs/xml_minibrowser/examples/xml/cb_user_displayname.xml!}
```
