#NoEnv 
SendMode Input 
SetWorkingDir %A_ScriptDir%  
#SingleInstance, force
#IfWinActive ahk_exe hl2.exe ; doesn't apply to the gui?????

Charged := False

CustomColor := "EEAA99"
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Color, %CustomColor%
Gui, Font, s30
Gui, Add, Text, vDTIndicator cWhite, DT
WinSet, TransColor, %CustomColor% 150

Goto, DoubleTapScript

LShift::NumpadDiv


DoubleTapScript:
Loop,
{ 
    if WinActive("ahk_exe hl2.exe")
    {
        Gui, Show, x0 y700 NoActivate ; this flashes a bit, will fix later lol
        ;dt
        {
            ;charge
            if GetKeyState("r", "P") && !Charged
            {
                Send {NumpadAdd down}
                Sleep, 15*26 ; high enough number who cares
                Send {NumpadAdd up}

                Charged:=True
            }

            ;dt
            if GetKeyState("LShift", "P") && Charged
            {
                

                ; stop movement
                Send {w up}
                Send {a up}
                Send {s up}
                Send {d up}

                Send {NumpadMult down} ; start shifting ticks
                Sleep, 15*8
                Send {NumpadMult up} ; end shifting

                ; check for player movement
                shouldCompForward := GetKeyState("w", "P")
                shouldCompRight := GetKeyState("d", "P")
                shouldCompLeft := GetKeyState("a", "P")
                shouldCompBackward := GetKeyState("s", "P")

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
        if Charged
        {
            Gui, Font, c30CA00
        }
        else if !Charged
        {
            Gui, Font, cFF0000
        }
        GuiControl, Font, DTIndicator 
    }
    if !WinActive("ahk_exe hl2.exe")
    {
        Gui, Hide
    }
}
