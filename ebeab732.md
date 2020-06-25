---
date: 2020-06-25
tags:
  - reflex/tip
---

# Autofocus an element in Reflex

{.ui .warning .message}
This does not reliably work, especially on mobile browsers. See the inline comment.

```haskell
import GHCJS.DOM.HTMLElement (focus)
import GHCJS.DOM.Types (IsHTMLElement, MonadJSM)

widgetFunc = do
  -- Delay until the DOM element is *hopefully* ready
  -- Unfortunately this is not guaranteed.
  ready <- delay 0.1 =<< getPostBuild
  searchElem <- inputElement def
  widgetHold_ blank $ ffor ready $ \() ->
    focus $ _inputElement_raw searchElem
```


