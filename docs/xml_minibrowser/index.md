notoc: "False"

# Snom XML Minibrowser

## Introduction

The XML Minibrowser is a feature of the standard SIP software delivered with Snom phones. It allows processing Snom XML objects which is stored on standard web servers (http(s)). The feature can be used for various applications.
Available XML objects are following :

|    Main Tag Name   |    Description    |
|------------------|-----------------|
|[**SnomIPPhoneMenu**](main_tags/SnomIPPhoneMenu.md)| Show a Menu calling other applications |
|[**SnomIPPhoneDirectory**](main_tags/SnomIPPhoneDirectory.md)| Shows a phone book |
|[**SnomIPPhoneText**](main_tags/SnomIPPhoneText.md)| Print a text |
|[**SnomIPPhoneImage**](main_tags/SnomIPPhoneImage.md) | Show a **base64** encoded image |
|[**SnomIPPhoneImageFile**](main_tags/SnomIPPhoneImageFile.md)| Show an image fetched via an **URL** |
|[**SnomIPPhoneInput**](main_tags/SnomIPPhoneInput.md)| Request for an input from the user |
|[**SnomIPPhoneBatch**](main_tags/SnomIPPhoneBatch.md) | Combine several main tags in one XML data |

To understand how Snom Minibrowser works, the knowledge on following theme are required :

- Snom telephone
- Basic XML element (tag and attributes) and XML structure
- URI (fragment and query) and URL-encoding

With the previous knowledge, programmer can start developing minibrowser program by doing the following simple task :

- Learn minibrowser basic structure in given XML schema. (see [here](http://wiki.snom.com/Category:HowTo:XML:Schema))
- Understand minibrowser tag and attribute on this page
- Create simple minibrowser application or test the sample program given in the example page
- Learn about minibrowser [callback](callbacks/index.md) and [fragment](fragments/index.md) function
- You can see many ready-to-use [examples](examples/index.md)

## Common rule for writing XML for minibrowser

* First and foremost, use XML Editor with capability of validating XML file with XSD (XML Schema Definition).
* XML header is recommended to make XML parser not guessing which encoding will be used.
* Minibrowser can only load one one object at a time. see [SnomIPPhoneBatch](main_tags/#snomipphonebatch) for instruction to write multiple object in one file.
* Minibrowser can also load file with php and cgi extension, if they are generating the XML file. Don't forget to set the header of the file to XML type content. 
* To write XML file using character other than English alphabet, check if the editor encoded the file in utf-8 and PUI language supported the character. As example by arabic PUI language can't show Chinese and Japanese character or by English PUI language can't show Arabic character.
* To enable validation in common XML editor you have to include the schema declaration in main object.
    * You don't have to include another schema declaration in main element when using *SnomIPPhoneBatch*, except that you want to use different schema.

### Example of how to include XML schema from upper directory.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneText xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <Text>Hello world</Text>
</SnomIPPhoneText>
```

Some special instruction and hints (This may change by different firmware version or new XML parser behaviour)

* Minibrowser XML parser is not case sensitive, so you can write the opening tag and closing tag with the different character case. In proper XML editor, it will check the character case. 
* Name convention of  minibrowser tags and attributes are following : 
* All tag written in camel case and start with upper-case with exception of *<br>* tag.
* All Attribute is written and start in lower-case character and underscore is used to replace white space.
* The link provided in example may be invalid, broken and unavailable.
* Some example was provided with light content, to make it short and understandable in first glance.
* Due to XSD limitation there is some behaviour that may not described here.
