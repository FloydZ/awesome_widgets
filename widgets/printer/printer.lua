local wibox 	= require("wibox")
local awful 	= require("awful")
local naughty 	= require("naughty")
local watch 	= require("awful.widget.watch")
local string 	= string

--
-- needs `lpq`
--

local icon_path = string.format("%s/.config/awesome/widgets/printer/printer.png", os.getenv("HOME"))
local printer_icon = wibox.widget.imagebox(icon_path)
local default_timeout = 5
local default_hover_timeout = 0.5

printer_widget = wibox.widget.textbox()


local function show_queue()
    awful.spawn.easy_async([[bash -c 'lpq -a']],
        function(stdout, stderr, reason, exitcode)
            naughty.notify{
                text = stdout,
                title = "Queue",
                timeout = default_timeout,
				hover_timeout = default_hover_timeout,
            }
        end
    )
end

local function show_information()
    awful.spawn.easy_async([[bash -c 'lpstat -t']],
        function(stdout, stderr, reason, exitcode)
            naughty.notify{
                text = stdout,
                title = "Information",
                timeout = default_timeout,
				hover_timeout = default_hover_timeout,
            }
        end
    )
end

printer_icon:buttons(awful.button({ }, 1, function() show_information() end))
printer_icon:connect_signal("mouse::enter", function() show_queue() end)

local widget = wibox.widget {
   	printer_icon, 
	printer_widget,
   	layout = wibox.layout.align.horizontal,
}

return widget
