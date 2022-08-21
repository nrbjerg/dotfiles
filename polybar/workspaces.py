#!/usr/bin/env python3
from i3ipc import Connection, Event

i3 = Connection()

focused = i3.get_tree().find_focused().workspace().num

out = ""

for i in range(1, 5):
    if i == focused:
        out += "%{F#a84}"

    if i != 1:
        out += " "

    out += str(i) + "%{F-}"

print(out)
