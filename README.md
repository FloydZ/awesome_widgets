The following widgets are available:
- `ipaddress`
- `microphone`
- `pomo`
- `printer`
- `users`
- `vpn`

Installation:
==============

```lua
-- load the widget:
local pomo_widget		= require("widgets/pomo/pomo")

-- then install it in the wibox:
wibox.container.background(wibox.container.margin(pomo_widget(), dpi(8), dpi(10)), vol_bg),
```
