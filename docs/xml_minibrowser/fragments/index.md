# Snom Minibrowser Fragments

The minibrowser can be controlled with URI fragment commands that are appended to any URL.

!!! Warning
    The following fragments can only be used by trusted host	
    
    * setcache
    * clearcache
    * flush
    * next_edit_mode
    * reloadset
    * set
    * toggleset
    * action_ifc
    * var_ifc

    Trusted hosts are managed by the setting [mb_trusted_host](http://wiki.snom.com/Settings/mb_trusted_hosts). **It is required to set this option for some fragments. This setting is only require IP Address or hostname without schema and port**.

## List of available fragments

| Fragment Name | Description | 
|---------------|-------------|
| [setcache](../examples/fr_setcache.md) | Cache a setting value |
| [clearcache](../examples/fr_clearcache.md) | Clear setting value cache |
| [clearvar](../examples/fr_clearvar.md) | Clear all variables |
| [menu](../examples/fr_menu.md) | Get the menu link |
| [next_edit_mode](../examples/fr_next_edit_mode.md) | Switch to the next edit mode of the system |
| [sel](../examples/fr_sel.md) | Preselect an entry of a list |
| [reloadset](../examples/fr_reloadset.md) | Reload the settings |
| [set](../examples/fr_set.md) | Set a setting |
| [sub](../examples/fr_sub.md) | A fragment to jump between main element within *SnomIPPhoneBatch* |
| [toggleset](../examples/fr_toggleset.md) | Toggle a boolean setting |
| [var](../examples/fr_var.md) | Sets a variable |
| [action_ifc](../examples/fr_action_ifc.md) | Perform an action via a module |
| [applyline](../examples/fr_applyline.md) | Reregister a identity |
| [key](../examples/fr_key.md) | Fires the given key |
| [numberdial](../examples/fr_numberdial.md) | Dials a number |
| [reboot](../examples/fr_reboot.md) | Reboot or reset the phone |
| [reregister](../examples/fr_reregister.md) | Reregister an identity |
| [unregister](../examples/fr_unregister.md) | Unregister a phone identity |
| [var_ifc](../examples/fr_var_ifc.md) | Set a module variable |
| [mjpg](../examples/fr_mjpg.md) | Start a Motion Jpeg video |