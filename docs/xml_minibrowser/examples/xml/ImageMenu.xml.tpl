<?xml version="1.0" encoding="UTF-8"?>
<SnomIPPhoneMenu xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../minibrowser_test.xsd">
    <MenuItem name="local:snom photo unknown ">
        <Image default="file:///bmp/colored/snom_photo_unknown.png">file:///bmp/colored/snom_photo_unknown.png</Image>
    </MenuItem>
    <MenuItem name="local:snom820_icon_buddy_dnd.png">
        <Image default="file:///bmp/colored/snom_photo_unknown.png">file:///bmp/colored/snom820_icon_buddy_dnd.png</Image>
    </MenuItem>
    <MenuItem name="url image1">
        <Image default="file:///bmp/colored/snom_photo_unknown.png">${TPL_ROOT_URL}/xml_minibrowser/examples/img/Icon_radiation.png</Image>
    </MenuItem>
    <MenuItem name="invalid url/image without default">
        <Image>http://randomurl.com/random_image.png</Image>
    </MenuItem>
    <MenuItem name="invalid url/image">
        <Image default="file:///bmp/colored/snom_photo_unknown.png">http://randomurl.com/random_image.png</Image>
    </MenuItem>
</SnomIPPhoneMenu>
