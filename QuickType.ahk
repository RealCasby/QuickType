#Requires AutoHotkey v2.0
#SingleInstance Force

; Initialize default coordinates so the script works right away
global targetX := 1349
global targetY := 390

; --- EMERGENCY PANIC BUTTON (GLOBAL) ---
; Placed at the top so it works even when Premiere Pro is closed or minimized
^k::
{
    ; Popup notification when closing the program
    MsgBox("Premiere Macro Script has been closed.", "Script Exited", "Icon! T2")
    ExitApp
}

; --- PREMIERE SPECIFIC HOTKEYS ---
#HotIf WinActive("ahk_exe Adobe Premiere Pro.exe")

; --- NEW MACRO: SET CUSTOM COORDINATES ---
^e::
{
    ; Wait for the user to press the Left Mouse Button
    KeyWait "LButton", "D"
    
    ; Get the mouse position relative to the active Window
    CoordMode "Mouse", "Window"
    MouseGetPos &mouseX, &mouseY
    
    ; Update the global variables
    global targetX := mouseX
    global targetY := mouseY
    
    ; --- NEW ACTIONS ---
    ; Double-click the newly set dimensions
    Click targetX, targetY, 2
    Sleep 50
    
    ; Focus the Timeline panel
    Send "+3"
    Sleep 50
    
    ; Deselect all layers
    Send "^+a"
    Sleep 50
    
    ; Success confirmation popup (automatically closes after 2 seconds)
    MsgBox("Dimensions set to: " targetX ", " targetY, "Coordinates Updated", "Iconi T2")
}

; --- MACRO 1: TEXT CREATION, EDITING, & SELECT ALL ---
; The '$' prevents the script from triggering itself when it sends '^t'
$^t::
{
    CoordMode "Mouse", "Window"

    ; Cleaned up! Workspace change removed.
    ; This sends the default Premiere "New Text Layer" shortcut
    Send "^t"            
    Sleep 150
    
    Send "^+c"           ; Align Center
    Sleep 150
    Click targetX, targetY, 2   
    Sleep 50
    Send "^a"
}

; --- MACRO 2: EXIT EDITING, DESELECT, RETURN TO PREVIOUS WORKSPACE ---
^g::
{
    Send "{Esc}"
    Sleep 50
    Send "+3"         ; Shift+3 — focuses the Timeline panel
    Sleep 50
    Send "^+a"          ; Deselect All
    Sleep 50
}