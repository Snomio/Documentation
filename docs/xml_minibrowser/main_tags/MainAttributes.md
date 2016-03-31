# Main Attributes

Following attributes are supported in all the snom Minibrowser main tags

### title

**Description:** Set the title for the main element. If this and title tag written inside the main element, the value from this attribute will be taken as the title.

**Valid Values:** Any text

!!! WARNING
    Don't use line break inside this attribute.


### sort

**Description:** Sort a list.

**Valid values:** *true*, *false*, *yes*, *no*, *on*, *off*. 

!!! Info
        You can see a **sort** usage example [here](examples/#sort)

### selectable

**Description:** Determine if list is selectable or not.

**Valid values:** *true*, *false*, *yes*, *no*, *on*, *off*.

!!! Info
        You can see a **selectable** usage example [here](examples/#selectable)

### predict

**Description:** Input with T9 (predictive text).

**Valid values:** *true*, *false*, *yes*, *no*, *on*, *off*.

### dtmf

**Description:** If enabled DTMF tones are played on each digit input, otherwise no DTMF tones are played out.

**Valid values:** *true*, *false*, *yes*, *no*, *on*, *off*.

### id

**Description:** An arbitrary id, that can be used to select the main element if it is contained in a batch of several main elements. See [SnomIPPhoneBatch](#snomipphonebatch).

**Valid Value:** Any text identifying a main element

### track

**Description:** If false, the URL of the displayed XML document is not tracked in the history. That is, this document will be skipped when you go back in history by pressing the Cancel (X) button.

**Valid values:** *true*, *false*, *yes*, *no*, *on*, *off*.

### state

**Description:** If set to *relevant*, key events will not only be processed by the minibrowser but also be forwarded to the underlying phone state 
If set to *only_mb*, key events will only be processed by the minibrowser (Default value).
If set to *others_except_mb*, unrecognized key events will not processed by minibrowser.

**Valid values:** *relevant*, *only_mb*, *others_except_mb*.

!!! Info
        You can see a **state** usage example [here](examples/#state)

### show_line_info_layer 

**Description:** If the line info shall be displayed.

**Valid values:** *on*, *off*, *smart*
