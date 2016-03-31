<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneMenu xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <Title>press softkey</Title>
    <Menu name="m1">
        <SoftKeyItem>
            <Name>F1</Name>
            <Label>[@id="m1mi3"]</Label>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/fr_sel.xml#sel=[@id="m1mi3"]</Url>
        </SoftKeyItem>
        <SoftKeyItem>
            <Name>F2</Name>
            <Label>[@name="m1mi4"]</Label>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/fr_sel.xml#sel=[@name="m1mi4"]</Url>
        </SoftKeyItem>
        <MenuItem name="m1mi1" id="m1mi1"></MenuItem>
        <MenuItem name="m1mi2" id="m1mi2"></MenuItem>
        <MenuItem name="m1mi3" id="m1mi3"></MenuItem>
        <MenuItem name="m1mi4" id="m1mi4"></MenuItem>
        <MenuItem name="go to m2m1mi3" id="m1mi5">
            <Url>snom://mb_nop#menu=/SnomIPPhoneMenu/*[@id="m2"]/*[@id="m2m1"]&amp;sel=[@id="m2m1mi3"]</Url>
        </MenuItem>
    </Menu>
    <Menu name="m2" id="m2">
        <Menu name="m2m1" id="m2m1">
            <MenuItem name="m2m1mi1" id="m2m1mi1"></MenuItem>
            <MenuItem name="m2m1mi2" id="m2m1mi2"></MenuItem>
            <MenuItem name="m2m1mi3" id="m2m1mi3"></MenuItem>
        </Menu>
    </Menu>
</SnomIPPhoneMenu>
