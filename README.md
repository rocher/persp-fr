# persp-fr
This code is an extension of the [`persp-mode`](https://github.com/..) mode that
uses the GUI's window title (AKA *frame name*, in Emacs nomenclature) to show a
list of the current perspectives. It also indicates which one is currently
selected.

## Usage
Mostly the same as `persp-mode`:

```{lisp}
    (require 'persp-fr)     ;; was (require 'persp-mode)
    (persp-fr-start)
```

## Customization
Useful keys to switch from next/previous perspective, as in most tabbed user
interfaces:

```{lisp}
    (global-set-key [(control prior)] 'persp-prev)
    (global-set-key [(control next)] 'persp-next)
```

The customization group lets you tweak few parameters.

Access it as usual: `M-x customize-group RET persp-fr RET`.


## Example


## Finally
Tested only under Linux / Gnome.  Feedback welcome!
