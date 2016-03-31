# Main Sub tags

All the main tags can contain the following sub tags:

## Conditional blocks

The **If, Elif, Else** tags are used as a conditional elements, depending on dynamic evaluations like callback expressions of the form $(...) for instance. This tags sequence must be start with **If** tag and end with **Else** tag, which both can only appear once under the parent element. The **Elif** tag is optional and can be written many time after **If** tag end and before **Else** tag start. This is especially useful for describing alternative child elements.

!!! Info
    You can see a **SnomIPPhoneMenu** usage example [here](../examples/main_subelements/#conditional_blocks#snomipphonetext)

### Valid Attributes

- **condition**: **If** and **Elif** tag only!. Only if this attribute evaluates to true, the sub elements are interpreted as elements at the position of the if element. This can be either a boolean value like *true* or *false* or a comparative expression with one of the following operators: *==*, *!=*, *>*, *<*, *>=*, *<=* Additionally you can invert the result by using a ! as first character.

## Repeats

Repeats the containing menu entries while iterating over a list of values and replacing certain parts with them.

!!! Info
    You can see a **Repeats** usage example [here](../examples/main_subelements/#repeat)

### Valid Attributes

* **values**: Contains a list of values, over which the repeat loop iterates. During each iteration to each given token the next value from that list is asigned. The first character is the seperator, and the list should also end with a seperator. Can't be combined with value_key and *var_ifc* attribute.
* **var_ifc**: Contains a composed-id indicating the variable exposed by the addressed variable interface.
* **token**: Contains a list of tokens. During each iteration each given token in the sub elements are replaced by the asigned values from the values list. The first character is the seperator, and the list should also end with a seperator. If combined with *var_ifc* attribute, the available token will be used as variable for the query.

Repeat tag exist as a sibling of a tag if that tag can don't have maximal occurrence limit.

## Title

The title that is displayed at the top of the screen when displaying the XML document. Don't use line break inside this tag.

## Fetch

Fetches the specified URL (probably another XML file) after a certain delay

### Valid Attributes

* **mil**: The delay in miliseconds, after which the URL is fetched

## SoftKeyItem

Reconfigures the functionality of a key and - in case of a context key - its screen label. The keys can be mapped to an URL that will be fetched or to another (virtual-)key.

### Valid Sub Tags

* **Name**: the name of the function key Example: F1, F2, F3, F4, F_REDIAL, F_CANCEL,... For a list of valid values see: [the wiki](http://wiki.snom.com/Settings/fkey/keyevent)
* **Label**: text for the screen label. Only applies to context keys.
* **SoftKey**: Key identifier to which the key is remapped to. Example: F_REDIAL, F_DND, F_CANCEL,... For a list of valid values see: [the wiki](http://wiki.snom.com/Settings/fkey/keyevent)
* **Url**: the URL to fetch when the key is pressed
* **If, Elif, Else**: [conditional blocks](#conditional_blocks)
* **Led**: Controls the status of the phone LEDs. Valid values: *on*, *off*, *blink*, *blinkfast*, *blinkslow*.
    * **Attributes**:
        * **number**: LED numbering (I.e. number="0" is addressed to message LED)
        * **color**: Valid values: *red*, *green*, *orange*, *redgreen*, *greenorange*
