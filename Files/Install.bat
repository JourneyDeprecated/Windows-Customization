:: Setting DOS Window Color
color 07

:: Setting DOS Windows Title
title Black Theme ToolKit v2.0.0

echo.
echo.===============================================================================
echo.
echo.                             Choose Your Color Preference
echo.
echo.
echo.                             1)  White on BLUE Background
echo.
echo.                             2)  White on BLACK Background
echo.
echo.===============================================================================
echo.
echo.       YOU CAN CUSTOMIZE THE OPACITY FOR THIS PROGRAM AT ANY TIME BY PRESSING 
echo.
echo.                            CONTROL SHIFT + TO INCREASE
echo.                                          OR
echo.                            CONTROL SHIFT - TO DECREASE
echo.
echo.===============================================================================
echo.
echo.
echo.
echo.
echo.
choice /C:12X /N /M "Enter Your Choice : "
if errorlevel 2 goto :black
if errorlevel 1 goto :blue

:black
cls
color 07
goto :ADMIN

:blue
cls
color 17
goto :ADMIN

:ADMIN
cls

@REM [This code block detects if the script is running with ADMIN PRIVILEGES. If it isn't it pauses, and then quits.]
echo OFF
cls
NET SESSION >nul 2>and1
IF %ERRORLEVEL% EQU 0 (
    ECHO Administrator PRIVILEGES Detected! 
) ELSE (
   echo ######## ########  ########   #######  ########  
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ######   ########  ########  ##     ## ########  
   echo ##       ##   ##   ##   ##   ##     ## ##   ##   
   echo ##       ##    ##  ##    ##  ##     ## ##    ##  
   echo ######## ##     ## ##     ##  #######  ##     ## 
   echo.
   echo.
   echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
   echo This script must be run as administrator to work properly!  
   echo If you are seeing this right click on Install.cmd and select 
   echo "Run As Administrator."
   echo ##########################################################
   echo.
   PAUSE
   EXIT /B 1
)
@echo OFF

:: Setting DOS Character Code Page to English
chcp 437 >nul

:: Setting DOS Window and Screen Buffer Size to 80 x 25
reg add "HKEY_CURRENT_USER\Console\%%SystemRoot%%_system32_cmd.exe" /v "ScreenBufferSize" /t REG_DWORD /d 0x23290050 /f >nul
reg add "HKEY_CURRENT_USER\Console\%%SystemRoot%%_system32_cmd.exe" /v "WindowSize" /t REG_DWORD /d 0x190050 /f >nul

%~d0
cd %~d0%~p0
cls

set version=0.0.0000
set name=Windows
set allow=1

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==5.1.2600 (
    set name=Windows XP
     set allow=0
)

if %version%==5.2.3790 (
    set name=Windows XP x64
     set allow=0
)

if %version%==6.0.6002 (
    set name=Windows Vista SP2
     set allow=0
)

if %version%==6.1.7601 (
    set name=Windows 7 SP1
     set allow=0
)

if %version%==6.2.9200 (
    set name=Windows 8
     set allow=0
)

if %version%==6.3.9600 (
    set name=Windows 8.1
     set allow=0
)

if %allow%==0 echo Sorry, this Toolkit is not compatible with your Operating System.
if %allow%==1 goto Toolkit
pause
goto :EOF

:Toolkit

cls
copy ACL\SetACL.exe %SYSTEMROOT%\System32\
cls
echo.===============================================================================
echo.±±±±±±±±±±±±±±±±±±±±±±±±±±±Black Theme ToolKit±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
echo.===============================================================================
echo.
echo. This Toolkit will change the Appearance of File Explorer, Media Player,
echo.
echo. Modern Apps, and other windows to BLACK in Windows 10!  It will not work on
echo.
echo. other versions of Windows.  If you are reading this your OS is compatible.
echo.
echo.
echo. You will have a choice of many new themes in addition to all of your
echo.
echo. previously installed themes.  
echo.
echo.
echo. Many Additional Customizations Are Included.  A Restart is Suggested.
echo.
echo.
echo. You Have an Option to Create a Restore Point after pressing Enter!
echo.
echo.               USE THIS TOOLKIT AT YOUR OWN RISK!!!
echo.
echo.===============================================================================
echo Press ENTER Key to Continue 
pause >nul

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                        For Safety Create a Restore Point
echo.
echo.                    Would You Like to Create a Restore Point?
echo.
echo.                             1)  Yes
echo.
echo.                             2)  No
echo.
echo.===============================================================================

choice /C:12X /N /M "Enter Your Choice : "
if errorlevel 2 goto :UACMenu
if errorlevel 1 goto :SystemRestore

:SystemRestore
cls

echo. System Restore Will Be Enabled
echo.
echo.
echo.
echo.
pause

Reg.exe add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f
powershell "& "".\backup\sysrestore.ps1"""

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f
start BackUp\SystemRestore.vbs

echo.
echo.
echo. Enter a Name for Your Restore Point in Pop-Up Window
echo.
echo.
echo.                     -- Click OK --
echo.
echo.
pause

goto :UACMenu

:UACMenu

cls
echo.===============================================================================
echo.                  Do You Want to Change The User Account Control Setting?
echo.===============================================================================
echo.
echo.                             [1]   Always Notify
echo.
echo.                             [2]   Default -- Notify When Apps Make Changes
echo.
echo.                             [3]   Default -- But Do Not Dim My Screen
echo.
echo.                             [4]   Never Notify Me
echo.
echo.                             [5]   Main Menu
echo.
echo.                             [X]   Quit
echo.
echo.===============================================================================
choice /C:123456X /N /M "Enter Your Choice : "
if errorlevel 6 goto :QuitProgram
if errorlevel 5 goto :MainMenu
if errorlevel 4 goto :NeverNotify
if errorlevel 3 goto :NoDim
if errorlevel 2 goto :Default
if errorlevel 1 goto :Always

:Always
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "2" /f
goto :MainMenu

:Default
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f
goto :MainMenu

:NoDim
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f
goto :MainMenu

:NeverNotify
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f
goto :MainMenu

:MainMenu

cls
echo.===============================================================================
echo.                           Black Theme ToolKit - Main Menu
echo.===============================================================================
echo.
echo.                             [1]   Build TH1 Install/Uninstall
echo.
echo.                             [2]   Build TH2 Install/Uninstall
echo.                                   Includes UltrUXThemePatcher
echo.
echo.                             [3]   Builds RS1/RS2/RS3 Install/Uninstall
echo.
echo.                             [4]   ULTRA BLACK
echo.
echo.                             [5]   UltraUXThemePatcher Install/Uninstall
echo.                                   For TH1 ONLY
echo.
echo.                             [6]   File Explorer Cleanup
echo.
echo.                             [7]   Desktop Customizations
echo.
echo.                             [8]   User Account Control Settings
echo.
echo.                             [9]   Restart Explorer
echo.
echo.                             [X]   Quit
echo.
echo.===============================================================================
choice /C:123456789X /N /M "Enter Your Choice : "
if errorlevel 10 goto :QuitProgram
if errorlevel 9 goto :RestartExplorer
if errorlevel 8 goto :UACMenu
if errorlevel 7 goto :EvenMoreFeatures
if errorlevel 6 goto :Features
if errorlevel 5 goto :UltraX
if errorlevel 4 goto :UltraBlack
if errorlevel 3 goto :RS1Menu
if errorlevel 2 goto :TH2Menu
if errorlevel 1 goto :TH1Menu

:RestartExplorer
taskkill /F /IM explorer.exe
start explorer.exe
goto :MainMenu


:TH1Menu

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                     Please Choose from the list for Windows 10 TH1 
echo.                                      Black Theme
echo.
echo.                             1)  Install
echo.
echo.                             2)  Uninstall
echo.
echo.                             3)  Main Menu
echo.
echo.===============================================================================

choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :MainMenu
if errorlevel 2 goto :RemoveMenu
if errorlevel 1 goto :TH1Start

:TH1Start

cls

set version=0.0.0000
set name=Windows
set allow=0

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==10.0.10240 (
    set name=Windows 10
     set allow=1
)

if %allow%==0 echo Sorry, this Operating System is not compatible with your selection.
pause
if %allow%==1 goto StartTH1Now

goto :MainMenu

:StartTH1Now

cls

xcopy Themes_TH1 %SYSTEMROOT%\Resources\Themes\ /e /i /h /y /k /o /x

setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn ace -ace "n:Administrators;p:full"

Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f3ffffff0000000000000000000000009001000000000001000005005300650067006f0065002000550049002000530065006d00690062006f006c006400000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorInactive" /t REG_DWORD /d "3290373919" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "100" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "4294967286" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f

start UxStyle\UxStyle.exe /install /quiet

xcopy OldNewExplorer "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\" /e /i /h /y /k /o /x

@REM [Change Windows Media Player to Black]
takeown /F %SYSTEMROOT%\System32\wmploc.dll
icacls %SYSTEMROOT%\System32\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\System32\wmploc.dll wmploc.dll.bak
copy Black_WMP\64bit\wmploc.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\SysWOW64\wmploc.dll
icacls %SYSTEMROOT%\SysWOW64\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\SysWOW64\wmploc.dll wmploc.dll.bak
copy Black_WMP\32bit\wmploc.dll %SYSTEMROOT%\SysWOW64\

Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /t REG_SZ /d "#1A1A1A" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /t REG_SZ /d "#FFFFFF" /f

RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer64.dll"
RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer32.dll"

cls
@echo off
echo.===============================================================================
echo.
echo.   Choose Your Old New Explorer Options:  Plus is Checked, Minus is Unchecked
echo.
echo.===============================================================================
echo.     1                                              2
echo.
echo.     +  Use command bar instead of Ribbon           +
echo.     +  Hide caption text in File Explorer windows  -
echo.     +  Hide caption icon in File Explorer windows  -
echo.     +  Hide Up button                              -
echo.     +  Enable glass on navigation bar              +
echo.     -  Use alternate navigation buttons style      +
echo.     +  Show details pane on the bottom             +
echo.
echo.     Choose 1, 2, or 3 -- I prefer configuring ONE myself
echo.
echo.===============================================================================
choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :ONEconfig3
if errorlevel 2 goto :ONEconfig2
if errorlevel 1 goto :ONEconfig1

:ONEconfig1

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "0" /f
goto :TH1end

:ONEconfig2

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "1" /f
goto :TH1end

:ONEconfig3

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.  MAKE YOUR CHOICES THEN PRESS CLOSE
"%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorerCfg.exe"
goto :TH1end

:TH1end

cls
echo.
echo.

taskkill /f /im explorer.exe
start explorer.exe

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                     You Can Now Use Your Themes After Exiting  
echo.                      
echo.===============================================================================

echo Press ENTER Key to Continue 
pause >nul

goto :MainMenu

:TH2Menu

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                     Please Choose from the list for Windows 10 10586
echo.                                        Black Theme
echo.
echo.                             1)  Install
echo.
echo.                             2)  Uninstall
echo.
echo.                             3)  Main Menu
echo.
echo.===============================================================================

choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :MainMenu
if errorlevel 2 goto :RemoveMenu
if errorlevel 1 goto :TH2Start

:TH2Start

cls

set version=0.0.0000
set name=Windows
set allow=0

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==10.0.10586 (
    set name=Windows 10
     set allow=1
)

if %allow%==0 echo Sorry, this Operating System is not compatible with your selection.
pause
if %allow%==1 goto StartTH2Now

goto :MainMenu

:StartTH2Now

cls

takeown /F %SYSTEMROOT%\System32\themeui.dll
icacls %SYSTEMROOT%\System32\themeui.dll /grant "Everyone":F
REN %SYSTEMROOT%\System32\themeui.dll themeui.dll.bak
copy PatchTH2\themeui.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\System32\uxinit.dll
icacls %SYSTEMROOT%\System32\uxinit.dll /grant "Everyone":F
REN %SYSTEMROOT%\System32\uxinit.dll uxinit.dll.bak
copy PatchTH2\uxinit.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\System32\uxtheme.dll
icacls %SYSTEMROOT%\System32\uxtheme.dll /grant "Everyone":F
REN %SYSTEMROOT%\System32\uxtheme.dll uxtheme.dll.bak
copy PatchTH2\uxtheme.dll %SYSTEMROOT%\System32\

xcopy Themes_TH2 %SYSTEMROOT%\Resources\Themes\ /e /i /h /y /k /o /x

copy ACL\SetACL.exe %SYSTEMROOT%\System32\

setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn ace -ace "n:Administrators;p:full"

Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f3ffffff0000000000000000000000009001000000000001000005005300650067006f0065002000550049002000530065006d00690062006f006c006400000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorInactive" /t REG_DWORD /d "3290373919" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "100" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "4294967286" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f

start UxStyle\UxStyle.exe /install /quiet

xcopy OldNewExplorer "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\" /e /i /h /y /k /o /x

@REM [Change Windows Media Player to Black]
takeown /F %SYSTEMROOT%\System32\wmploc.dll
icacls %SYSTEMROOT%\System32\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\System32\wmploc.dll wmploc.dll.bak
copy Black_WMP\64bit\wmploc.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\SysWOW64\wmploc.dll
icacls %SYSTEMROOT%\SysWOW64\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\SysWOW64\wmploc.dll wmploc.dll.bak
copy Black_WMP\32bit\wmploc.dll %SYSTEMROOT%\SysWOW64\

Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /t REG_SZ /d "#1A1A1A" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /t REG_SZ /d "#FFFFFF" /f

RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer64.dll"
RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer32.dll"
cls

@echo off
echo.===============================================================================
echo.
echo.   Choose Your Old New Explorer Options:  Plus is Checked, Minus is Unchecked
echo.
echo.===============================================================================
echo.     1                                              2
echo.
echo.     +  Use command bar instead of Ribbon           +
echo.     +  Hide caption text in File Explorer windows  -
echo.     +  Hide caption icon in File Explorer windows  -
echo.     +  Hide Up button                              -
echo.     +  Enable glass on navigation bar              +
echo.     -  Use alternate navigation buttons style      +
echo.     +  Show details pane on the bottom             +
echo.
echo.     Choose 1, 2, or 3 -- I prefer configuring ONE myself
echo.
echo.===============================================================================
choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :ONEconfig3
if errorlevel 2 goto :ONEconfig2
if errorlevel 1 goto :ONEconfig1

:ONEconfig1

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "0" /f
goto :TH2end

:ONEconfig2

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "1" /f
goto :TH2end

:ONEconfig3

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.  MAKE YOUR CHOICES THEN PRESS CLOSE
"%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorerCfg.exe"
goto :TH2end

taskkill /f /im explorer.exe
start explorer.exe

:TH2end

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                 PLEASE RESTART YOUR COMPUTER BEFORE CHOOSING THEME    
echo.                    
echo.===============================================================================

echo Press ENTER Key to Continue 
pause >nul

goto :MainMenu

:RS1Menu

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                Please choose from the list for Windows 10 RS1/RS2/RS3
echo.                                    Black Theme
echo.
echo.                             1)  Install Anniversary Update
echo.
echo.                             2)  Install for Creators Update and RS3
echo.
echo.                             3)  Uninstall for Anniversary Update
echo.
echo.                             4)  Uninstall for Creators Update and RS3
echo.
echo.                             5)  Main Menu
echo.
echo.===============================================================================

choice /C:12345X /N /M "Enter Your Choice : "
if errorlevel 5 goto :MainMenu
if errorlevel 4 goto :RemoveRS2
if errorlevel 3 goto :RemoveMenu
if errorlevel 2 goto :RS2Start
if errorlevel 1 goto :RS1Start

:RS1Start
cls

set version=0.0.0000
set name=Windows
set allow=0

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==10.0.14393 (
    set name=Windows 10
     set allow=1
)

if %allow%==0 echo Sorry, this Operating System is not compatible with your selection.
pause
if %allow%==1 goto :RS1StartNow


goto :MainMenu

:RS2Start

cls

set version=0.0.0000
set name=Windows
set allow=1

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==10.0.10240 (
    set name=Windows 10
     set allow=0
)

if %version%==10.0.10586 (
    set name=Windows 10
     set allow=0
)

if %version%==10.0.14393 (
    set name=Windows 10
     set allow=0
)

if %allow%==0 echo Sorry, this Operating System is not compatible with your selection.
pause
if %allow%==1 goto :RS1StartNow


goto :MainMenu
copy UxThemeSignatureBypass\UxthemeSignatureBypass64.dll %SYSTEMROOT%\System32\
copy UxThemeSignatureBypass\UxthemeSignatureBypass32.dll %SYSTEMROOT%\System32\
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "AppInit_DLLs" /t REG_SZ /d "C:\Windows\System32\UxThemeSignatureBypass64.dll" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "AppInit_DLLs" /t REG_SZ /d "C:\Windows\System32\UxThemeSignatureBypass32.dll" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f

xcopy Themes_RS2_RS3 %SYSTEMROOT%\Resources\Themes\ /e /i /h /y /k /o /x

copy ACL\SetACL.exe %SYSTEMROOT%\System32\

setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn ace -ace "n:Administrators;p:full"

Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f3ffffff0000000000000000000000009001000000000001000005005300650067006f0065002000550049002000530065006d00690062006f006c006400000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorInactive" /t REG_DWORD /d "3290373919" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "100" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "4294967286" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f

xcopy OldNewExplorer "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\" /e /i /h /y /k /o /x

@REM [Change Windows Media Player to Black]
takeown /F %SYSTEMROOT%\System32\wmploc.dll
icacls %SYSTEMROOT%\System32\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\System32\wmploc.dll wmploc.dll.bak
copy Black_WMP\64bit\wmploc.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\SysWOW64\wmploc.dll
icacls %SYSTEMROOT%\SysWOW64\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\SysWOW64\wmploc.dll wmploc.dll.bak
copy Black_WMP\32bit\wmploc.dll %SYSTEMROOT%\SysWOW64\

Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /t REG_SZ /d "#1A1A1A" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /t REG_SZ /d "#FFFFFF" /f

RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer64.dll"
RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer32.dll"
cls

@echo off
echo.===============================================================================
echo.
echo.   Choose Your Old New Explorer Options:  Plus is Checked, Minus is Unchecked
echo.
echo.===============================================================================
echo.     1                                              2
echo.
echo.     +  Use command bar instead of Ribbon           +
echo.     +  Hide caption text in File Explorer windows  -
echo.     +  Hide caption icon in File Explorer windows  -
echo.     +  Hide Up button                              -
echo.     +  Enable glass on navigation bar              +
echo.     -  Use alternate navigation buttons style      +
echo.     +  Show details pane on the bottom             +
echo.
echo.     Choose 1, 2, or 3 -- I prefer configuring ONE myself
echo.
echo.===============================================================================
choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :ONEconfig3
if errorlevel 2 goto :ONEconfig2
if errorlevel 1 goto :ONEconfig1

:ONEconfig1

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "0" /f
goto :RS1end

:ONEconfig2

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "1" /f
goto :RS1end

:ONEconfig3

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.  MAKE YOUR CHOICES THEN PRESS CLOSE
"%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorerCfg.exe"
goto :RS1end

:RS1end

taskkill /f /im explorer.exe
start explorer.exe

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.               YOU MUST RESTART YOUR COMPUTER BEFORE USING THEMES  
echo.
echo.                    YOU CAN APPLY OTHER CUSTOMIZATIONS FIRST
echo.                      
echo.===============================================================================

echo Press ENTER Key to Continue 
pause >nul

goto :MainMenu

:RemoveRS2

cls
echo.===============================================================================
echo.
echo.                           You Are About to Uninstall All
echo.                                      Themes
echo.
echo.
echo.                 RESET YOUR THEME TO DEFAULT WINDOWS BEFORE PROCEEDING    
echo.  
echo.===============================================================================

echo Press ENTER Key to Continue
pause >nul

cls
echo.================================================================================
echo.
echo.                HAVE YOU SWITCHED YOUR THEME TO WINDOWS DEFAULT?
echo.
echo.                FAILURE TO DO SO RESULTS IN INCOMPLETE UNINSTALL
echo.
echo.================================================================================
echo.
echo.                1)  YES I HAVE SWITCHED MY THEME TO WINDOWS DEFAULT
echo.
echo.                2)  NO I HAVE NOT SWITCHED MY THEME TO WINDOWS DEFAULT
echo.
echo.================================================================================
choice /C:12X /N /M "Enter Your Choice : "

if errorlevel 2 goto :MainMenu
if errorlevel 1 goto :StartRemoval

:StartRemoval
cls

Reg.exe delete "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ActiveTitle" /t REG_DWORD /d "13743257" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ButtonFace" /t REG_DWORD /d "15790320" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ButtonText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "GrayText" /t REG_DWORD /d "7171437" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "Hilight" /t REG_DWORD /d "16750899" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "HilightText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "HotTrackingColor" /t REG_DWORD /d "13395456" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "InactiveTitle" /t REG_DWORD /d "14405055" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "InactiveTitleText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "MenuHilight" /t REG_DWORD /d "16750899" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "TitleText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "Window" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "WindowText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ActiveTitle" /t REG_DWORD /d "7209015" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ButtonFace" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ButtonText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "GrayText" /t REG_DWORD /d "4190783" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "Hilight" /t REG_DWORD /d "16771866" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "HilightText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "HotTrackingColor" /t REG_DWORD /d "65535" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "InactiveTitle" /t REG_DWORD /d "3080192" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "InactiveTitleText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "MenuHilight" /t REG_DWORD /d "8388736" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "TitleText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "Window" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "WindowText" /t REG_DWORD /d "16777215" 

Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-255" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-255" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "-60" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d "4278190080" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3288334336" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "89" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3288334336" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f

del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Aqua Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Aqua.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Blue Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Blue.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Green Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Green.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Orange Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Orange.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Pink Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Pink.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Red Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Red.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v1 Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v1.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v2 Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v2.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v3 Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v3.theme"
if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Glass.theme" del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Glass.theme"
if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Mix.theme" del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Mix.theme"
if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition.theme" del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition.theme"

if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition" RD /S /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition"

RegSvr32.exe /u "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer64.dll"
RegSvr32.exe /u "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer32.dll"

taskkill /f /im explorer.exe
start explorer.exe

del /F /Q %SYSTEMROOT%\System32\wmploc.dll
del /F /Q %SYSTEMROOT%\SysWOW64\wmploc.dll

ren %SYSTEMROOT%\System32\wmploc.dll.bak wmploc.dll
ren %SYSTEMROOT%\SysWOW64\wmploc.dll.bak wmploc.dll

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f

goto :MainMenu

:RS1Start

set version=0.0.0000
set name=Windows
set allow=1

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==10.0.10240 (
    set name=Windows 10
     set allow=0
)

if %version%==10.0.10586 (
    set name=Windows 10
     set allow=0
)

if %allow%==0 echo Sorry, this Operating System is not compatible with your selection.
pause
if %allow%==1 goto StartRS1Now

goto :MainMenu

:StartRS1Now

cls

takeown /F %SYSTEMROOT%\System32\themeui.dll
icacls %SYSTEMROOT%\System32\themeui.dll /grant "Everyone":F
if exist %SYSTEMROOT%\System32\themeui.dll.bak del %SYSTEMROOT%\System32\themeui.dll.bak
REN %SYSTEMROOT%\System32\themeui.dll themeui.dll.bak
copy PatchRS1\themeui.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\System32\uxinit.dll
icacls %SYSTEMROOT%\System32\uxinit.dll /grant "Everyone":F
if exist %SYSTEMROOT%\System32\uxinit.dll.bak del %SYSTEMROOT%\System32\uxinit.dll.bak
REN %SYSTEMROOT%\System32\uxinit.dll uxinit.dll.bak
copy PatchRS1\uxinit.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\System32\uxtheme.dll
icacls %SYSTEMROOT%\System32\uxtheme.dll /grant "Everyone":F
if exist %SYSTEMROOT%\System32\uxtheme.dll.bak del %SYSTEMROOT%\System32\uxtheme.dll.bak
REN %SYSTEMROOT%\System32\uxtheme.dll uxtheme.dll.bak
copy PatchRS1\uxtheme.dll %SYSTEMROOT%\System32\

xcopy Themes_RS1 %SYSTEMROOT%\Resources\Themes\ /e /i /h /y /k /o /x

copy ACL\SetACL.exe %SYSTEMROOT%\System32\

setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn ace -ace "n:Administrators;p:full"

Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f3ffffff0000000000000000000000009001000000000001000005005300650067006f0065002000550049002000530065006d00690062006f006c006400000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-225" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorInactive" /t REG_DWORD /d "3290373919" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "100" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3642695455" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "4294967286" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f

start UxStyle\UxStyle.exe /install /quiet

xcopy OldNewExplorer "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\" /e /i /h /y /k /o /x

@REM [Change Windows Media Player to Black]
takeown /F %SYSTEMROOT%\System32\wmploc.dll
icacls %SYSTEMROOT%\System32\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\System32\wmploc.dll wmploc.dll.bak
copy Black_WMP\64bit\wmploc.dll %SYSTEMROOT%\System32\

takeown /F %SYSTEMROOT%\SysWOW64\wmploc.dll
icacls %SYSTEMROOT%\SysWOW64\wmploc.dll /grant "Everyone":F
REN %SYSTEMROOT%\SysWOW64\wmploc.dll wmploc.dll.bak
copy Black_WMP\32bit\wmploc.dll %SYSTEMROOT%\SysWOW64\

Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /t REG_SZ /d "#1A1A1A" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /t REG_SZ /d "#FFFFFF" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /t REG_SZ /d "#FFFFFF" /f

RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer64.dll"
RegSvr32.exe "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer32.dll"
cls

@echo off
echo.===============================================================================
echo.
echo.   Choose Your Old New Explorer Options:  Plus is Checked, Minus is Unchecked
echo.
echo.===============================================================================
echo.     1                                              2
echo.
echo.     +  Use command bar instead of Ribbon           +
echo.     +  Hide caption text in File Explorer windows  -
echo.     +  Hide caption icon in File Explorer windows  -
echo.     +  Hide Up button                              -
echo.     +  Enable glass on navigation bar              +
echo.     -  Use alternate navigation buttons style      +
echo.     +  Show details pane on the bottom             +
echo.
echo.     Choose 1, 2, or 3 -- I prefer configuring ONE myself
echo.
echo.===============================================================================
choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :ONEconfig3
if errorlevel 2 goto :ONEconfig2
if errorlevel 1 goto :ONEconfig1

:ONEconfig1

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "0" /f
goto :RS1end

:ONEconfig2

cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "1" /f
goto :RS1end

:ONEconfig3

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.  MAKE YOUR CHOICES THEN PRESS CLOSE
"%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorerCfg.exe"
goto :RS1end

:RS1end

taskkill /f /im explorer.exe
start explorer.exe

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.               YOU MUST RESTART YOUR COMPUTER BEFORE USING THEMES  
echo.
echo.                    YOU CAN APPLY OTHER CUSTOMIZATIONS FIRST
echo.                      
echo.===============================================================================

echo Press ENTER Key to Continue 
pause >nul

goto :MainMenu

:UltraBlack

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                        This Enhances the Black Theme and is NOT for
echo.                          Everyone -- RESTART OR LOGOFF IS REQUIRED
echo.
echo.                        THIS IS NOT CONSISTENT ACROSS BUILDS USE
echo.                                     AT YOUR OWN RISK
echo.
echo.                             1)  Install
echo.
echo.                             2)  Uninstall
echo.
echo.                             3)  Main Menu
echo.
echo.===============================================================================

choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :MainMenu
if errorlevel 2 goto :UnInstallUltraBlack
if errorlevel 1 goto :InstallUltraBlack

:InstallUltraBlack
cls
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f
Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\Personalization" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "PersonalColors_Background" /t REG_SZ /d "#000000" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "PersonalColors_Accent" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\Personalization" /v "PersonalColors_Background" /t REG_SZ /d "#000000" /f
Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\Personalization" /v "PersonalColors_Accent" /f
goto :MainMenu

:UnInstallUltraBlack
cls
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f
Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\Personalization" /f
goto :MainMenu

:UltraX

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                     This Patcher is OPTIONAL.  Use at your own RISK!
echo.                                 Windows 10 TH1/LTSB
echo.
echo.                             1)  Install -- I WILL RESTART THE COMPUTER
echo.                                               AFTER INSTALLATION
echo.
echo.                             2)  Uninstall -- DO NOT BE ALARMED! YOUR SCREEN
echo.                                 WILL FLASH AND YOUR THEME WILL REVERT TO
echo.                                                  DEFAULT!
echo.
echo.                             3)  Back to Main Menu
echo.
echo.===============================================================================

choice /C:123X /N /M "Enter Your Choice : "
if errorlevel 3 goto :MainMenu
if errorlevel 2 goto :UltraXUninstall
if errorlevel 1 goto :UltraXStart

:UltraXUninstall
cls
"%SYSTEMDRIVE%\Program Files (x86)\UltraUXThemePatcher\Uninstall.exe" /S
goto :MainMenu

:UltraXStart
cls
set version=0.0.0000
set name=Windows
set allow=0

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==10.0.10240 (
    set name=Windows 10
     set allow=1
)

if %allow%==0 echo Sorry, this Operating System is not compatible with your selection.
echo.
echo.
echo.
pause
if %allow%==1 goto UltraXCont

goto :MainMenu

:UltraXCont
cls
echo.
echo.
echo.
echo.   Working.  Please be patient.

UxStyle\UltraUXThemePatcher_3.1.4.exe /S

goto :MainMenu

:RemoveMenu

cls
echo.===============================================================================
echo.
echo.                           You Are About to Uninstall All
echo.                                      Themes
echo.
echo.
echo.                 RESET YOUR THEME TO DEFAULT WINDOWS BEFORE PROCEEDING    
echo.  
echo.===============================================================================

echo Press ENTER Key to Continue
pause >nul

cls
echo.================================================================================
echo.
echo.                HAVE YOU SWITCHED YOUR THEME TO WINDOWS DEFAULT?
echo.
echo.                FAILURE TO DO SO RESULTS IN INCOMPLETE UNINSTALL
echo.
echo.================================================================================
echo.
echo.                1)  YES I HAVE SWITCHED MY THEME TO WINDOWS DEFAULT
echo.
echo.                2)  NO I HAVE NOT SWITCHED MY THEME TO WINDOWS DEFAULT
echo.
echo.================================================================================
choice /C:12X /N /M "Enter Your Choice : "

if errorlevel 2 goto :MainMenu
if errorlevel 1 goto :StartRemoval

:StartRemoval
cls

Reg.exe delete "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /f
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ActiveTitle" /t REG_DWORD /d "13743257" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ButtonFace" /t REG_DWORD /d "15790320" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ButtonText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "GrayText" /t REG_DWORD /d "7171437" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "Hilight" /t REG_DWORD /d "16750899" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "HilightText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "HotTrackingColor" /t REG_DWORD /d "13395456" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "InactiveTitle" /t REG_DWORD /d "14405055" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "InactiveTitleText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "MenuHilight" /t REG_DWORD /d "16750899" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "TitleText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "Window" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "WindowText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ActiveTitle" /t REG_DWORD /d "7209015" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ButtonFace" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ButtonText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "GrayText" /t REG_DWORD /d "4190783" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "Hilight" /t REG_DWORD /d "16771866" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "HilightText" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "HotTrackingColor" /t REG_DWORD /d "65535" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "InactiveTitle" /t REG_DWORD /d "3080192" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "InactiveTitleText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "MenuHilight" /t REG_DWORD /d "8388736" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "TitleText" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "Window" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-255" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-255" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "-60" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d "4278190080" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3288334336" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "89" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3288334336" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f

del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Aqua Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Aqua.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Blue Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Blue.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Green Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Green.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Orange Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Orange.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Pink Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Pink.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Red Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Red.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v1 Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v1.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v2 Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v2.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v3 Mix.theme"
del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition v3.theme"
if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Glass.theme" del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Glass.theme"
if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Mix.theme" del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition Mix.theme"
if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition.theme" del /F /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition.theme"

if exist "%SYSTEMROOT%\Resources\Themes\Windows Black Edition" RD /S /Q "%SYSTEMROOT%\Resources\Themes\Windows Black Edition"

RegSvr32.exe /u "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer64.dll"
RegSvr32.exe /u "%SYSTEMDRIVE%\Program Files (x86)\OldNewExplorer\OldNewExplorer32.dll"

taskkill /f /im explorer.exe
start explorer.exe

del /F /Q %SYSTEMROOT%\System32\wmploc.dll
del /F /Q %SYSTEMROOT%\SysWOW64\wmploc.dll
ren %SYSTEMROOT%\System32\wmploc.dll.bak wmploc.dll
ren %SYSTEMROOT%\SysWOW64\wmploc.dll.bak wmploc.dll

start UxStyle\UxStyle.exe /uninstall /quiet

cls

set version=0.0.0000
set name=Windows
set allow=1

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a %%b

for %%a in (%version%) do set version=%%a

if %version%==10.0.10240 (
    set name=Windows 10
     set allow=0
)

if %allow%==0 goto MainMenu
if %allow%==1 goto FinishTH2Now

:FinishTH2Now

cls

DEL %SYSTEMROOT%\System32\themeui.dll
REN %SYSTEMROOT%\System32\themeui.dll.bak themeui.dll

DEL %SYSTEMROOT%\System32\uxinit.dll
REN %SYSTEMROOT%\System32\uxinit.dll.bak uxinit.dll

DEL %SYSTEMROOT%\System32\uxtheme.dll
REN %SYSTEMROOT%\System32\uxtheme.dll.bak uxtheme.dll

goto :MainMenu

:Features

cls
echo.===============================================================================
echo.                           File Explorer Cleanup - Main Menu
echo.===============================================================================
echo.
echo.                             [1]   Quick Access and Delegate Folders Options
echo.
echo.                             [2]   Remove/Add One Drive Icon
echo.
echo.                             [3]   Remove/Add Removable Drives Icons
echo.
echo.                             [4]   Remove/Add Homegroup
echo.
echo.                             [5]   Remove/Add Network Icon
echo.
echo.                             [6]   Remove/Add Libraries
echo.
echo.                             [7]   Remove/Add Details Pane
echo.
echo.                             [8]   Desktop Customizations
echo.
echo.                             [9]   Go To Main Menu
echo.
echo.===============================================================================
choice /C:1234567890X /N /M "Enter Your Choice : "

if errorlevel 9 goto :MainMenu
if errorlevel 8 goto :EvenMoreFeatures
if errorlevel 7 goto :DetailsPane
if errorlevel 6 goto :Libraries
if errorlevel 5 goto :Network
if errorlevel 4 goto :Homegroup
if errorlevel 3 goto :HideRemovableDrives
if errorlevel 2 goto :RemoveOneDrive
if errorlevel 1 goto :RemoveQA

:RemoveQA

cls

setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn ace -ace "n:Administrators;p:full"

cls
echo.===============================================================================
echo.
echo.                      Remove Quick Access and/or Delegate Folders
echo.
echo.===============================================================================
echo.
echo.                   [1]   Remove/Restore Quick Access from File Explorer
echo.
echo.                   [2]   Remove/Restore Delegate Folders from File Explorer
echo.
echo.                   [3]   Remove/Restore BOTH from File Explorer
echo.
echo.                   [4]   File Explorer Cleanup
echo.
echo.                   [5]   Main Menu
echo.
echo.===============================================================================
choice /C:12345X /N /M "Enter Your Choice : "
if errorlevel 5 goto :MainMenu
if errorlevel 4 goto :Features
if errorlevel 3 goto :AddQAandD
if errorlevel 2 goto :AddDF
if errorlevel 1 goto :AddQA

:AddQA

cls
echo.===============================================================================
echo.
echo.                     Remove/Restore Quick Access to File Explorer
echo.
echo.===============================================================================
echo.
echo.                             [1]    Remove Quick Access to File Explorer
echo.
echo.                             [2]    Restore Quick Access to File Explorer
echo.
echo.                             [3]    File Explorer Cleanup
echo.
echo.                             [4]    Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :StartAddQA
if errorlevel 1 goto :StartRemoveQA

:StartRemoveQA


Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f
Reg.exe delete "HKCR\Folder\shell\pintohome" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
goto :Features

:StartAddQA

Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "2" /f
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
goto :Features

:AddDF

cls
echo.===============================================================================
echo.
echo.                     Remove/Restore Delegate Folders to File Explorer
echo.
echo.===============================================================================
echo.
echo.                             [1]    Remove Delegate Folders from File Explorer
echo.
echo.                             [2]    Restore Delegate Folders to File Explorer
echo.
echo.                             [3]    File Explorer Cleanup
echo.
echo.                             [4]    Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :StartAddDF
if errorlevel 1 goto :StartRemoveDF

:StartRemoveDF

Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f
goto :Features

:StartAddDF

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f
goto :Features

:AddQAandD

cls
echo.===============================================================================
echo.
echo.                     Remove/Restore Quick Access to File Explorer
echo.
echo.===============================================================================
echo.
echo.                             [1]    Remove Quick Access and Delegate Folders
echo.                                    from File Explorer
echo.
echo.                             [2]    Restore Quick Access and Delegate Folders
echo.                                    to File Explorer
echo.
echo.                             [3]    File Explorer Cleanup
echo.
echo.                             [4]    Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :StartAddQAandD
if errorlevel 1 goto :StartRemoveQAandD

:StartRemoveQAandD

Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f
Reg.exe delete "HKCR\Folder\shell\pintohome" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f
goto :Features

:StartAddQAandD

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "2" /f
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
goto :Features

:RemoveOneDrive

cls
echo.===============================================================================
echo.                               Hide/Restore OneDrive Icon
echo.===============================================================================
echo.
echo.                             [1]   Hide OneDrive Icon from File Explorer
echo.
echo.                             [2]   Restore OneDrive Icon to File Explorer
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :StartAddOD
if errorlevel 1 goto :StartRemoveOD

:StartRemoveOD

Reg.exe delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4035969101" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6-XXX}" /f
goto :Features

:StartAddOD

Reg.exe delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4034920525" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6-XXX}" /f
goto :Features

:HideRemovableDrives

cls
echo.===============================================================================
echo.                           Hide Removable Drives from File Explorer
echo.===============================================================================
echo.
echo.                             [1]   Hide Removable Drives from File Explorer
echo.
echo.                             [2]   Restore Removable Drives to File Explorer
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :AddRemovableDrives
if errorlevel 1 goto :StartHideDrives

:StartHideDrives

Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
goto :Features

:AddRemovableDrives

Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
goto :Features

:HomeGroup

cls
echo.===============================================================================
echo.                           Disable Homegroup and Hide in File Explorer
echo.===============================================================================
echo.
echo.                             [1]   Disable Homegroup
echo.
echo.                             [2]   Enable Homegroup
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :EnableHomegroup
if errorlevel 1 goto :DisableHomegroup

:DisableHomegroup
sc stop "HomeGroupProvider"
sc config "HomeGroupProvider" start=disabled
sc config "HomeGroupListener" start=disabled
goto :Features

:EnableHomegroup
sc config "HomeGroupProvider" start=auto
sc config "HomeGroupListener" start=auto
sc start "HomeGroupProvider"
goto :Features

:Network

cls
echo.===============================================================================
echo.                           Hide/Show Network Icon in File Explorer
echo.===============================================================================
echo.
echo.                             [1]   Hide Network Icon
echo.
echo.                             [2]   Restore Network Icon
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :EnableNetworkIcon
if errorlevel 1 goto :DisableNetworkIcon

:DisableNetworkIcon
setacl.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"
Reg.exe add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489444" /f
Reg.exe add "HKCR\WOW6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489444" /f
goto :Features

:EnableNetworkIcon
setacl.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

setacl.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators"
setacl.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full"

Reg.exe add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2953052260" /f
Reg.exe add "HKCR\WOW6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2953052260" /f
goto :Features

:Libraries

cls
echo.===============================================================================
echo.                           Hide/Show Libraries in File Explorer
echo.===============================================================================
echo.
echo.                             [1]   Show Libraries
echo.
echo.                             [2]   Hide Libraries
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :HideLibraries
if errorlevel 1 goto :ShowLibraries

:ShowLibraries

Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}" /t REG_SZ /d "C:\Users\Dave\AppData\Roaming\Microsoft\Windows\Libraries" /f
Reg.exe add "HKCU\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
goto :Features

:HideLibraries

Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /f
Reg.exe add "HKCU\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
goto :Features

:DetailsPane

cls
echo.===============================================================================
echo.                           Hide/Show Details Pane in File Explorer
echo.===============================================================================
echo.
echo.                             [1]   Hide Details Pane
echo.
echo.                             [2]   Restore Details Pane
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Features
if errorlevel 2 goto :ShowDetailsPane
if errorlevel 1 goto :HideDetailsPane

:HideDetailsPane

Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" /v "PreviewPaneSizer" /t REG_BINARY /d "4500000000000000000000000c020000" /f
goto :Features

:ShowDetailsPane

Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" /v "PreviewPaneSizer" /t REG_BINARY /d "4500000001000000000000000c020000" /f
goto :Features

:EvenMoreFeatures

cls
echo.===============================================================================
echo.                             Desktop Customizations
echo.===============================================================================
echo.
echo.                             [1]   Apply Theme to Windows Version Window
echo.
echo.                             [2]   Add/Remove Right-Click Personalization Menu
echo.
echo.                             [3]   Enable/Disable Immersive Context Menu
echo.
echo.                             [4]   Increase or Return to Default 
echo.                                   Taskbar Transparency
echo.
echo.                             [5]   Enable or Return to Default Blur in 
echo.                                   Taskbar and Start Menu
echo.
echo.                             [6]   Enable or Revert to Default Alt-Tab View to 
echo.                                   Transparent and Show Desktop
echo.
echo.                             [7]   File Explorer Cleanup
echo.
echo.                             [8]   Main Menu
echo.
echo.                             [X]   Quit
echo.
echo.===============================================================================
choice /C:123456789X /N /M "Enter Your Choice : "
if errorlevel 9 goto :QuitProgram
if errorlevel 8 goto :MainMenu
if errorlevel 7 goto :Features
if errorlevel 6 goto :AltTab
if errorlevel 5 goto :Blur
if errorlevel 4 goto :TBTrans
if errorlevel 3 goto :CXMenu
if errorlevel 2 goto :AddAppearanceSettings
if errorlevel 1 goto :WinVerTheme

:WinVerTheme

cls
echo.===============================================================================
echo.                            Windows Version Window Customization
echo.===============================================================================
echo.
echo.                       [1]   Aqua
echo.
echo.                       [2]   Black
echo.
echo.                       [3]   Blue
echo.
echo.                       [4]   Green
echo.
echo.                       [5]   Orange
echo.
echo.                       [6]   Pink
echo.
echo.                       [7]   Red
echo.
echo.                       [8]   Original
echo.
echo.                       [9]   Main Menu
echo.
echo.===============================================================================
choice /C:123456789X /N /M "Enter Your Choice : "
if errorlevel 9 goto :MainMenu
if errorlevel 8 goto :Original
if errorlevel 7 goto :Red
if errorlevel 6 goto :Pink
if errorlevel 5 goto :Orange
if errorlevel 4 goto :Green
if errorlevel 3 goto :Blue
if errorlevel 2 goto :Black
if errorlevel 1 goto :Aqua

:Aqua
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Aqua\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:Black
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Black\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:Blue
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Blue\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:Green
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Green\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:Orange
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Orange\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:Pink
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Pink\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:Red
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Red\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:Original
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F
copy Basebrd_mods\Original\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\
winver
goto :EvenMoreFeatures

:AddAppearanceSettings

cls
echo.===============================================================================
echo.                                Right-Click Menu
echo.===============================================================================
echo.
echo.                       [1]   Add Personalize and Control Panel Settings to
echo.                             Right-Click Desktop Menu
echo.
echo.                       [2]   Remove Personalize and Control Panel Settings to
echo.                             Right-Click Desktop Menu
echo.
echo.                       [3]   Add CLASSIC Personalization to Right-Click Desktop
echo.                             Menu. This is necessary to change themes in RS2/RS3.
echo.                       
echo.                       [4]   Remove Classic Personalization from Right-Click
echo.                             Desktop Menu.
echo.
echo.                       [5]   File Explorer Cleanup
echo.
echo.                       [6]   Main Menu
echo.
echo.===============================================================================
choice /C:123456X /N /M "Enter Your Choice : "
if errorlevel 6 goto :MainMenu
if errorlevel 5 goto :EvenMoreFeatures
if errorlevel 4 goto :RemoveClassicPersonalize
if errorlevel 3 goto :AddClassicPersonalize
if errorlevel 2 goto :NoAppearanceSettings
if errorlevel 1 goto :StartAddAppearanceSettings

:AddClassicPersonalize
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "MUIVerb" /t REG_SZ /d "Personalize (classic)" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "SubCommands" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout" /v "MUIVerb" /t REG_SZ /d "Theme Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Personalization" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout\command" /ve /t REG_SZ /d "explorer shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout" /v "MUIVerb" /t REG_SZ /d "Desktop Background" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout\command" /ve /t REG_SZ /d "explorer shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921} -Microsoft.Personalization\pageWallpaper" /f
Reg.exe delete "HKCR\DesktopBackground\Shell\Personalization\shell\003flyout" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\004flyout" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\004flyout" /v "MUIVerb" /t REG_SZ /d "Color and Appearance" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\004flyout\command" /ve /t REG_SZ /d "explorer shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921} -Microsoft.Personalization\pageColorization" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\005flyout" /v "Icon" /t REG_SZ /d "SndVol.exe,-101" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\005flyout" /v "MUIVerb" /t REG_SZ /d "Sounds" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\005flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,2" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\006flyout" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\006flyout" /v "MUIVerb" /t REG_SZ /d "Screen Saver Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\006flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout" /v "Icon" /t REG_SZ /d "desk.cpl" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout" /v "MUIVerb" /t REG_SZ /d "Desktop Icon Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\008flyout" /v "Icon" /t REG_SZ /d "main.cpl" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\008flyout" /v "MUIVerb" /t REG_SZ /d "Mouse Pointers" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\008flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\009flyout" /v "Icon" /t REG_SZ /d "taskbarcpl.dll,-1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\009flyout" /v "MUIVerb" /t REG_SZ /d "Notification Area Icons" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\009flyout" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\009flyout\command" /ve /t REG_SZ /d "explorer shell:::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\010flyout" /v "Icon" /t REG_SZ /d "taskbarcpl.dll,-1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\010flyout" /v "MUIVerb" /t REG_SZ /d "System Icons" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\010flyout\command" /ve /t REG_SZ /d "explorer shell:::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9} \SystemIcons,,0" /f
goto :EvenMoreFeatures

:RemoveClassicPersonalize
Reg.exe delete "HKCR\DesktopBackground\Shell\Personalization" /f
goto :EvenMoreFeatures

:StartAddAppearanceSettings
Reg.exe add "HKCR\DesktopBackground\shell" /ve /t REG_SZ /d "none" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ClasicPersonalize" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ClasicPersonalize" /v "MUIVerb" /t REG_SZ /d "Personalization" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ClasicPersonalize" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ClasicPersonalize" /v "SubCommands" /t REG_SZ /d "Personalization;DesktopBackground;Color;Sounds;ScreenSaver;DesktopIcons;Cursors" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Personalization" /v "MUIVerb" /t REG_SZ /d "Personalization" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Personalization" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Personalization" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Personalization" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\themecpl.dll,-1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Personalization\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopBackground" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopBackground" /v "MUIVerb" /t REG_SZ /d "Desktop Background" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopBackground\Command" /ve /t REG_SZ /d "control.exe /NAME Microsoft.Personalization /PAGE pageWallpaper" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Color" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Color" /v "MUIVerb" /t REG_SZ /d "Color" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Color\Command" /ve /t REG_SZ /d "control.exe /NAME Microsoft.Personalization /PAGE pageColorization" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Sounds" /v "Icon" /t REG_SZ /d "mmsys.cpl" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Sounds" /v "MUIVerb" /t REG_SZ /d "Sounds" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Sounds\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl ,2" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ScreenSaver" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ScreenSaver" /v "MUIVerb" /t REG_SZ /d "Screen Saver" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ScreenSaver\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,screensaver,@screensaver" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopIcons" /v "Icon" /t REG_SZ /d "desk.cpl" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopIcons" /v "MUIVerb" /t REG_SZ /d "Change desktop icons" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopIcons" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopIcons\Command" /ve /t REG_SZ /d "rundll32 shell32.dll,Control_RunDLL desk.cpl,,0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Cursors" /v "Icon" /t REG_SZ /d "main.cpl" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Cursors" /v "MUIVerb" /t REG_SZ /d "Change mouse pointers" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Cursors\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ControlPanel" /v "MUIVerb" /t REG_SZ /d "Control Panel" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ControlPanel" /v "SubCommands" /t REG_SZ /d "ControlPanel;DeviceManager;Software;Windows.NetworkAndSharing;WindowsSettings;WindowsVersion;RegistryEditor;Windows.RecycleBin.Empty" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ControlPanel" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\System32\imageres.dll,-27" /f
Reg.exe add "HKCR\DesktopBackground\Shell\ControlPanel" /v "Position" /t REG_SZ /d "bottom" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ControlPanel" /ve /t REG_SZ /d "Control Panel" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ControlPanel" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\System32\imageres.dll,-27" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ControlPanel\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DeviceManager" /ve /t REG_SZ /d "Device Manager" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DeviceManager" /v "ControlPanelName" /t REG_SZ /d "Microsoft.DeviceManager" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DeviceManager" /v "Icon" /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\devmgr.dll,-201" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DeviceManager\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\RegistryEditor" /ve /t REG_SZ /d "Registry Editor" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\RegistryEditor" /v "Icon" /t REG_SZ /d "regedit.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\RegistryEditor\command" /ve /t REG_SZ /d "regedit.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Software" /ve /t REG_SZ /d "Software" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Software" /v "ControlPanelName" /t REG_SZ /d "Microsoft.ProgramsAndFeatures" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Software" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\imageres.dll,-87" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Software\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\WindowsSettings" /ve /t REG_SZ /d "Windows Settings" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\WindowsSettings" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\shell32.dll,-16826" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\WindowsSettings\Command" /v "DelegateExecute" /t REG_SZ /d "{44090B31-CDF9-4ad1-8182-DB5DA3627974}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\WindowsVersion" /ve /t REG_SZ /d "Windows Version" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\WindowsVersion" /v "Icon" /t REG_EXPAND_SZ /d "imageres.dll,-81" /f
Reg.exe delete "HKCR\DesktopBackground\Shell\Personalization" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\WindowsVersion\command" /ve /t REG_SZ /d "winver.exe" /f
goto :EvenMoreFeatures

:NoAppearanceSettings
Reg.exe delete "HKCR\DesktopBackground\Shell\ClasicPersonalize" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Personalization" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopBackground" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Color" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Sounds" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ScreenSaver" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DesktopIcons" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Cursors" /f
Reg.exe delete "HKCR\DesktopBackground\Shell\ControlPanel" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ControlPanel" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DeviceManager" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\RegistryEditor" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Software" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\WindowsSettings" /f
goto :EvenMoreFeatures

:CXMenu

cls
echo.===============================================================================
echo.                        Enable\Disable Immersive Context Menu
echo.
echo.                   Requires Explorer Restart, Logout, or Restart!!!
echo.===============================================================================
echo.
echo.                             [1]   Disable Immersive Context Menu
echo.
echo.                             [2]   Enable Immersive Context Menu
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :EvenMoreFeatures
if errorlevel 2 goto :ECX
if errorlevel 1 goto :DCX

:DCX
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d "0" /f
goto :EvenMoreFeatures

:ECX
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d "1" /f
goto :EvenMoreFeatures

:TBTrans

cls
echo.===============================================================================
echo.                    Enable\Disable Increase in Taskbar Transparency
echo.
echo.                   Requires Explorer Restart, Logout, or Restart!!!
echo.===============================================================================
echo.
echo.                             [1]   Increase Taskbar Transparency
echo.
echo.                             [2]   Return Taskbar to Default Transparency
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :EvenMoreFeatures
if errorlevel 2 goto :RemoveTBTrans
if errorlevel 1 goto :AddTBTrans

:AddTBTrans
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /t REG_DWORD /d "1" /f
goto :EvenMoreFeatures

:RemoveTBTrans
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f
goto :EvenMoreFeatures

:Blur
cls
echo.===============================================================================
echo.                        Enable\Disable Blur in Start Menu
echo.
echo.                   Requires Explorer Restart, Logout, or Restart!!!
echo.===============================================================================
echo.
echo.                             [1]   Enable Blur
echo.
echo.                             [2]   Disable Blur
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :EvenMoreFeatures
if errorlevel 2 goto :RemoveBlur
if errorlevel 1 goto :StartBlur

:StartBlur
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /t REG_DWORD /d "1" /f
goto :EvenMoreFeatures

:RemoveBlur
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f
goto :EvenMoreFeatures

:AltTab
cls
echo.===============================================================================
echo.                     Enable\Disable Alternate Alt/Tab View Settings
echo.
echo.                   Requires Explorer Restart, Logout, or Restart!!!
echo.===============================================================================
echo.
echo.                             [1]   Enable Alternate Alt/Tab View
echo.
echo.                             [2]   Disable Alternate Alt/Tab View
echo.
echo.                             [3]   File Explorer Cleanup
echo.
echo.                             [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :EvenMoreFeatures
if errorlevel 2 goto :AltTabRestore
if errorlevel 1 goto :StartAltTab

:StartAltTab
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AltTabViewHost" /v "Wallpaper" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AltTabViewHost" /v "Grid_backgroundPercent" /t REG_DWORD /d "0" /f
goto :EvenMoreFeatures

:AltTabRestore
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AltTabViewHost" /v "Wallpaper" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AltTabViewHost" /v "Grid_backgroundPercent" /t REG_DWORD /d "0" /f
goto :Features

:QuitProgram

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                  Thank You for Using the Black Theme Toolkit
echo.
echo.       If You Made Changes to Your System Please Restart Your Computer
echo.
echo.===============================================================================
echo.
echo.
echo.
echo.
echo.
echo.

echo Press ENTER Key to Continue 
pause >nul

exit