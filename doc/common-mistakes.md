# Common mistakes

Awesome WM error messages are not the most friendly ones.

#### draw is not a function

While trying to set up my [laptop backlight](http://news.gmane.org/gmane.comp.window-managers.awesome)
whenever instancing an Widget, if the object does not exist, a message
containing:

```
error while running function
stack traceback:
  [C]: in function 'error'
  /usr/share/awesome/lib/gears/debug.lua:23: in function 'gears.debug.assert'
  /usr/share/awesome/lib/wibox/widget/base.lua:120: in function 'wibox.widget.base.check_widget'
  /usr/share/awesome/lib/wibox/layout/fixed.lua:55: in function 'wibox.layout.fixed.add'
  ./cfg/wibox.lua:108: in main chunk
  [C]: in function 'require'
  ...rp/path/to/awesome-config-files/rc.lua:31: in main chunk
error: /usr/share/awesome/lib/gears/debug.lua:23: Assertion failed: 'draw is not a function'
stack traceback:
  /usr/share/awesome/lib/gears/debug.lua:23: in function 'gears.debug.assert'
  /usr/share/awesome/lib/wibox/widget/base.lua:120: in function 'wibox.widget.base.check_widget'
  /usr/share/awesome/lib/wibox/layout/fixed.lua:55: in function 'wibox.layout.fixed.add'
  ./cfg/wibox.lua:108: in main chunk
  [C]: in function 'require'
  ...rp/path/to/awesome-config-files/rc.lua:31: in main chunk
```

As pointed out in [this issue](https://github.com/pefimo/awpomodoro/issues/5)
This usually happens because the object passed to the widget layout does not
exist or it isn't a valid widget object, and thus does not have the draw
function as a member.


