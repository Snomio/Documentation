# Description

The **SnomIPPhoneBatch** tag contains a sequence of other main elements (document elements) in order to combine several smaller XML documents in one file.

All but the first main elements in the batch should have an unique id attribute to be selectable.
A main element can be selected to be processed by the URI fragment command *sub={XPath-step}*, where *{XPath-step}* is an XPath step expression for the level of the batch subelements.

Example URL: *http://example.com/example.xml#sub=*[@id="example-id"]* By default the first main element in the batch is processed.

!!! Info
    You can see a **SnomIPPhoneDireectory** usage example [here](examples/#snomipphonebatch)

# Valid Subtags

The **SnomIPPhoneBatch** can contain all the main tags:

* [**SnomIPPhoneMenu**](SnomIPPhoneMenu.md)
* [**SnomIPPhoneText**](SnomIPPhoneText.md)
* [**SnomIPPhoneInput**](SnomIPPhoneInput.md)
* [**SnomIPPhoneImage**](SnomIPPhoneImage.md)
* [**SnomIPPhoneImageFile**](SnomIPPhoneImageFile.md)
* [**SnomIPPhoneDirectory**](SnomIPPhoneDirectory.md)
