local helpers      = require("lain.helpers")
local shell        = require("awful.util").shell
local wibox        = require("wibox")
local lines, floor = io.lines, math.floor
local string       = { format = string.format,
                       gsub   = string.gsub }

-- needs `users` which is installed everywhere
-- 

local default_timeout = 120

-- Available updates
local function factory(args)
    local users   = { widget = wibox.widget.textbox() }
    local args     = args or { }
    local timeout  = args.timeout or default_timeout
    local settings = args.settings or function() end
    local cmd      = "users | wc -w"

    function users.update()
        helpers.async({ shell, "-c", cmd }, function(f)
            logged_in = f

            widget = users.widget
            settings()
        end)
    end

    helpers.newtimer("users", timeout, users.update)

    return users
end

return factory
