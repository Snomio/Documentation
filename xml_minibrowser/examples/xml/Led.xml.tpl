<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneText>
    <Title>LED Control Feature</Title>
    <Text>This sample page demonstrates the Minibrowser LED control feature.</Text>
    <Led number="1">On</Led>
    <Led number="2">blink</Led>
    <Led number="3">blinkfast</Led>
    <Led number="4">blinkslow</Led>
    <Led number="5" color="green">on</Led>
    <SoftKeyItem>
        <Name>F1</Name>
        <Label>Off</Label>
        <URL>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/Led-off.xml</URL>
    </SoftKeyItem>
    <SoftKeyItem>
        <Name>F2</Name>
        <Label>Exit</Label>
        <URL>snom://mb_exit</URL>
    </SoftKeyItem> 
</SnomIPPhoneText>
