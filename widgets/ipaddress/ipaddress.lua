local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")

--
-- needs `ifconfig`
--


-- example 
local interfaces = { "wlan0", "eth0", "eno1", "lo" }
local ip
local ip_interface

for i = 1, 6 do
    local fd     = io.popen("ifconfig " .. interfaces[i])
    local output = fd:read("*all")
    fd:close()

    ip = string.match(output, "inet (%d+%.%d+%.%d+%.%d+)")
	ip_interface = interfaces[i]
    if ip then break end
end

if not ip then
    ip = "offline"
end

local font_name = "monospace"
local font_size = "11"
local font = font_name .. " " .. font_size

--local markup  = "<span fgcolor='#a89984'>" .. ip .. "</span>"
local markup  = ip_interface .. ": " .. ip
local textbox = wibox.widget.textbox(markup)
textbox.font = font

return textbox
