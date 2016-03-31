## lastsel callback

!!! Demo
    [Try on your phone](xml/cb_lastsel.xml)

!!! Warning
    This documentation section is for *sel* and *lastsel* callbacks

**Usage hints:**

* See also *http://phone_ip/minibrowser.htm?show=RENDERED_XML* when running example code for *sel* callback result.
* *sel* Value is the id of the *menu* / *menuitem* where the cursor is located
    * Into the *RENDERED_XML* phone web page: this will actually show the actual *menu* / *menuitem* id when you refresh the page 
    * In PUI (phone display): it will only show the first *menu* / *menuitem* id, when it is not in the first *menu* / *menuitem*
* *lastsel* Value is the id of the last *menuitem* id where the cursor in the last *menu* located. As example when you change from first *menu* to second *menu* the *lastsel* callback will return id of the *menuitem* in first *menu*, where the cursor was last located.

Instruction example for example code

```
step1:select first menu (l1menu1)
step2:move the cursor to fourth position (l2mi4)
step3:press X (go back to first layer)
step4:select l1menu2
Result taken from state_of_gui.htm:
   →l2mi1:,l2m1mi4
    l2mi2:l2m2mi1,l2m1mi4
    l2mi3:l2m2mi1,l2m1mi4
    l2mi4:l2m2mi1,l2m1mi4
```

Example: Show the callback result in various menu* and *menuitem* combination.

```xml
{!docs/xml_minibrowser/examples/xml/cb_lastsel.xml!}
```
