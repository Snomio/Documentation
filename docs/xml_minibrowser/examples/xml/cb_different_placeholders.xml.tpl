<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneBatch xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <SnomIPPhoneMenu id="menu">
        <MenuItem name="mi1" id="mi1">
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/cb_different_placeholdes.xml#sub=*[@id="text"]&amp;var:text=$[sel]</Url>
        </MenuItem>
        <MenuItem name="mi2" id="mi2">
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/cb_different_placeholdes.xml#sub=*[@id="text"]&amp;var:text=$[sel]</Url>
        </MenuItem>
        <MenuItem name="mi3" id="mi3">
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/cb_different_placeholdes.xml#sub=*[@id="text"]&amp;var:text=$[sel]</Url>
        </MenuItem>
    </SnomIPPhoneMenu>
    <SnomIPPhoneText id="text">
        <Text>selected id = $(var:text)</Text>
    </SnomIPPhoneText>
</SnomIPPhoneBatch>
