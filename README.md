# Active Window Overlay

This AutoHotkey v2 script creates a lightweight, always-on-top overlay that displays the currently active window title, along with system idle time (if applicable). It stays out of the way, remains click-through, and automatically adapts to monitor setup changes.

## Features

* Displays the current active window title in real time
* Shows idle time if the user has been inactive for more than 10 seconds
* Transparent, click-through overlay that stays always on top
* Automatically repositions if monitor configuration changes
* Targets monitor 2 by default (falls back to monitor 1)

## Requirements

* Windows
* [AutoHotkey v2](https://www.autohotkey.com/)
* Optional: Lexend font (or change to a font of your choice in the script)

## Getting Started

1. Install AutoHotkey v2.
2. Save the script as `ActiveWindowOverlay.ahk`.
3. Run the script by double-clicking the file.

The overlay will appear near the bottom-left of your second monitor. If monitor 2 isn’t available, it will default to monitor 1.

> **Note:** The default position may not fit all screen setups. If the overlay is cut off or not visible, you may need to adjust the `marginY` and `targetMonitor` values in the `RepositionOverlay()` function near the bottom of the script.

## Customization

You can modify the following lines in the `RepositionOverlay()` function to fine-tune placement:

```ahk
targetMonitor := 2       ; Change to 1 or another number if needed
marginX := 2             ; Horizontal margin from screen edge
marginY := -35           ; Vertical offset from bottom of screen
```

You can also change the font, size, or color here:

```ahk
myGui.SetFont("s10 Bold cWhite", "Lexend")
```

## Example Output

```
Idle: 01:12  |  AW: Microsoft Excel - Report.xlsx
```

If idle time is less than 10 seconds, it’s hidden for clarity.

## License

This script is free to use and modify for personal or professional use.
