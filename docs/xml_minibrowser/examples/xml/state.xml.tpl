<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneBatch xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <SnomIPPhoneMenu id="menu1">
        <MenuItem name="state relevant">
            <URL>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/state.xml.tpl#sub=*[@id="relevant"])</URL>
        </MenuItem>
        <MenuItem name="state only_mb">
            <URL>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/state.xml.tpl#sub=*[@id="only_mb"])</URL>
        </MenuItem>
        <MenuItem name="state others_except_mb">
            <URL>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/state.xml.tpl#sub=*[@id="others_except_mb"])</URL>
        </MenuItem>
    </SnomIPPhoneMenu>
    <SnomIPPhoneText id="relevant" state="relevant">
        <Text>state = relevant </Text>
    </SnomIPPhoneText>
    <SnomIPPhoneText id="only_mb" state="only_mb">
        <Text>state = only_mb </Text>
    </SnomIPPhoneText>
    <SnomIPPhoneText id="others_except_mb" state="others_except_mb">
        <Text>state = others_except_mb </Text>
    </SnomIPPhoneText>
</SnomIPPhoneBatch>
