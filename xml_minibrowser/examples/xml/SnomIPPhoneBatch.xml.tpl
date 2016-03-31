<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneBatch>
    <SnomIPPhoneMenu id="menu">
        <Title>Menu</Title>
        <MenuItem name="show image">
            <URL>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/SnomIPPhoneBatch.xml#sub=*[@id="imageFile"]</URL>
        </MenuItem>
        <MenuItem name="go somewhere else">
            <URL>${TPL_ROOT_URL}/xml_minibrowser/examples/xml/SnomIPPhoneText.xml</URL>
        </MenuItem>
    </SnomIPPhoneMenu>
    <SnomIPPhoneImageFile id="imageFile">
        <LocationX>0</LocationX>
        <LocationY>0</LocationY>
        <URL>${TPL_ROOT_URL}/xml_minibrowser/examples/img/webcam.jpg</URL>
    </SnomIPPhoneImageFile>
</SnomIPPhoneBatch>
