---
date: 2020-06-13
tags:
  - reflex/pattern
---

# Ouroboros FRP pattern

![ouroboros](https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/Serpiente_alquimica.jpg/440px-Serpiente_alquimica.jpg){.ui .small .right .floated .image}

When writing FRP apps in reflex, there is often a situation where a widget that takes a `Dynamic` of some value produces an `Event` that updates the very `Dynamic` it takes as input (see <e9a1b18c?cf>).

```haskell
noteWidget :: Dynamic t Text -> m (Event t Text)
noteWidget = ...
``` 

Here we have a text note widget that takes the text to display as input. The widget allows the user to edit the note, and its "save" button would trigger the output event. When the user saves the text, we want the note view to update with the saved text (the "ouroboros" feed-back).

The function that calls this widget would look like this:

```haskell
mainWidget = do 
  let initialNote = ...
  rec noteDyn <- holdDyn initialNote noteEvt
      noteEvt <- noteWidget noteDyn
```          

We must use the [`rec`](https://wiki.haskell.org/Keywords#rec) keyword, in order to allow recursive bindings in the do block. Why? Notice how `noteDyn` is defined by referencing `noteEvt` that is yet to defined. The two values recursively refer each other.