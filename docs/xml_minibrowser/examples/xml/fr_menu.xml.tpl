<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneMenu xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <Menu name="m1" id="m1">
        <Menu name="l2m1" id="l2m1">
            <Menu name="l3m1" id="l3m1">
                <MenuItem name="l3m1mi1" id="l3m1mi1"></MenuItem>
                <MenuItem name="l3m1mi2" id="l3m1mi2"></MenuItem>
                <MenuItem name="l3m1mi3" id="l3m1mi3"></MenuItem>
            </Menu>
        </Menu>
    </Menu>
    <MenuItem name="go to l3mi3">
        <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/fr_menu.xml#menu=/SnomIPPhoneMenu/*[@id="m1"]/*[@id="l2m1"]/*[@id="l3m1"]</Url>
    </MenuItem>
</SnomIPPhoneMenu>
