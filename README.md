# persp-mode-fr
This code is an extension of
the [`persp-mode`](https://github.com/Bad-ptr/persp-mode.el) mode that uses the
GUI window title (AKA *frame name*, in Emacs nomenclature) to show a
perspectives list. It also indicates the currently selected one.

## Usage
Mostly the same as `persp-mode`:

```{lisp}
    (require 'persp-mode-fr)     ;; was (require 'persp-mode)
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

Access it as usual: `M-x customize-group RET persp-mode-fr RET`.


## Example
The images I could show here are mostly the same as the ones you can see
in [`elscreen-fr`](http://github.com/rocher/elscreen-fr#example), except that
`persp-mode-fr` shows only the perspective name.


## Finally
Tested only under Linux / Gnome.  Feedback welcome!
