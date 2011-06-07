local lock = "slimlock"
local ck = "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" "
			.. "/org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager."
local suspend = "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" "
				.. "/org/freedesktop/UPower org.freedesktop.UPower.Suspend"

logoutmenu = {
	{ "Shutdown", ck .. "Stop", freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) },
	{ "Reboot", ck .. "Restart",  freedesktop.utils.lookup_icon({ icon = 'system-log-out' }) },
	{ "Suspend", suspend, freedesktop.utils.lookup_icon({ icon = 'media-playback-pause' }) },
	{ "Lock screen", lock, freedesktop.utils.lookup_icon({ icon = 'system-lock-screen' }) },
}

