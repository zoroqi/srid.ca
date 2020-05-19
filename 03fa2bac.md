---
title: Conflict resolution in Emacs
date: 2020-04-16
tags:
    - emacs
---

Enter [`smerge-mode`](https://emacs.stackexchange.com/a/16470/2059)

Doom-emacs's default keybindings are a pain though. [C-c \^ n](kbd:)?

Add this to `config.el` and [SPC h r r](kbd:):

```lisp
(map! :leader
      (:prefix ("d" . "smerge")
        "n"  #'smerge-next
        "u"  #'smerge-keep-upper
        "l"  #'smerge-keep-lower
        ))
```

---

From Henrik:

> There's a smerge hydra on `SPC g m` if you have `:ui hydra` enabled

See [ui/hydra](https://github.com/hlissner/doom-emacs/tree/develop/modules/ui/hydra)
