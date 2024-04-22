local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")

-- simply shows the ip addr of the vpn interface
-- needs the following commands: `ip`
-- 

dev = "tun0"
cmd = "ip addr show " + dev
time = 30

vpn_widget = wibox.widget.textbox()
watch(cmd, time,
    function(widget, stdout, stderr, exitreason, exitcode)
    if(stdout == '' or stdout==nil or stdout=='Device ' + dev + ' does not exist.') then
        widget.text= "| !VPN |"
    else
        widget.text= "| VPN | " 
    end
end,
vpn_widget
)

return vpn_widget
