# Builtin templates

!!! Info
    Snom phones also offer some builtin templates which can be accessed through an internal URL.

## template.xml

**Address:** file:///xml/gui/templates.xml

### Content

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneBatch xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../schemas/minibrowser.xsd">
  <SnomIPPhoneInput track="no" dtmf="off" id="input_template">
    <Url>$(var:input_url)</Url>
    <InputItem>
      <DisplayName>$(var:input_displayname)</DisplayName>
      <InputToken>$(var:input_token)</InputToken>
      <InputFlags>$(var:input_flags)</InputFlags>
      <InputMask>$(var:input_mask)</InputMask>
      <DefaultValue>$(var:input_default)</DefaultValue>
    </InputItem>
  </SnomIPPhoneInput>
<!-- ... -->
</SnomIPPhoneBatch>
```

### Example

Consider following action URL (the newline added for better readibility):

```
file:///xml/gui/templates.xml
#sub=*[@id="input_template"]
&var:input_displayname=ChangePreNr
&var:input_token=__Y__
&var:input_flags=n
&var:input_url=snom://mb_exit#set:preselection_nr=__Y__
```

* First line mean that the templates.xml file inside the telephone will be called.
* sub function will be executed and by the given xpath, the *SnomIPPhoneInput* with id *input_template* inside the XML file will be loaded.
* assign value to variable *input_displayname*
* assign value to variable *input_token*
* assign value to variable *input_flags*
* assign value to variable *input_url*. This contain target URL to tell the minibrowser where to go after user confirm the input.

## text.xml

**Address:** file:///xml/text.xml

### Content

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneText>
  <Title>$(var:title)</Title>
  <Text>$(var:text)</Text>
</SnomIPPhoneText>
```

### Example

Consider following action URL (the newline added for better readibility):

```
file:///xml/text.xml
#var:title=Text
&var:text=Hello%20world
```

* load text.xml from snom telephone
* assign value to variable *title*
* assign value to variable *text*

## decision.xml

**Address:** file:///xml/gui/decision.xml

### Content

```xml
<SnomIPPhoneBatch>
<!-- ... -->
  <SnomIPPhoneText track="no" id="dsc_url" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../schemas/minibrowser.xsd">
    <Title>$(var:dsc_title)</Title>
    <Text>$(var:dsc_text)</Text>
    <If condition="$(var:dsc_yes)">
      <SoftKeyItem>
        <Name>ENTER</Name>
        <Url track="no">$(var:dsc_yes_url)</Url>
      </SoftKeyItem>
      <SoftKeyItem>
        <Name>F1</Name>
        <Label>F_OK</Label>
        <Url track="no">$(var:dsc_yes_url)</Url>
      </SoftKeyItem>
    </If>
    <If condition="$(var:dsc_no)">
      <SoftKeyItem>
        <Name>CANCEL</Name>
        <Url track="no">$(var:dsc_no_url)</Url>
      </SoftKeyItem>
      <SoftKeyItem>
        <Name>F2</Name>
        <Label>F_CANCEL</Label>
        <Url track="no">$(var:dsc_no_url)</Url>
      </SoftKeyItem>
    </If>
    <If condition="$(var:dsc_abort)">
      <SoftKeyItem>
        <Name>F_ABORT</Name>
        <Url>$(var:dsc_abort_url)</Url>
      </SoftKeyItem>
      <SoftKeyItem>
        <Name>F3</Name>
        <Label>F_ABORT</Label>
        <Url>$(var:dsc_abort_url)</Url>
      </SoftKeyItem>
    </If>
  </SnomIPPhoneText>
<!-- ... -->
</SnomIPPhoneBatch>
```

### Example

Consider following action URL (the newline added for better readibility):


```
file:///xml/gui/decision.xml
#sub=*[@id="dsc_url"]
&var:dsc_title=decision.xml%20example
&var:dsc_text=dial%20snom715%253F
&var:dsc_yes=yes
&var:dsc_yes_url=snom%3A%2F%2Fmb_nop%23numberdial%3D500715124
&var:dsc_no=yes
&var:dsc_no_url=snom%3A%2F%2Fmb_exit
```

* First line mean that the decision.xml file inside the telephone will be called.
* sub function will be executed and by the given xpath, the *SnomIPPhoneText* with id *dsc_url* inside the XML file will be loaded.
* assign value to variable *dsc_title*
* assign value to variable *dsc_text*
* assign value to variable *dsc_yes* to enable *yes* option.
* assign value to variable *dsc_yes_url*. This contain target URL to tell the minibrowser where to go after user confirm the decision.
* assign value to variable *dsc_no* to enable *no* option.
* assign value to variable *dsc_no_url*. This contain target URL to tell the minibrowser where to go after user cancel the decision.
