## callbacks with boolean type argument

!!! Demo
    [Try on your phone](xml/cb_boolean_callbacks.xml)

These include following callbacks:

* *bool_eval*
* *on_off*
* *x_o*
* *yes_no*

!!! Info
    * If you want to use your own language as argument in XML file, check also if the phone, which is parsing the file, is in correct PUI language.
    * Please write *0* or *false* if you want to ensure to get *false* result from the callback instead of writing empty argument or not writing it at all.

```xml
{!docs/xml_minibrowser/examples/xml/cb_boolean_callbacks.xml!}
```
