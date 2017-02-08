---
layout: post
title:  "How to use CoqIde"
date:   2017-02-06 23:59:34 +0900
categories: jekyll update
---

### CoqIde Shortkeys

- `Ctrl + Alt + Down` : Prove next statement
- `Ctrl + Alt + Right` : Prove up to the cursor
- `Ctrl + Alt + Up` : Retreat by one statement
    + 2017.02.08 : If it doesn't work, try `Ctrl + Down/Right/Up` as well.

### Troubleshootings

- If you are using Windows OS, and if `Ctrl + Alt + Arrow` rotates the screen, you can try either of two solutions :
    + Change shortkeys by opening `Preferences` -> `Shortcuts` in CoqIde.
    + Disable screen rotation functionality in Windows by opening Intel HD utility (try `Ctrl + Alt + F12`). [link](http://superuser.com/questions/592684/disable-screen-orientation-hot-keys-in-windows-8-ctrl-alt-arrow)

- If you see error `Error: Cannot find library XXX in loadpath`, try `Compile` -> `Make`. If it doesn't work, open XXX.v and try `Compile` -> `Compile buffer`.

### Asking for Help

- You can ask TAs directly by raising your hands.
- Or, register your questions ([here](https://github.com/sigpl2017/sigpl2017.github.io/issues))
