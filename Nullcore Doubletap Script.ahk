#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
#IfWinActive ahk_exe hl2.exe

Charged := False

Goto, DoubleTapScript

LShift::NumpadDiv

DoubleTapScript:
Loop,
{ 
    if WinActive("ahk_exe hl2.exe")
    {
        ;dt
        {
            ;charge
            if GetKeyState("r", "P") && Charged=False
            {
                Send {NumpadAdd down}
                Sleep, 15*26 ; high enough number who cares
                Send {NumpadAdd up}

                Charged:=True
            }

            ;dt
            if GetKeyState("LShift", "P") && Charged=True
            {
                ; check for player movement
                shouldCompForward := GetKeyState("w", "P")
                shouldCompRight := GetKeyState("d", "P")
                shouldCompLeft := GetKeyState("a", "P")
                shouldCompBackward := GetKeyState("s", "P")

                ; stop movement
                Send {w up}
                Send {a up}
                Send {s up}
                Send {d up}

                Send {NumpadMult down} ; start shifting ticks
                Sleep, 15*10
                Send {NumpadMult up} ; end shifting

                ; allow the user to move again
                if shouldCompBackward{
                    Send {s down}
                }
                if shouldCompForward{
                    Send {w down}
                }
                if shouldCompRight{
                    Send {d down}
                }
                if shouldCompLeft{
                    Send {a down}
                }

                Charged:=False
            }

        }
    }
}