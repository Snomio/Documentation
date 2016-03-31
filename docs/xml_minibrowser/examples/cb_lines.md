## lines callback

!!! Demo
    [Try on your phone](xml/cb_lines.xml)

Returns number of calls. Can be filtered with parameter *lines:connected*. valid argument: connected, offered, offhook, auto_redial, holding, ringing, calling, invalid, on_hold, closed, ringback.

Example: Show all the number of lines in various state. When no argument given, the callback will give the sum of lines in various state

```xml
{!docs/xml_minibrowser/examples/xml/cb_lines.xml!}
```
