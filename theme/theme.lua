---------------------------
-- Smoked awesome theme  --
---------------------------

theme_base = "/home/kevin/.config/awesome/theme/"

theme = {}

--theme.font          = "Andika Basic 8"
theme.font = "Droid Sans 8"
--theme.taglist_font = "Bitstream Vera Sans 8"
--theme.font = "Sans 8"

--theme.bg_normal     = "#eeeeecee" --dd
--theme.bg_normal     = "#e3e3d9ee" --dd
theme.bg_normal     = "#61645B" --dd
--theme.bg_focus      = "#4f5353ee"
--theme.bg_focus      = "#63645fee"
theme.bg_focus      = "#8D8873"
theme.bg_urgent     = "#DC8536"
theme.bg_minimize   = "#352E2A"

--theme.fg_normal     = "#505050"
theme.fg_normal     = "#E7E5DE"
--theme.fg_focus      = "#b9bbbb"
theme.fg_focus      = "#F5F5F5"
theme.fg_urgent     = "#f7f7f7"
theme.fg_minimize  = "#b9bbbb"

theme.border_width  = "1"
theme.border_normal = "#cbc8c1"
theme.border_focus  = "#282421"
theme.border_marked = "#f7f7f7"

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = theme_base .. "taglist/squarefw.png"
theme.taglist_squares_unsel = theme_base .. "taglist/square.png"

theme.tasklist_floating_icon = theme_base .. "tasklist/floatingw.png"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_base .. "submenu.png"
theme.menu_height   = "13"
theme.menu_width    = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--bg_widget    = #cc0000

-- Define the image to load
theme.titlebar_close_button_normal = theme_base .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus = theme_base .. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_base .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme_base .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_base .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme_base .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_base .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme_base .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_base .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme_base .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_base .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme_base .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_base .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme_base .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive =
	theme_base .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive =
	theme_base .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active =
	theme_base .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active =
	theme_base .. "titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/kevin/Pictures/snail.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = theme_base .. "layouts/fairh.png"
theme.layout_fairv = theme_base .. "layouts/fairv.png"
theme.layout_floating = theme_base .. "layouts/floating.png"
theme.layout_magnifier = theme_base .. "layouts/magnifier.png"
theme.layout_max = theme_base .. "layouts/max.png"
theme.layout_fullscreen = theme_base .. "layouts/fullscreen.png"
theme.layout_tilebottom = theme_base .. "layouts/tilebottom.png"
theme.layout_tileleft = theme_base .. "layouts/tileleft.png"
theme.layout_tile = theme_base .. "layouts/tile.png"
theme.layout_tiletop = theme_base .. "layouts/tiletop.png"

--theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"
theme.awesome_icon = theme_base .. "awesome-icon-3.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
