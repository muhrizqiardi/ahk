#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Script reload
^!5::Reload

;Window always on top
^SPACE::  Winset, Alwaysontop, , A

;Scroll between virtual desktops
^#WheelUp:: Send ^#{Left}    
^#WheelDown:: Send ^#{Right}    

;Scroll between browser tabs
^+WheelUp:: Send ^+{Tab}
^+WheelDown:: Send ^{Tab}

;Home & end button replacement
#,:: Send {Home}
#.:: Send {End} 
^#,:: Send ^{Home}
^#.:: Send ^{End} 
+#,:: Send +{Home}
+#.:: Send +{End} 
^+#,:: Send ^+{Home}
^+#.:: Send ^+{End} 


;Media button
LWin & F1:: Send {Media_Play_Pause}
LWin & F2:: Send {Media_Prev}
LWin & F3:: Send {Media_Next}

;Win + J to open Download folder
#j:: Run, D:\Downloads

;Sleep button
Lwin & z:: DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

;CMD shortcut
#^t:: run cmd.exe
#^!t:: Run *RunAs cmd.exe
#^p:: run, powershell.exe
#^!p:: Run *RunAs powershell.exe

;CMD in current folder
#c::opencmdhere()

; Press Win + C to open Command Prompt in the current directory.
opencmdhere() {
    If WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass") {
        WinHWND := WinActive()
        For win in ComObjCreate("Shell.Application").Windows
            If (win.HWND = WinHWND) {
		currdir := SubStr(win.LocationURL, 9)
		currdir := RegExReplace(currdir, "%20", " ")
                Break
            }
    }
    Run, cmd, % currdir ? currdir : "C:\"
}

#+c::opencmdhereadmin()
; Press Win + Shift + C to open admin Command Prompt in the current directory.

opencmdhereadmin() {
    If WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass") {
        WinHWND := WinActive()
        For win in ComObjCreate("Shell.Application").Windows
            If (win.HWND = WinHWND) {
		currdir := SubStr(win.LocationURL, 9)
		currdir := RegExReplace(currdir, "%20", " ")
		currdir := RegExReplace(currdir, "/", "\")
                Break
            }
    }

    Run *RunAs cmd.exe /k pushd %currdir%
}

;Hide desktop icons
!#D::

	;https://stackoverflow.com/questions/53109281/what-is-the-windows-workerw-windows-and-what-creates-them
	ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW

	; Toggle between displaying and hiding the desktop icons
	If DllCall("IsWindowVisible", UInt, HWND)
		WinHide, ahk_id %HWND%
	Else
		WinShow, ahk_id %HWND%

;Change desktop with mouse button right & scroll wheel
