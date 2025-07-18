#Requires AutoHotkey v2.0

; === GUI Setup ===
myGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
myGui.BackColor := "Black"  ; Needed for transparency trick
WinSetTransColor("Black", myGui.Hwnd)  ; Makes black fully transparent
WinSetExStyle("+0x20", myGui.Hwnd)  ; WS_EX_TRANSPARENT (click-through)

myGui.SetFont("s10 Bold cWhite", "Lexend")
label := myGui.AddText("x10 w580 h30 vTitleText BackgroundTrans", "AW: Starting...")

; === Initial Show ===
myGui.Show("NoActivate")
RepositionOverlay()

; === Timers ===
SetTimer(UpdateTitle, 1000)
SetTimer(ForceTopmost, 500)

global lastShown := ""
global lastMonitorCount := MonitorGetCount()
SetTimer(CheckMonitors, 1000)  ; Watch for monitor changes


; === Functions ===

UpdateTitle(*) {
    global lastShown
    try {
        ; Get active window title
        title := WinGetTitle("A")
        title := (title != "") ? title : "[Untitled]"

        ; Get idle time in milliseconds
        idleMs := A_TimeIdlePhysical
        idleSec := idleMs // 1000
        idleMin := idleSec // 60
        idleRemSec := Mod(idleSec, 60)
        idleStr := Format("Idle: {:02}:{:02}", idleMin, idleRemSec)

        idleStr := (idleSec < 10) ? "" : Format("Idle: {:02}:{:02}  |  ", idleMin, idleRemSec)
        display := idleStr "AW: " title

        ; display := idleStr "  |  AW: " title

        if (display != lastShown) {
            label.Text := display
            lastShown := display
        }
    } catch {
        label.Text := "AW: [Error]"
    }
}


ForceTopmost(*) {
    WinSetAlwaysOnTop(true, myGui.Hwnd)
}

CheckMonitors(*) {
    global lastMonitorCount
    currentCount := MonitorGetCount()
    if (currentCount != lastMonitorCount) {
        lastMonitorCount := currentCount
        RepositionOverlay()
    }
}

RepositionOverlay() {
    global myGui

    targetMonitor := 2
    monitorCount := MonitorGetCount()

    if (targetMonitor > monitorCount)
        targetMonitor := 1  ; Fallback if monitor 2 is disconnected

    MonitorGetWorkArea(targetMonitor, &left, &top, &right, &bottom)

    guiW := 600
    guiH := 30
    marginX := 2
    marginY := -35  ; Adjust this to raise/lower from bottom

    x := left + marginX
    y := bottom - guiH - marginY

    myGui.Move(x, y, guiW, guiH)
}
