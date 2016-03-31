## empty callback

!!! Demo
    * **With value**: [Try on your phone](xml/cb_empty.xml#var:some_var=hello_world)
    * **Empty**: [Try on your phone](xml/cb_empty.xml)

This example code will return two different result depending of the existence of the content of variable *some_var*

If called with *http://server/thisexample.xml#var:some_var=hello_world*

**Result:**

```
Variable received
some_var:hello_world
```

If called only with *http://server/this.xml*

**Result:**

```
No variable received
```

```xml
{!docs/xml_minibrowser/examples/xml/cb_empty.xml!}
```
