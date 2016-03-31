# Description

The **SnomIPPhoneDirectory** tag displays a directory of name-number pairs from which you can select one to call.

!!! Info
    You can see a **SnomIPPhoneDireectory** usage example [here](examples/#snomipphonedirectory)

# Valid Attributes

- **has_scrollbar**: Display a scrollbar. Valid values: *true*, *false*, *yes*, *no*, *on*, *off*
- **speedselect**: If enabled, an item or line can be selected by entering the according number. If set to *enter*, the item is directly entered, as if you pressed the OK button. If set to *select*, the item/line is only preselected. Valid values: *off*, *select*, *enter*.
- [**Main Attributes**](#main_attributes)

# Valid Subtags

The **SnomIPPhoneDirectory** can contain some subtags:

## DirectoryEntry

A single directory entry

**Valid Attributes**

* **sel**: Preselect this directory entry

**Valid Subtags**

* **Name**: The displayed text for the directory entry
* **Telephone**: The number dialed, when the directory entry is selected.
