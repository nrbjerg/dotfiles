# coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401from typing import List  # noqa: F401

mod = "mod4"              # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"      # My terminal of choice
myBrowser = "firefox"     # My web-browser of choice

keys = [
         ### The essentials
         Key([mod], "Return",
             lazy.spawn(myTerm),
             desc='Launches My Terminal'
             ),
         Key([mod, "shift"], "Return",
             lazy.spawn("dmenu_run -p 'Run: '"),
             desc='Run Launcher'
             ),
         # Program launcher
         KeyChord([mod], "p", [
             Key([], "e",
                 lazy.spawn("emacsclient -c -a 'emacs'"),
                 desc='Launch Emacs'
                 ),
             Key([], "c",
                 lazy.spawn("code"),
                 desc='Launch VS-Code'
                 ),
             Key([], "w",
                 lazy.spawn("firefox"),
                 desc="Launch Firefox"
                 ),
             Key([], "b",
                 lazy.spawn("brave-browser"),
                 desc="Launch Brave"
                 ),
             Key([], "s",
                 lazy.spawn("spotify"),
                 desc="Launch Spotify"
                 ),
             Key([], "d",
                 lazy.spawn("discord"),
                 desc="Launch Discord")
             ]),
         Key([mod], "Tab",
             lazy.next_layout(),
             desc='Toggle through layouts'
             ),
         Key([mod, "shift"], "c",
             lazy.window.kill(),
             desc='Kill active window'
             ),
         Key([mod, "shift"], "r",
             lazy.restart(),
             desc='Restart Qtile'
             ),
         Key([mod, "shift"], "q",
             lazy.shutdown(),
             desc='Shutdown Qtile'
             ),
         ### Switch focus to specific monitor (out of two)
         Key([mod, "shift"], "1",
             lazy.to_screen(0),
             desc='Keyboard focus to monitor 1'
             ),
         Key([mod, "shift"], "2",
             lazy.to_screen(1),
             desc='Keyboard focus to monitor 2'
             ),
         ### Switch focus of monitors
         Key([mod], "period",
             lazy.next_screen(),
             desc='Move focus to next monitor'
             ),
         Key([mod], "comma",
             lazy.prev_screen(),
             desc='Move focus to prev monitor'
             ),
         ### Window controls
         Key([mod], "j",
             lazy.layout.down(),
             desc='Move focus down in current stack pane'
             ),
         Key([mod], "k",
             lazy.layout.up(),
             desc='Move focus up in current stack pane'
             ),
         Key([mod, "shift"], "j",
             lazy.layout.shuffle_down(),
             lazy.layout.section_down(),
             desc='Move windows down in current stack'
             ),
         Key([mod, "shift"], "k",
             lazy.layout.shuffle_up(),
             lazy.layout.section_up(),
             desc='Move windows up in current stack'
             ),
         Key([mod], "h",
             lazy.layout.shrink(),
             lazy.layout.decrease_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], "l",
             lazy.layout.grow(),
             lazy.layout.increase_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
         Key([mod], "n",
             lazy.layout.normalize(),
             desc='normalize window size ratios'
             ),
         Key([mod], "m",
             lazy.layout.maximize(),
             desc='toggle window between minimum and maximum sizes'
             ),
         Key([mod, "shift"], "f",
             lazy.window.toggle_floating(),
             desc='toggle floating'
             ),
         Key([mod], "f",
             lazy.window.toggle_fullscreen(),
             desc='toggle fullscreen'
             ),
         ### Stack controls
         Key([mod, "shift"], "Tab",
             lazy.layout.rotate(),
             lazy.layout.flip(),
             desc='Switch which side main pane occupies (XmonadTall)'
             ),
          Key([mod], "space",
             lazy.layout.next(),
             desc='Switch window focus to other pane(s) of stack'
             ),
         Key([mod, "shift"], "space",
             lazy.layout.toggle_split(),
             desc='Toggle between split and unsplit sides of stack'
             ),
]

groups = [Group("dev", {'layout': 'max'}),
              Group("www", {'layout': 'monadtall'}),
              Group("cmd", {'layout': 'monadtall'}),
              Group("mus", {'layout': 'monadtall'}),
              Group("soc", {'layout': 'monadtall'})]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

# Colors
bg     = "#1b1d24"
bg_alt = "#242730"
fg     = "#bbc2cf"
fg_alt = "#757B80"

red        = "#E36D76"
dark_red   = "#C34D56"
orange     = "#D39467"
green      = "#96C376"
dark_green = "#669346"
light_blue = "#5AC9D6"
yellow     = "#E6C181"
purple     = "#E18EF3"
blue       = "#51afef"
magenta    = "#C57BDB"
cyan       = "#5cEfFF"
violet     = "#B26FC1"

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": blue,
                "border_normal": bg_alt
                }

layouts = [
    #layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2),
    # layout.RatioTile(**layout_theme),
    # layout.Floating(**layout_theme)
]


colors = [["#242730", "#242730"], # panel background
          ["#3d3f4b", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#99C366", "#99C366"], # border line color for current tab
          ["#96C376", "#96C376"], # border line color for 'other tabs' and color for 'odd widgets'
          ["#4f76c7", "#4f76c7"], # color for the 'even widgets'
          ["#e1acff", "#e1acff"], # window name
          ["#ecbbfb", "#ecbbfb"]] # backbround for inactive screens

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="JetBrains Mono Bold",
    fontsize = 14,
    padding = 2,
    background=bg
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
              widget.GroupBox(
                       font = "Hack Bold",
                       fontsize = 12,
                       margin_y = 3,
                       margin_x = 6,
                       padding_y = 5,
                       padding_x = 6,
                       borderwidth = 3,
                       active = fg,
                       inactive = fg_alt,
                       rounded = False,
                       highlight_color = bg_alt,
                       highlight_method = "line",
                       this_current_screen_border = red,
                       this_screen_border = dark_red,
                       other_current_screen_border = red,
                       other_screen_border = dark_red,
                       foreground = fg,
                       background = bg
                       ),
              widget.WindowName(
                       font = "Hack Bold",
                       foreground = blue,
                       background = bg,
                       padding = 2,
                       max_chars = 24
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 10,
                       ),
              widget.Systray(
                       background = bg,
                       padding = 5
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = bg,
                       background = bg
                       ),
             widget.Net(
                       interface = ["l0", "eno1", "wlo1"],
                       format = '{down} ↓↑ {up}',
                       foreground = colors[2],
                       background = bg,
                       padding = 5
                       ),
              widget.CPU(
                  foreground = yellow,
                  background = bg,
                  format = "CPU: {freq_current} GHz {load_percent}%"
              ),
              widget.ThermalSensor(
                       tag_sensor = "Package id 0",
                       foreground = yellow,
                       foreground_alert = red,
                       background = bg,
                       threshold = 90,
                       padding = 5
              ),
              widget.NvidiaSensors (
                  foreground = yellow,
                  foreground_alert = red,
                  format = "GPU: {perf} {temp}°C"
              ),
              widget.CheckUpdates(
                       update_interval = 1800,
                       colour_no_updates = light_blue,
                       colour_have_updates = light_blue,
                       distro = "Ubuntu",
                       display_format = " {updates} Update(s)",
                       mouse_callbacks = {'Button1': lambda: qtile.spawn(myTerm + ' -e  sudo apt update && sudo apt upgrade')}, # NOTE: Updates the system
                       background = bg,
                       no_update_string = " 0 Update(s)"
                       ),
              widget.Memory(
                       format = " RAM:{MemUsed: .0f}{mm} or {MemPercent}%",
                       foreground = green,
                       background = bg,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')}
                       ),
              widget.TextBox(
                       text = " Vol: ",
                       foreground = red,
                       background = bg,
                       padding = 0
                       ),
              widget.Volume(
                       foreground = red,
                       background = bg,
                       padding = 5
                       ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                       foreground = fg,
                       background = bg,
                       padding = 0,
                       scale = 0.7
                       ),
              widget.CurrentLayout(
                       foreground = fg,
                       background = bg,
                       padding = 5
                       ),
              widget.Battery(
                  foreground = blue,
                  background = bg,
                  battery = 1,
                  format = "Bat: {char} {percent:2.0%}"
              ),
              widget.Clock(
                       foreground = purple,
                       background = bg,
                       format = " %A, %B %d - %H:%M "
                       )
              ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[3:4]               # Slicing removes unwanted widgets (systray) on Monitors 1,3
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                 # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

@hook.subscribe.client_new
def client_hook(client):
    if client.name == "Emacs":
        client.togroup("dev")
    elif client.name == "Firefox":
        client.togroup("www")

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
