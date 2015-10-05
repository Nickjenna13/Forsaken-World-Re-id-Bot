#Include ImageSearchList.ahk
Msgbox,,Re-ID, Re-ID Bot for Forsaken World `nVersion 2.0: Massive re-work: All new code and options for multiple IDs `nWritten By Nickohlas Melfi `n`nCommands:`nCtrl+i : Select item to ID`nCtrl+o : Select Re-ID box`nCtrl+p : Run the bot, Please use I and O before P or you will get an error`nCtrl+l : Pause bot while active`nCtrl+e : Debugging `nCtrl+t : Test
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
Return

^l::Pause  ;windows+p pauses script
SetControlDelay -1

^p:: ;control + p start script
baseStat := 0
statsSingle := 0 
statsDouble := 0
statsTriple := 0
totalRuns :=0
foundStat :=0
targetStat :=0

MsgBox, 4,, Has this item got base stat of the same type (on the top)?
IfMsgBox Yes
{
	baseStat:= -1
}
else
{
	baseStat= 0
}

InputBox, UserInput, Target, Please enter the target number of additional ID stats (on the bottom) that you want: 1/2/3 , , , 
if ErrorLevel
{
	MsgBox, CANCEL was pressed. 
	Return
}
else
{
	targetStat=%UserInput%
}
	
	
Loop,
{
	countItem = 0
	MouseMove, %IX%, %IY% 
	Sleep , 1200
	glob_List := ImageSearchList("*80 *TransWhite A_CDam.png",0,0,0,0,",","`n","f_MyDebug")
	
	Loop, Parse, glob_List, `n
	{
		countItem++
	}
	if countItem > 0
	{
		countItem--
	}
	
	
	foundStat:= baseStat+countItem
	
	if (foundStat == -1)
	{
		MsgBox, Something went wrong foundStat is returning - 1 Ending.
		Exit
	}
	
	if (foundStat == 1)
	{
		statsSingle++
	}
	if (foundStat == 2)
	{
		statsDouble++
	}
	if (foundStat == 3)
	{
		statsTriple++
	}
	
	if foundStat >= %targetStat%
	{
		MsgBox, Target Found `nSingle Stats ID's: %statsSingle% `nDouble Stats ID's: %statsDouble%`nTriple Stats ID's: %statsTriple%`nTotal Runs: %totalRuns%
		Exit
	}
	
	totalRuns++
	
	MouseClick, right, %IX%, %IY% 
	Sleep, 150
	Click %BX% ,%BY%
	Sleep, 2200
	
	remainder:=Mod(totalRuns,5) 
	if (remainder =0)
	{
		TrayTip , Fun fact, `nSingle Stats ID's: %statsSingle% `nDouble Stats ID's: %statsDouble%`nTriple Stats ID's: %statsTriple%`nTotal Runs: %totalRuns%,2,
	}
	
	
}	
Return


^o:: ;control + O to define item
TrayTip , Re-Id bot, Left click and on Identify button, 2,
Hotkey, LButton, Record2, on ;creates a hotkey 'LButton'
return

^i:: ;control + i to define id button
TrayTip , Re-Id bot, Left click the Item, 2,
Hotkey, LButton, Record, on ;creates a hotkey 'LButton'
return

^e:: ;ignore
msgbox, IX (Item) = %IX% IY (Item) = %IY%
msgbox, BX (Box)= %BX% BY (Box)= %BY%
return

Record:
MouseGetPos, IX, IY
Hotkey, LButton, off ;turns 'LButton' hotkey off
return

Record2:
MouseGetPos, BX, BY
Hotkey, LButton, off ;turns 'LButton' hotkey off
return

^t::
F12::
  glob_List := ImageSearchList("*80 *TransWhite A_CDam.png",0,0,0,0,",","`n","f_MyDebug")
  ToolTip
  MsgBox, % "ImageSearchList() output:`n" glob_List
  MsgBox, % "Moving mouse to each found coordinate..."
  Loop, Parse, glob_List, `n
  {
    Click %A_LoopField% 0
    Sleep, 100
  }
  MsgBox, % "Finished!"
Return
