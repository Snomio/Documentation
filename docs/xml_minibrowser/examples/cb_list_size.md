## list_size callback

!!! Demo
    * **Example 1**: [Try on your phone](xml/cb_list_size1.xml)
    * **Example 2**: [Try on your phone](xml/cb_list_size2.xml)

* The number of list size is based on where the callback is called. On example code 1, rather than return number 5, which is the amount of *MenuItem*, the callback return 3 as result.
* On *SnomIPPhoneText* on example code 2, this is not limited when the line is differentiate by `<br/>`. The lorem ipsum text add more additional lines and make the *list_size* callback return 6 as result.

**Example 1**: Get list size of simple *MenuItem*

```xml
{!docs/xml_minibrowser/examples/xml/cb_list_size1.xml!}
```

**Example 2**: Get list size of simple *MenuItem*

```xml
{!docs/xml_minibrowser/examples/xml/cb_list_size2.xml!}
```
