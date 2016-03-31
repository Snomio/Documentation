# Description

The **SnomIPPhoneText** tag shows arbitrary text

!!! Info
    You can see a **SnomIPPhoneMenu** usage example [here](../examples/SnomIPPhoneText)

# Valid Attributes

- **has_scrollbar**: Display a scrollbar. Valid values: *true*, *false*, *yes*, *no*, *on*, *off*
- [**Main Attributes**](#main_attributes)

# Valid Subtags

The **SnomIPPhoneText** can contain some subtags:

## Text

The text to display. This tag contain mixed content.

**Valid Subtags**

* [Repeat](#repeat)
* [br](#br) 

## LocationX

X coordinate of the text position

## LocationY

Y coordinate of the text position

## Image

Show image alongside the text

**Valid Attributes**

* **default**: Default image if the image url content on **URL** failed to load

**Valid Subtags**

* [Contidional blocks](#conditional)
* **LocationX**: X coordinate of the image position
* **LocationY**: Y coordinate of the text position
* **width**: Determine the width of image
* **height**: Determine the height of image
