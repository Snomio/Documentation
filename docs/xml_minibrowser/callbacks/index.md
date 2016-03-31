# Snom Minibrowser Callbacks

To make use of dynamic information the content of certain elements and attributes are evaluated in order to translate special callback expressions.
They have the form *$(name)* or *$(name:arg)* and are dynamically replaced by their return values.

!!! Note
	The result from callback in example code, which using the telephone specific setting, may differs for another Snom telephone
	

Things to consider when writing callbacks:

* **Callbacks argument**: necessity of the argument, limitation on argument.
* **Extra white space on callbacks name and arguments**: see the example below.
* **Character case of the callback and its argument**

!!! Warning
	There are 2 type of callback place holder, *$(...)* and *$[...]*. The one using square brackets will be explained [here](#differences_between_placeholders)

Here some examples of common errors:

**Correct syntax:**

```
$(max_pkeys)
$(set:vol_speakers)
```

| Error Example | Description |
|---------------|-------------|
| $ (max_pkeys) | whitespace  |
| $( max_pkeys) | whitespace  |
| $(max_pkeys ) | whitespace  |
|$(max_pkeys:argument)|	unnecessary argument|
|$(set :vol_speaker)| whitespace |
|$(set: vol_speaker) | whitespace |
|$(set:vol_speaker ) | whitespace |
|$(set) | missing argument |

## List of available callbacks

| Callback Name | Description |
|---------------|-------------|
| [arch_series](../examples/cb_arch_series.md)   | Returns the device architecture (Eg. architecture: snom3XX, snom7Xx, snom8XX) |
| [bool_eval](../examples/cb_bool_eval.md) | Returns the boolean value for true or false value |
| [checkbox_property](../examples/cb_checkbox_property.md) | Returns if the checkbox property is available on this phone (*available*, *none*) |
| [condition](../examples/cb_condition.md) | Returns "1" if the condition is true, else "0". This is the callback version of the attribute of the same name [here](../main_tags/main_sub_tags/#conditional_blocks).
| [create_url](../examples/cb_create_url.md) | Creates an URL out of the parameter |
| [current_input](../examples/cb_current_input.md) | Returns the current minibrowser input |
| [current_line](../examples/cb_current_line.md) | Returns the current line of 1-12 (active user id) |
| [date](../examples/cb_date.md) | Return the current date |
| [time](../examples/cb_time.md) | Returns the current time |
| [display_type](../examples/cb_display_type.md) | Returns the display type of phone: *color_touch*, *color*, *greyscale*, *monochrome*, *character*, *none* |
| [edit_mode](../examples/cb_edit_mode.md) | Toggles edit mode to the next one |
| [next_edit_mode](../examples/cb_edit_mode.md) | Returns the next edit mode of the system |
| [empty](../examples/cb_empty.md) | Returns *true* or *false* depending if arg is a an empty string |
| [enum](../examples/cb_enum.md) | Returns an enumeration out of parameter `start[:end[:step]]`. e.g. `$(enum:$(max_registrations)) = |1|2|3|4|5|6|7|8|9|10|11|12|`| |
| [fragment](../examples/cb_fragment.md) | Returns the corresponding value for the given key from the current uri fragment |
| [lang](../examples/cb_lang.md) | Returns the localized gui string for a given language key |
| [lastsel](../examples/cb_lastsel.md) | Returns the data of the selected list item. (Sometimes it's the id attribute of the last MenuItem) |
| [sel](../examples/cb_lastsel.md) | Returns the data of the selected list item. (Sometimes it's the id attribute of a MenuItem) |
| [lines](../examples/cb_lines.md) | Returns number of calls |
| [list_size](../examples/cb_list_size.md) | Returns the number of listed items |
| [cb_math_eval](../examples/cb_math_eval.md) | Evaluate the parameter into a math result |
| [max_registrations](../examples/cb_max_registrations.md) | Returns the number of maximum registrations |
| [max_pkeys](../examples/cb_max_pkeys.md) | Returns the number of maximum programable keys |
| [mod_ifc](../examples/cb_mod_ifc.md) | Return boolean value if module (or module's variable) exists |
| [module_id_of_current_line](../examples/cb_module_id_of_current_line.md) | Returns the module-id of the current menu line |
| [on_off](../examples/cb_on_off.md) | Returns the localized string of an on/off for boolean value |
| [phone_state](../examples/cb_phone_state.md) | Returns the current phone state |
| [remove_cmd](../examples/cb_remove_cmd.md) | Command to remove leading cmd of fkeys setting (Eg. *blf 123*) |
| [set](../examples/cb_set.md) | Returns the value of a setting |
| [setcache](../examples/cb_setcache.md) | Returns the corresponding value for the given setting in the settings cache |
| [show_feature](../examples/cb_show_feature.md) | Return *true* or *false* depend if feature is activated or exist |
| [status_message](../examples/cb_status_message.md) | Returns the status message |
| [urlencode](../examples/cb_urlencode.md) | Returns the argument URL-encoded |
| [user_displayname](../examples/cb_user_displayname.md) | Returns the displayname of given identity |
| [var](../examples/cb_var.md) | Returns the corresponding value for the given variable in the variables cache |
| [var_ifc](../examples/cb_var_ifc.md) | Ask the value of a variable from telephone modules |
| [wifiscan](../examples/cb_wifiscan.md) | Scans for available WIFI SSIDs and returns them as a list |
| [wlang](../examples/cb_wlang.md) | Returns the localized web string for a given language key |
| [x_o](../examples/cb_x_o.md) | Returns checked or unchecked character for boolean value |
| [yes_no](../examples/cb_yes_no.md) | Returns the localized string of an yes/no for boolean value |

## Differences between placeholders

Callback can be used with two different placeholder, *$(...)* and *$[...]*. the main difference between them is, when the value will be fetched.

!!! Demo
    [Try on your phone](xml/cb_different_placeholders.xml)

```
{!docs/xml_minibrowser/examples/xml/cb_different_placeholders.xml!}
```

In the first page *sel* callback is not yet replaced. But after one of the *MenuItem* is selected, the *sel* callback will be replaced with selected *MenuItem* id and it will be printed on second page through *var* callback.
