# Description

The **SnomIPPhoneInput** tag isplays an input field. The entered value can be put anywhere into the Url for the next XML file to process by a freely definable token. In combination with URI fragment commands the value can be used to set settings or variables.

!!! Info
    You can see a **SnomIPPhoneInput** usage example [here](examples/#snomipphoneinput)

# Valid Attributes

- [**Main Attributes**](#main_attributes)

# Valid Subtags

The **SnomIPPhoneInput** can contain some subtags:

## URL

The URL that is fetched after the input has been finished with the OK (check-mark) button. All occurences of the string defined in the InputToken element will be replaced by the entered value.

**Valid Attributes**

* **sel**: Preselect this directory entry

**Valid Subtags**

* **Name**: The displayed text for the directory entry
* **Telephone**: The number dialed, when the directory entry is selected.

## InputItem

Required element to determine the input rule.

**Valid Subtags**

* **Conditional Elements**: TODO add link
* **DisplayName**: Header of the intput field. Currently this is displayed in the title, so the Title element has no effect for SnomIPPhoneInput
* **DefaultValue**: The default value that will be pre-filled into the input field
* **InputToken**: Defines a token, that will be replaced in the Url by the entered value
* **InputMask**: limiting the input position and input mode. *9*, *a*, *A* characters will act as mask with correspondent input mode (*9* as number input mode, *a* as lower-case input mode and *A* as upper-case input mode)
* **InputFlags**: Specifies the type of input field. 
    * **Valid values**:
        * **a**: normal text
        * **t**: telephone number
        * **n**: number
        * **e**: number with text
        * **u**: uppercase text
        * **l**: lowercase text
        * **p**: password
        * **pn**: numeric password
