<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneBatch xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <SnomIPPhoneText id="page0">
        <Title>page 0</Title>
        <SoftKeyItem>
            <Name>*</Name>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/fr_clearvar.xml#sub=*[@id="page1"]</Url>
        </SoftKeyItem>
        <Text>
            var:first_page: $(var:first_page)
            <br />
            prees * to continue
        </Text><!-- here variable always empty  -->
    </SnomIPPhoneText>
    <SnomIPPhoneText id="page1">
        <Title>page 1</Title>
        <SoftKeyItem>
            <Name>*</Name>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/fr_clearvar.xml#sub=*[@id="page2"]&amp;var:first_page=$(urlencode:hello world)</Url>
        </SoftKeyItem>
        <Text>
            var:first_page: $(var:first_page)
            <br />
            prees * to continue set var_first_page = hello_world
        </Text>
    </SnomIPPhoneText>
    <SnomIPPhoneText id="page2">
        <Title>page 2</Title>
        <SoftKeyItem>
            <Name>*</Name>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/fr_clearvar.xml#sub=*[@id="page3"]</Url>
        </SoftKeyItem>
        <Text>
            var:first_page: $(var:first_page)
            <br />
            prees * to continue 
        </Text>
    </SnomIPPhoneText>
    <SnomIPPhoneText id="page3">
        <Title>page 3</Title>
        <SoftKeyItem>
            <Name>*</Name>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/fr_clearvar.xml#sub=*[@id="page0"]&amp;clearvar</Url>
        </SoftKeyItem>
        <Text>
            var:first_page: $(var:first_page)
            <br />
            prees * to continue clearvar
        </Text>
    </SnomIPPhoneText>
</SnomIPPhoneBatch>
