-- applications menu
require('freedesktop.utils')
freedesktop.utils.terminal = terminal
freedesktop.utils.icon_theme = 'gnome'
require('freedesktop.menu')
local lock = "slimlock"
local ck = "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" "
			.. "/org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager."
local suspend = "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" "
				.. "/org/freedesktop/UPower org.freedesktop.UPower.Suspend"

local logoutmenu = {
	{ "Shutdown", ck .. "Stop", freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) },
	{ "Reboot", ck .. "Restart",  freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
	{ "Suspend", suspend, freedesktop.utils.lookup_icon({ icon = 'media-playback-pause' }) },
	{ "Lock screen", lock, freedesktop.utils.lookup_icon({ icon = 'system-lock-screen' }) },
	{ "Log out", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'system-log-out' }) },
}

awful.menu.menu_keys = { up = { "j", "Up" },
						 down = { "k", "Down" },
						 exec = { "Return", "l", "Right" },
						 back = { "Left", "h", "Escape" } }

menu_items = freedesktop.menu.new()
myawesomemenu = {
   { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'help' }) },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
   { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
   { "quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'gtk-quit' }) }
}


table.insert(menu_items, { "awesome", myawesomemenu, beautiful.awesome_icon })
table.insert(menu_items, { "open terminal", terminal, freedesktop.utils.lookup_icon({icon = 'terminal'}) })
table.insert(menu_items, { "session", logoutmenu, freedesktop.utils.lookup_icon({ icon = 'system-log-out' }) })

mymainmenu = awful.menu.new({ items = menu_items, width = 150 })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                   menu = mymainmenu })

-- desktop icons
require('freedesktop.desktop')
for s = 1, screen.count() do
    freedesktop.desktop.add_applications_icons({screen = s, showlabels = true})
    freedesktop.desktop.add_dirs_and_files_icons({screen = s, showlabels = true})
end

