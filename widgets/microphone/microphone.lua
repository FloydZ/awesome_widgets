local wibox 	= require("wibox")
local awful 	= require("awful")
local naughty 	= require("naughty")
local watch 	= require("awful.widget.watch")
local lain      = require("lain")
local markup 	= lain.util.markup
local string 	= string

--
-- needs `amixer`
--


local icon_path_on  = string.format("%s/.config/awesome/widgets/microphone/microphone.png", os.getenv("HOME"))
local icon_path_off = string.format("%s/.config/awesome/widgets/microphone/microphone-off.png", os.getenv("HOME"))
local default_timeout = 3600
local default_font = "monospace 11"

local microphon_widget = {}

local function worker(user_args)
	local args = user_args or {
		font = default_font,
		timeout = default_timeout,
	}

	local microphon_icon = wibox.widget.imagebox(icon_path_on)
	local microphonwidget = {
		state = 0, 
		widget = awful.widget.watch({awful.util.shell, '-c', 'amixer get Capture | grep "off"'}, args.timeout,
		function(widget, stdout)
			if stdout == nil or stdout == '' then
				microphon_icon.image = icon_path_on
				microphonwidget.state = 1
			else 
				microphon_icon.image = icon_path_off
				microphonwidget.state = 0
			end
		end)}

	microphon_widget = wibox.widget {
	    microphon_icon, 
	    microphonwidget.widget,
	    layout = wibox.layout.align.horizontal,
	}

	microphon_widget:buttons(awful.button({ }, 1, function()
		if microphonwidget.state == 1 then
			microphonwidget.state = 0
			awful.spawn.easy_async('amixer set Capture nocap')
			microphon_icon.image = icon_path_off

		else 
			microphonwidget.state = 1
			awful.spawn.easy_async('amixer set Capture cap')
			microphon_icon.image = icon_path_on
		end
	end))

	return microphon_widget
end

return setmetatable(microphon_widget, { __call = function(_, ...) return worker(...) end })
