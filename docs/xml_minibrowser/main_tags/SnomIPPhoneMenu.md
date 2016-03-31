# Description

The **SnomIPPhoneMenu** displays a Menu of selectable items. These items can either be sub-menus, containing items themselves, or items with a specific target, like URLs, key-events or internal callbacks.

!!! Info
    You can see a **SnomIPPhoneMenu** usage example [here](../examples/SnomIPPhoneMenu)

# Valid Attributes

- **has_scrollbar**: Display a scrollbar. Valid values: true, false, yes, no, on, off.
- **speedselect**: If enabled, an item or line can be selected by entering the according number. If set to **enter**, the item is directly entered, as if you pressed the OK button. If set to **select**, the item/line is only preselected. 
Valid values: **off**, **select**, **enter**.
- [**Main Attributes**](#main_attributes)

# Valid Subtags

The **SnomIPPhoneMenu** can contain some subtags:

- [Menu](#menu)
- [MenuItem](#menuitem) 
- [Main Sub Tags](#mainsubtags)

## Menu

A sub menu containing again menu elements.

### Valid Attributes

A **Menu** tag support a number of attributes hereby described

#### speedselect

**Description:** If enabled, an item or line can be selected by entering the according number.
If set to *enter*, the item is directly entered, as if you pressed the OK button.
If set to *select*, the item/line is only preselected. 

**Valid values:** *off*, *select*, *enter*

#### has_scrollbar

**Description:** Display a scrollbar.

**Valid Values:** Any text.

#### name

**Description:** Name that is displayed for this menu entry in the parent menu. This is also the default title for menu elements, if none is specified.

**Valid Values:** Any text.

!!! Warning
    Don't use line break inside this attribute.

#### id

**Description:** Arbitrary id to make alternative (via if clause) menu entries with different names identifiable. This can be necessary for the internal XPath-based navigation mechanism in nested menus.

**Valid Values:** Any text.

#### on_selected

**Description:** Fetch URL when this element selected.

**Valid Values:** Any URL.

#### on_deselected

**Description:** Fetch URL when this element is selected.

**Valid Values:** Any URL.

### Valid Subtags

Here are listed the tags that a [Menu](#Menu) tag can contain

#### Title

**Description:** Title of the sub-menu.

**Valid Values:** Any text.

!!! Warning
    Don't use line break inside this attribute.

#### InputField

**Description:** First line is an input field.

**Valid Attributes**

Here the valid attributes for **InputField**

- *on_selected*: Fetch URL when this element selected
- *on_deselected*: Fetch URL when this element is selected

**Valid Subtags**

Here the valid tags that can be nested into **InputField**

- **If, Elif, Else** TODO: add link
- **Handler**: Name of handler of the input.
- **Key**: Key that triggers the handler.
- **Timeout**: Time in ms after which the handler is called.
- **Minimum**: Minimum number of characters to enable timeout.
- **Prompt**: Prompt for the input field.

#### SoftKeyItem

See [SoftKey](#softkey)

#### Menu

The **Menu** tag can contain another [Menu](#menu) tag

#### MenuItem

See [MenuItem](#menuitem)

#### Repeat

See [Repeat](#repeat)

## MenuItem

Describes a menu entry that targets to either an URL, an key event or an internal callback.

### Valid Attributes

A [MenuItem](#menuitem) tag can contain a number of attributes hereby descripted

#### sel

**Description:** Preselect this directory entry.

**Valid Values:** *true*, *false*

#### name

**Description:** Name that is displayed for this menu entry in the parent menu.

**Valid Values:** Any text.

!!! Warning
    Don't use line break inside this attribute.

#### id

**Description:** Arbitrary id to make alternative (via if clause) menu entries with different names identifiable. This can be necessary for the internal XPath-based navigation mechanism in nested menus.

**Valid Values:** Any text.

#### on_selected

**Description:** Fetch URL when this element selected.

**Valid Values:** Any URL.

#### on_deselected

**Description:** Fetch URL when this element is selected.

**Valid Values:** Any URL.

#### sort_key

**Description:** Key by which the items get sorted if main attribute *sort* is enabled.
If omitted it gets set to the value of menu attribute *name*. Applicable with [Repeat](#repeat) only.

### Valid Subtags

Here are listed the tags that a [MenuItem](#menuitem) tag can contain

#### **If, EndIf, Else** TODO add link

#### Icon

**Description:** Show an icon beside the menu text

**Valid Values:** Any valid internal icon on 'file://snom/bmp/colored'. More available icon name can be found inside tar archive with file name prefix 'snom820_icon_' on branding instruction page. To use an external image use the **Image** tag instead.

#### URL

**Description:** Url of the file that is fetched when the menu entry is selected.

**Valid Attributes**

Here the valid attributes for the **URL** tag

- **new_context**: Creates a new minibrowser context for that Url. Valid values: *true*, *false*, *yes*, *no*, *on*, *off*.
- **track**: Determine if the Url will be loaded as replaceable on top of minibrowser history stack or not. Valid values: *true*, *false*, *yes*, *no*, *on*, *off*.

**Valid Subags**

Here the valid tags that can be nested into URL

- **If, Elif, Else**: TODO: add link
- **DetailUrl**: Detail for selection. **For Snom870 only**

#### SoftKey

**Description:** Identifier of a virtual key, that is pressed when the menu entry is selected.

**Valid Values:** Any valid soft key

#### Image

**Description:** Use external image as icon for menu entry

**Valid Value:** Any valid image URL

!!! Info
    The *Image* supports the attribute **default** containing the URL of a fallback image to display if the image failed to load

#### ItemData

**Description:** Define date to be hidden within (saved beneath) this menu-line, the ItemData can contains the following tags:

- [Repeat](#repeat)
- **If, Elif, Else**: TODO: add link
- **Variable**: Defines a variable. Allowed 0..n times

!!! Info
    The *Variable* tag **must** have a tag *name* containing the name of the variable and optionally a tag *value* containing the value of the variable, when not set or set as empty (i.e.:value="") the variable will be deleted
