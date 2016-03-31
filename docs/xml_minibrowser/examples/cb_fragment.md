## condition fragment

**Usage hints:**

* Arguments for fragment is case insensitive.
* If fragment variable get more than one value, the first value will be taken as the result by callback.

```
URI(without quotes) = 'http://abc.com/hello.xml#op=text' 
$(fragment:op) -> text
$(fragment:OP) -> text
$(fragment:oP) -> text
$(fragment:Op) -> text

URI(without quotes) = 'http://abc.com/hello.xml#op=text&op=1234' 
$(fragment:op) -> text
$(fragment:OP) -> text
$(fragment:oP) -> text
$(fragment:Op) -> text

URI(without quotes) = 'http://abc.com/hello.xml#op=1234&op=text' 
$(fragment:op) -> 1234
$(fragment:OP) -> 1234
$(fragment:oP) -> 1234
$(fragment:Op) -> 1234

URI(without quotes) = 'http://abc.com/hello.xml#op=1234&oP=text' 
$(fragment:op) -> 1234
$(fragment:OP) -> 1234
$(fragment:oP) -> 1234
$(fragment:Op) -> 1234
```
