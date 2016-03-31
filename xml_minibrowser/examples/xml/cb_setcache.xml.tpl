<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneBatch xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <SnomIPPhoneText id="page0">
    <!-- setcache callback not working, but setcache fragment and flush are working -->
        <Title>page 0</Title>
        <SoftKeyItem>
            <Name>*</Name>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/cb_setcache.xml#sub=*[@id="page1"]&amp;setcache:fkey_label0=weather</Url>
        </SoftKeyItem>
        <Text>set:fkey_label0:$(set:fkey_label0)<br />
            setcache:fkey_label0:$(setcache:fkey_label0)<br/>
            prees * to continue to setcache</Text>
    </SnomIPPhoneText>
    <!-- set: old value -->
    <SnomIPPhoneText id="page1">
        <Title>page 1</Title>
        <SoftKeyItem>
            <Name>*</Name>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/cb_setcache.xml#sub=*[@id="page2"]&amp;flush</Url>
        </SoftKeyItem>
        <Text>set:fkey_label0:$(set:fkey_label0)<br />
            setcache:fkey_label0:$(setcache:fkey_label0)<br/>
            prees * to continue flush</Text>
    </SnomIPPhoneText>
    <SnomIPPhoneText id="page2">
        <Title>page 2</Title>
        <SoftKeyItem>
            <Name>*</Name>
            <Url>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/cb_setcache.xml#sub=*[@id="page3"]</Url>
        </SoftKeyItem>
        <Text>set:fkey_label0:$(set:fkey_label0)<br />
            setcache:fkey_label0:$(setcache:fkey_label0)<br/>
            prees * to continue</Text>
    </SnomIPPhoneText>
    <SnomIPPhoneText id="page3">
        <Title>page 3</Title>
        <Text>set:fkey_label0:$(set:fkey_label0)<br />
            setcache:fkey_label0:$(setcache:fkey_label0)</Text>
    </SnomIPPhoneText>
</SnomIPPhoneBatch>
