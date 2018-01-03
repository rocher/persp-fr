# persp-fr
This code is an extension of
the [`persp-mode`](https://github.com/Bad-ptr/persp-mode.el) mode that uses the
GUI window title (AKA *frame name*, in Emacs nomenclature) to show a
perspectives list. It also indicates the currently selected one.

## Change Log

  * Release 0.0.4 - 03/01/2018 - Add functions to move the current perspective
    to the left, right, first or last position.

  * Release 0.0.3 - 08/09/2017 - Revert last change because `persp-mode` now
    properly sorts the list of names.

  * Release 0.0.2 - 07/09/2017 - Last `persp-mode` release reversed the list of
    `persp` names, which affected how names are shown in the title bar.
    Now names in `persp-fr` are shown as before. If you use the customization
    shown below, please consider exchanging the key assignment. Otherwise you
    will navigate `persp` buffers in reverse order.

## Usage
Mostly the same as `persp-mode`:

```{lisp}
    (require 'persp-fr)     ;; was (require 'persp-mode)
    (persp-fr-start)
```

## Customization
The customization group lets you tweak few parameters.

Access it as usual: `M-x customize-group RET persp-fr RET`.

Useful keys to switch from next/previous perspective, as in most tabbed user
interfaces, and to move current perspective to left/right:

```{lisp}
    (global-set-key [(control prior)] 'persp-prev)
    (global-set-key [(control next)] 'persp-next)
    (global-set-key [(control meta next)] 'persp-fr-move-right)
    (global-set-key [(control meta prior)] 'persp-fr-move-left)
```


## Example
The images I could show here are mostly the same as the ones you can see
in [`elscreen-fr`](http://github.com/rocher/elscreen-fr#example), except that
`persp-mode-fr` shows only the perspective name.


## Finally
Tested only under Linux / Gnome.  Feedback welcome!
