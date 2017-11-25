@ECHO OFF
:: Setting DOS Window Color
color 1f
(cd /d "%~dp0")&&(NET FILE||(powershell start-process -FilePath '%0' -verb runas)&&(exit /B)) >NUL 2>&1
:: Setting DOS Windows Title
set "TITLE=Black Theme Toolkit"
set "VERSION=3.0.0"
title %TITLE% v%VERSION%
mode 79, 30
if "%PROCESSOR_ARCHITECTURE%" equ "x86" goto :x86
for /f "tokens=4-6 delims=. " %%i in ('ver') do set VERSION=%%i.%%j.%%k
if "%version%" GEQ "10.0.15063" (
goto Begin
) else (
goto x86
)
goto :QuitProgram
:Begin
%~d0
cd %~d0%~p0
echo.
echo.===============================================================================
echo.
echo.                             Choose Color Preference
echo.
echo.                        [1]  White on BLUE Background
echo.
echo.                        [2]  White on BLACK Background
echo.
echo.===============================================================================
echo.
echo.                CUSTOMIZE THE OPACITY OF THIS PROGRAM BY PRESSING 
echo.
echo.                          CONTROL SHIFT + TO INCREASE
echo.                                        OR
echo.                          CONTROL SHIFT - TO DECREASE
echo.
echo.===============================================================================
echo.
echo.
echo.
echo.
echo.
choice /C:12X /N /M "Enter Your Choice: "
if errorlevel 2 goto :black
if errorlevel 1 goto :blue
:black
color 07
goto :toolkit
:blue
color 1f
:Toolkit
cls
echo.===============================================================================
echo.±±±±±±±±±±±±±±±±±±±±±±±±±±±Black Theme ToolKit±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
echo.===============================================================================
echo.
echo.                   USE THIS TOOLKIT AT YOUR OWN RISK
echo.
echo.===============================================================================
echo Press Any Key to Continue 
pause >NUL 2>&1
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                    Create a Restore Point
echo.
echo.                    [1]  Yes
echo.
echo.                    [2]  No
echo.
echo.===============================================================================
choice /C:12X /N /M "Enter Your Choice : "
if errorlevel 2 goto :UACMenu
if errorlevel 1 goto :SystemRestore
:SystemRestore
cls
echo.
echo. System Restore Will Be Enabled
echo.
echo.
echo.
echo.
echo. Press Any Key to Continue
pause >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f
powershell "& "".\backup\sysrestore.ps1""" >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f >nul 2>&1
start BackUp\SystemRestore.vbs
echo.
echo.
echo. Enter a Name for Restore Point in Window
echo.
echo.
echo.                     -- Click OK --
echo.
echo.
echo. Press Any Key to Continue
pause >nul 2>&1
goto :UACMenu
:UACMenu
cls
echo.===============================================================================
echo.                  Change The User Account Control Setting
echo.===============================================================================
echo.
echo.                  [1]   Always Notify
echo.
echo.                  [2]   Default -- Notify When Apps Make Changes
echo.
echo.                  [3]   Default -- But Do Not Dim My Screen
echo.
echo.                  [4]   Never Notify
echo.
echo.                  [5]   Main Menu
echo.
echo.                  [X]   Quit
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
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "2" /f >nul 2>&1
goto :MainMenu
:Default
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f >nul 2>&1
goto :MainMenu
:NoDim
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f >nul 2>&1
goto :MainMenu
:NeverNotify
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f >nul 2>&1
goto :MainMenu
:MainMenu
cls
echo.===============================================================================
echo.                          Black Theme ToolKit - Main Menu
echo.===============================================================================
echo.
echo.
echo.                          [1]   Install/Uninstall
echo.
echo.                          [2]   File Explorer Cleanup
echo.
echo.                          [3]   Desktop Customizations
echo.
echo.                          [4]   Restart Explorer
echo.
echo.                          [X]   Quit
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 5 goto :QuitProgram
if errorlevel 4 goto :RestartExplorer
if errorlevel 3 goto :DesktopCustomizations
if errorlevel 2 goto :ExplorerCleanup
if errorlevel 1 goto :BlackThemeMenu
:RestartExplorer
taskkill /F /IM explorer.exe >nul 2>&1
start explorer.exe >nul 2>&1
goto :MainMenu
:BlackThemeMenu
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.                   Windows 10 Black Theme (No 3rd-Party Themes Installed)
echo.                                  
echo.                   [1]  Install Using UXThemeSignatureBypass
echo.
echo.                   [2]  Install Using UltraUX Patched Files
echo.
echo.                   [3]  Uninstall UXThemeSignatureBypass
echo.
echo.                   [4]  Uninstall UltraUX Patched Files
echo.
echo.                   [5]  Main Menu
echo.
echo.===============================================================================
choice /C:12345X /N /M "Enter Your Choice : "
if errorlevel 5 goto :MainMenu
if errorlevel 4 goto :RemoveBlackThemeUXFiles
if errorlevel 3 goto :RemoveBlackThemeUXTheme
if errorlevel 2 goto :InstallBlackThemeUXFiles
if errorlevel 1 goto :InstallBlackThemeUXTheme
:InstallBlackThemeUXTheme
cls
copy UxThemeSignatureBypass\UxthemeSignatureBypass64.dll %SYSTEMROOT%\System32\ >nul 2>&1
copy UxThemeSignatureBypass\UxthemeSignatureBypass32.dll %SYSTEMROOT%\System32\ >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "AppInit_DLLs" /t REG_SZ /d "C:\Windows\System32\UxThemeSignatureBypass64.dll" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "AppInit_DLLs" /t REG_SZ /d "C:\Windows\System32\UxThemeSignatureBypass32.dll" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f >nul 2>&1
goto :InstallFollowUp
:InstallBlackThemeUXFiles
cls
takeown /F %SYSTEMROOT%\System32\themeui.dll >nul 2>&1
icacls %SYSTEMROOT%\System32\themeui.dll /grant "Everyone":F >nul 2>&1
REN %SYSTEMROOT%\System32\themeui.dll themeui.dll.bak >nul 2>&1
copy UltraUxfiles\Patched\themeui.dll %SYSTEMROOT%\System32\ >nul 2>&1
takeown /F %SYSTEMROOT%\System32\uxinit.dll >nul 2>&1
icacls %SYSTEMROOT%\System32\uxinit.dll /grant "Everyone":F >nul 2>&1
REN %SYSTEMROOT%\System32\uxinit.dll uxinit.dll.bak >nul 2>&1
copy UltraUxfiles\Patched\uxinit.dll %SYSTEMROOT%\System32\ >nul 2>&1
goto :InstallFollowUp
:InstallFollowUp
Reg.exe add "HKCR\CLSID\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}" /ve /t REG_SZ /d "@%%SystemRoot%%\System32\themecpl.dll,-1#immutable1" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}" /v "InfoTip" /t REG_SZ /d "@%%SystemRoot%%\System32\themecpl.dll,-2#immutable1" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}" /v "System.ApplicationName" /t REG_SZ /d "Microsoft.Personalization" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}" /v "System.ControlPanel.Category" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}" /v "System.Software.TasksFileUrl" /t REG_SZ /d "Internal" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\themecpl.dll,-1" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}\Shell\Open\command" /ve /t REG_SZ /d "explorer shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{580722ff-16a7-44c1-bf74-7e1acd00f4f9}" /ve /t REG_SZ /d "Personalization" /f >nul 2>&1
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "Icon" /t REG_SZ /d "C:\Program Files\Black Theme Toolkit\Icons\ThemeSettings.ico" /f >nul 2>&1
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "MUIVerb" /t REG_SZ /d "Theme Settings" /f >nul 2>&1
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "Position" /t REG_SZ /d "Bottom" /f >nul 2>&1
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\command" /ve /t REG_SZ /d "explorer shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f3ffffff0000000000000000000000009001000000000001000005005300650067006f0065002000550049002000530065006d00690062006f006c006400000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-225" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-225" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorInactive" /t REG_DWORD /d "3290373919" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3642695455" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "100" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3642695455" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "4294967286" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f >nul 2>&1
xcopy OldNewExplorer "%ProgramFiles(x86)%\OldNewExplorer\" /e /i /h /y /k /o /x >nul 2>&1
takeown /F %SYSTEMROOT%\System32\wmploc.dll >nul 2>&1
icacls %SYSTEMROOT%\System32\wmploc.dll /grant "Everyone":F >nul 2>&1
REN %SYSTEMROOT%\System32\wmploc.dll wmploc.dll.bak >nul 2>&1
copy Black_WMP\64bit\wmploc.dll %SYSTEMROOT%\System32\ >nul 2>&1
takeown /F %SYSTEMROOT%\SysWOW64\wmploc.dll >nul 2>&1
icacls %SYSTEMROOT%\SysWOW64\wmploc.dll /grant "Everyone":F >nul 2>&1
REN %SYSTEMROOT%\SysWOW64\wmploc.dll wmploc.dll.bak >nul 2>&1
copy Black_WMP\32bit\wmploc.dll %SYSTEMROOT%\SysWOW64\ >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /t REG_SZ /d "#1A1A1A" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /t REG_SZ /d "#FFFFFF" /f >nul 2>&1
RegSvr32.exe /s "%ProgramFiles(x86)%\OldNewExplorer\OldNewExplorer64.dll" >nul 2>&1
RegSvr32.exe /s "%ProgramFiles(x86)%\OldNewExplorer\OldNewExplorer32.dll" >nul 2>&1
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
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "0" /f >nul 2>&1
goto :RestartExplorer
:ONEconfig2
cls
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "Details" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoRibbon" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoCaption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoIcon" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NoUpButton" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "NavBarGlass" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /v "IEButtons" /t REG_DWORD /d "1" /f >nul 2>&1
goto :RestartExplorer
:ONEconfig3
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.  MAKE YOUR CHOICES THEN PRESS CLOSE
"%ProgramFiles(x86)%\OldNewExplorer\OldNewExplorerCfg.exe"
goto :RestartExplorer
:RemoveBlackThemeUXTheme
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "LoadAppInit_DLLs" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v "RequireSignedAppInit_DLLs" /t REG_DWORD /d "0" /f >nul 2>&1
goto :FinishRemoval
:RemoveBlackThemeUXFiles
del /F /Q %SYSTEMROOT%\System32\themeui.dll >nul 2>&1
del /F /Q %SYSTEMROOT%\System32\uxinit.dll >nul 2>&1
ren %SYSTEMROOT%\System32\themeui.dll.bak themeui.dll >nul 2>&1
ren %SYSTEMROOT%\System32\uxinit.dll.bak uxinit.dll >nul 2>&1
del /F /Q %SYSTEMROOT%\System32\themeui.dll.bak >nul 2>&1
del /F /Q %SYSTEMROOT%\System32\uxinit.dll.bak >nul 2>&1
goto :FinishRemoval
:FinishRemoval
Reg.exe delete "HKCR\DesktopBackground\Shell\Personalization" /f >nul 2>&1
Reg.exe delete "HKCU\SOFTWARE\Tihiy\OldNewExplorer" /f >nul 2>&1
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorLightV12" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorMediumV12" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorDarkV12" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux1" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux2" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux3" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux4" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux5" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux6" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux7" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux8" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux9" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux10" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux11" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux12" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux13" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux14" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AppColorAux15" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ActiveTitle" /t REG_DWORD /d "13743257" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ButtonFace" /t REG_DWORD /d "15790320" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "ButtonText" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "GrayText" /t REG_DWORD /d "7171437" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "Hilight" /t REG_DWORD /d "16750899" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "HilightText" /t REG_DWORD /d "16777215" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "HotTrackingColor" /t REG_DWORD /d "13395456" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "InactiveTitle" /t REG_DWORD /d "14405055" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "InactiveTitleText" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "MenuHilight" /t REG_DWORD /d "16750899" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "TitleText" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "Window" /t REG_DWORD /d "16777215" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v "WindowText" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ActiveTitle" /t REG_DWORD /d "7209015" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ButtonFace" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "ButtonText" /t REG_DWORD /d "16777215" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "GrayText" /t REG_DWORD /d "4190783" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "Hilight" /t REG_DWORD /d "16771866" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "HilightText" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "HotTrackingColor" /t REG_DWORD /d "65535" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "InactiveTitle" /t REG_DWORD /d "3080192" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "InactiveTitleText" /t REG_DWORD /d "16777215" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "MenuHilight" /t REG_DWORD /d "8388736" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "TitleText" /t REG_DWORD /d "16777215" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "Window" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\HighContrast" /v "WindowText" /t REG_DWORD /d "16777215" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "-15" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /t REG_SZ /d "-285" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /t REG_SZ /d "-285" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MessageFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /t REG_SZ /d "-255" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /t REG_SZ /d "-255" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /t REG_SZ /d "32" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /t REG_SZ /d "-330" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "StatusFont" /t REG_BINARY /d "f4ffffff0000000000000000000000009001000000000001000005005300650067006f006500200055004900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "-60" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "AppliedDPI" /t REG_DWORD /d "96" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /t REG_SZ /d "-1125" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1125" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d "4278190080" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3288334336" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "89" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3288334336" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "1" /f >nul 2>&1
RegSvr32.exe /u /s "%ProgramFiles(x86)%\OldNewExplorer\OldNewExplorer64.dll" >nul 2>&1
RegSvr32.exe /u /s "%ProgramFiles(x86)%\OldNewExplorer\OldNewExplorer32.dll" >nul 2>&1
del /F /Q %SYSTEMROOT%\System32\wmploc.dll >nul 2>&1
del /F /Q %SYSTEMROOT%\SysWOW64\wmploc.dll >nul 2>&1
ren %SYSTEMROOT%\System32\wmploc.dll.bak wmploc.dll >nul 2>&1
ren %SYSTEMROOT%\SysWOW64\wmploc.dll.bak wmploc.dll >nul 2>&1
goto :RestartExplorer
:ExplorerCleanup
cls
echo.===============================================================================
echo.                           File Explorer Cleanup - Main Menu
echo.===============================================================================
echo.
echo.                           [1]   Quick Access and Delegate Folders Options
echo.
echo.                           [2]   Remove/Add One Drive Icon
echo.
echo.                           [3]   Remove/Add Removable Drives Icons
echo.
echo.                           [4]   Remove/Add Homegroup
echo.
echo.                           [5]   Remove/Add Network Icon
echo.
echo.                           [6]   Remove/Add Libraries
echo.
echo.                           [7]   Remove/Add Details Pane
echo.
echo.                           [8]   Desktop Customizations
echo.
echo.                           [9]   Go To Main Menu
echo.
echo.===============================================================================
choice /C:1234567890X /N /M "Enter Your Choice : "
if errorlevel 9 goto :MainMenu
if errorlevel 8 goto :DesktopCustomizations
if errorlevel 7 goto :DetailsPane
if errorlevel 6 goto :Libraries
if errorlevel 5 goto :Network
if errorlevel 4 goto :Homegroup
if errorlevel 3 goto :HideRemovableDrives
if errorlevel 2 goto :RemoveOneDrive
if errorlevel 1 goto :RemoveQA
:RemoveQA
cls
copy ACL\ACL\SetACL.exe %SYSTEMROOT%\System32\ >nul 2>&1
ACL\SetACL.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hkcr\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hkcr\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
cls
echo.===============================================================================
echo.
echo.                   Remove Quick Access and/or Delegate Folders
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
if errorlevel 4 goto :ExplorerCleanup
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
echo.                     [1]    Remove Quick Access from File Explorer
echo.
echo.                     [2]    Restore Quick Access to File Explorer
echo.
echo.                     [3]    File Explorer Cleanup
echo.
echo.                     [4]    Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :StartAddQA
if errorlevel 1 goto :StartRemoveQA
:StartRemoveQA
cls
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f >nul 2>&1
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f >nul 2>&1
Reg.exe delete "HKCR\Folder\shell\pintohome" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f >nul 2>&1
goto :RestartExplorer
:StartAddQA
cls
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f >nul 2>&1
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f >nul 2>&1
Reg.exe add "HKCR\Folder\shell\pintohome" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f >nul 2>&1
goto :RestartExplorer
:AddDF
cls
echo.===============================================================================
echo.
echo.                     Remove/Restore Delegate Folders to File Explorer
echo.
echo.===============================================================================
echo.
echo.                     [1]    Remove Delegate Folders from File Explorer
echo.
echo.                     [2]    Restore Delegate Folders to File Explorer
echo.
echo.                     [3]    File Explorer Cleanup
echo.
echo.                     [4]    Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :StartAddDF
if errorlevel 1 goto :StartRemoveDF
:StartRemoveDF
cls
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" / >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
goto :RestartExplorer
:StartAddDF
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
goto :RestartExplorer
:AddQAandD
cls
echo.===============================================================================
echo.
echo.                     Remove/Restore Quick Access to File Explorer
echo.
echo.===============================================================================
echo.
echo.                     [1]    Remove Quick Access and Delegate Folders
echo.                            from File Explorer
echo.
echo.                     [2]    Restore Quick Access and Delegate Folders
echo.                            to File Explorer
echo.
echo.                     [3]    File Explorer Cleanup
echo.
echo.                     [4]    Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :StartAddQAandD
if errorlevel 1 goto :StartRemoveQAandD
:StartRemoveQAandD
cls
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f >nul 2>&1
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2690646016" /f >nul 2>&1
Reg.exe delete "HKCR\Folder\shell\pintohome" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
goto :RestartExplorer
:StartAddQAandD
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f >nul 2>&1
Reg.exe add "HKCR\Wow6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2685403136" /f >nul 2>&1
Reg.exe add "HKCR\Folder\shell\pintohome" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f >nul 2>&1
goto :RestartExplorer
:RemoveOneDrive
cls
echo.===============================================================================
echo.                     Hide/Restore OneDrive Icon
echo.===============================================================================
echo.
echo.                     [1]   Hide OneDrive Icon from File Explorer
echo.
echo.                     [2]   Restore OneDrive Icon to File Explorer
echo.
echo.                     [3]   File Explorer Cleanup
echo.
echo.                     [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :StartAddOD
if errorlevel 1 goto :StartRemoveOD
:StartRemoveOD
cls
Reg.exe delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4035969101" /f >nul 2>&1
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6-XXX}" /f >nul 2>&1
goto :ExplorerCleanup
:StartAddOD
cls
Reg.exe delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f >nul 2>&1
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4034920525" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6-XXX}" /f >nul 2>&1
goto :ExplorerCleanup
:HideRemovableDrives
cls
echo.===============================================================================
echo.                    Hide Removable Drives from File Explorer
echo.===============================================================================
echo.
echo.                    [1]   Hide Removable Drives from File Explorer
echo.
echo.                    [2]   Restore Removable Drives to File Explorer
echo.
echo.                    [3]   File Explorer Cleanup
echo.
echo.                    [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :AddRemovableDrives
if errorlevel 1 goto :StartHideDrives
:StartHideDrives
cls
Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f >nul 2>&1
goto :ExplorerCleanup
:AddRemovableDrives
cls
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f >nul 2>&1
goto :ExplorerCleanup
:HomeGroup
cls
echo.===============================================================================
echo.                   Disable Homegroup and Hide in File Explorer
echo.===============================================================================
echo.
echo.                   [1]   Disable Homegroup
echo.
echo.                   [2]   Enable Homegroup
echo.
echo.                   [3]   File Explorer Cleanup
echo.
echo.                   [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :EnableHomegroup
if errorlevel 1 goto :DisableHomegroup
:DisableHomegroup
cls
sc stop "HomeGroupProvider" >nul 2>&1
sc config "HomeGroupProvider" start=disabled >nul 2>&1
sc config "HomeGroupListener" start=disabled >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
takeown /f C:\Windows\System32\hgcpl.dll >nul 2>&1
takeown /f C:\Windows\System32\en-US\hgcpl.dll.mui >nul 2>&1
takeown /f C:\Windows\SysWOW64\hgcpl.dll >nul 2>&1
takeown /f C:\Windows\SysWOW64\en-US\hgcpl.dll.mui >nul 2>&1
icacls C:\Windows\System32\hgcpl.dll /grant "Everyone":F >nul 2>&1
icacls C:\Windows\System32\en-US\hgcpl.dll.mui /grant "Everyone":F >nul 2>&1
icacls C:\Windows\SysWOW64\hgcpl.dll /grant "Everyone":F >nul 2>&1
icacls C:\Windows\SysWOW64\en-US\hgcpl.dll.mui /grant "Everyone":F >nul 2>&1
del C:\Windows\System32\hgcpl.dll >nul 2>&1
del C:\Windows\System32\en-US\hgcpl.dll.mui >nul 2>&1
del C:\Windows\SysWOW64\hgcpl.dll >nul 2>&1
del C:\Windows\SysWOW64\en-US\hgcpl.dll.mui >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowCPL" /v "HomeGroup" /t REG_SZ /d "HomeGroup" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\Directory\Background\shell\empty" /v "Description" /t REG_SZ /d "@shell32.dll,-31332" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\Directory\Background\shell\empty" /v "Icon" /t REG_SZ /d "shell32.dll,-254" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\Directory\Background\shell\empty" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-10564" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\Directory\Background\shell\empty\command" /v "DelegateExecute" /t REG_SZ /d "{48527bb3-e8de-450b-8910-8c4099cb8624}" /f >nul 2>&1
goto :RestartExplorer
:EnableHomegroup
cls
copy HomeGroup\System32\hgcpl.dll %SYSTEMROOT%\System32\ >nul 2>&1
copy HomeGroup\System32\en-us\hgcpl.dll.mui %SYSTEMROOT%\System32\en-us\ >nul 2>&1
copy HomeGroup\SysWOW64\hgcpl.dll %SYSTEMROOT%\SysWOW64\ >nul 2>&1
copy HomeGroup\SysWOW64\en-us\hgcpl.dll.mui %SYSTEMROOT%\SysWOW64\en-us\ >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /ve /t REG_SZ /d "HomeGroup Control Panel" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "InfoTip" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\hgcpl.dll,-2#immutable1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "LocalizedString" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\hgcpl.dll,-1#immutable1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.ApplicationName" /t REG_SZ /d "Microsoft.HomeGroup" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.ControlPanel.Category" /t REG_SZ /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.ControlPanel.EnableInSafeMode" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.Software.TasksFileUrl" /t REG_SZ /d "Internal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-1013" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\shdocvw.dll" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" /v "CLSID" /t REG_SZ /d "{328B0346-7EAF-4BBE-A479-7CB88A095F5B}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" /v "ResourceDLL" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\hgcpl.dll" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" /v "ResourceID" /t REG_DWORD /d "100" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2684354560" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" /v "WantsParseDisplayName" /t REG_SZ /d "" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /ve /t REG_SZ /d "HomeGroup Control Panel" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "InfoTip" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\hgcpl.dll,-2#immutable1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "LocalizedString" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\hgcpl.dll,-1#immutable1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.ApplicationName" /t REG_SZ /d "Microsoft.HomeGroup" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.ControlPanel.Category" /t REG_SZ /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.ControlPanel.EnableInSafeMode" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}" /v "System.Software.TasksFileUrl" /t REG_SZ /d "Internal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-1013" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\shdocvw.dll" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\InProcServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance" /v "CLSID" /t REG_SZ /d "{328B0346-7EAF-4BBE-A479-7CB88A095F5B}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" /v "ResourceDLL" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\hgcpl.dll" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\Instance\InitPropertyBag" /v "ResourceID" /t REG_DWORD /d "100" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2684354560" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{67CA7650-96E6-4FDD-BB43-A8E774F73A57}\ShellFolder" /v "WantsParseDisplayName" /t REG_SZ /d "" /f >nul 2>&1
sc config "HomeGroupProvider" start=auto >nul 2>&1
sc config "HomeGroupListener" start=auto >nul 2>&1
sc start "HomeGroupProvider" >nul 2>&1
goto :RestartExplorer
:Network
cls
echo.===============================================================================
echo.                   Hide/Show Network Icon in File Explorer
echo.===============================================================================
echo.
echo.                   [1]   Hide Network Icon
echo.
echo.                   [2]   Restore Network Icon
echo.
echo.                   [3]   File Explorer Cleanup
echo.
echo.                   [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :EnableNetworkIcon
if errorlevel 1 goto :DisableNetworkIcon
:DisableNetworkIcon
cls
ACL\SetACL.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489444" /f >nul 2>&1
Reg.exe add "HKCR\WOW6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489444" /f >nul 2>&1
goto :RestartExplorer
:EnableNetworkIcon
cls
ACL\SetACL.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hkcr\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
ACL\SetACL.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}}\ShellFolder" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
ACL\SetACL.exe -on "hkcr\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}}\ShellFolder" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2953052260" /f >nul 2>&1
Reg.exe add "HKCR\WOW6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2953052260" /f >nul 2>&1
goto :RestartExplorer
:Libraries
cls
echo.===============================================================================
echo.                     Hide/Show Libraries in File Explorer
echo.===============================================================================
echo.
echo.                     [1]   Show Libraries
echo.
echo.                     [2]   Hide Libraries
echo.
echo.                     [3]   File Explorer Cleanup
echo.
echo.                     [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :HideLibraries
if errorlevel 1 goto :ShowLibraries
:ShowLibraries
cls
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}" /t REG_SZ /d "C:\Users\Dave\AppData\Roaming\Microsoft\Windows\Libraries" /f >nul 2>&1
Reg.exe add "HKCU\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f >nul 2>&1
goto :RestartExplorer
:HideLibraries
cls
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /f >nul
Reg.exe add "HKCU\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >nul 2>&1
goto :RestartExplorer
:DetailsPane
cls
echo.===============================================================================
echo.                      Hide/Show Details Pane in File Explorer
echo.===============================================================================
echo.
echo.                      [1]   Hide Details Pane
echo.
echo.                      [2]   Restore Details Pane
echo.
echo.                      [3]   File Explorer Cleanup
echo.
echo.                      [4]   Back to Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :ExplorerCleanup
if errorlevel 2 goto :ShowDetailsPane
if errorlevel 1 goto :HideDetailsPane
:HideDetailsPane
cls
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" /v "PreviewPaneSizer" /t REG_BINARY /d "4500000000000000000000000c020000" /f >nul 2>&1
goto :RestartExplorer
:ShowDetailsPane
cls
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" /v "PreviewPaneSizer" /t REG_BINARY /d "4500000001000000000000000c020000" /f >nul 2>&1
goto :RestartExplorer
:DesktopCustomizations
cls
echo.===============================================================================
echo.                          Desktop Customizations
echo.===============================================================================
echo.
echo.                          [1]   Apply Theme to Windows Version Window
echo.
echo.                          [2]   Enable/Disable Immersive Context Menu
echo.
echo.                          [3]   Increase or Return to Default 
echo.                                Taskbar Transparency
echo.
echo.                          [4]   Enable or Return to Default Blur in 
echo.                                Taskbar and Start Menu
echo.
echo.                          [5]   Enable Alt or Revert to Default Alt-Tab View
echo.
echo.                          [6]   File Explorer Cleanup
echo.
echo.                          [7]   Main Menu
echo.
echo.                          [X]   Quit
echo.
echo.===============================================================================
choice /C:1234567X /N /M "Enter Your Choice : "
if errorlevel 8 goto :QuitProgram
if errorlevel 7 goto :MainMenu
if errorlevel 6 goto :ExplorerCleanup
if errorlevel 5 goto :AltTab
if errorlevel 4 goto :Blur
if errorlevel 3 goto :TBTrans
if errorlevel 2 goto :CXMenu
if errorlevel 1 goto :WinVerTheme
:WinVerTheme
cls
echo.===============================================================================
echo.                       Windows Version Window Customization
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
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Aqua\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:Black
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Black\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:Blue
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Blue\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:Green
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Green\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:Orange
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Orange\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:Pink
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Pink\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:Red
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Red\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:Original
cls
takeown /F %SYSTEMROOT%\Branding\Basebrd\basebrd.dll >nul 2>&1
icacls %SYSTEMROOT%\Branding\Basebrd\basebrd.dll /grant "Everyone":F >nul 2>&1
copy Basebrd_mods\Original\basebrd.dll %SYSTEMROOT%\Branding\Basebrd\ >nul 2>&1
winver
goto :DesktopCustomizations
:CXMenu
cls
echo.===============================================================================
echo.                     Enable\Disable Immersive Context Menu
echo.
echo.===============================================================================
echo.
echo.                     [1]   Disable Immersive Context Menu
echo.
echo.                     [2]   Enable Immersive Context Menu
echo.
echo.                     [3]   File Explorer Cleanup
echo.
echo.                     [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :DesktopCustomizations
if errorlevel 2 goto :ECX
if errorlevel 1 goto :DCX
:DCX
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d "0" /f >nul 2>&1
goto :restartexplorer
:ECX
cls
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d "1" /f >nul 2>&1
goto :restartexplorer
:TBTrans
cls
echo.===============================================================================
echo.                    Enable\Disable Increase in Taskbar Transparency
echo.
echo.===============================================================================
echo.
echo.                    [1]   Increase Taskbar Transparency
echo.
echo.                    [2]   Return Taskbar to Default Transparency
echo.
echo.                    [3]   File Explorer Cleanup
echo.
echo.                    [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :DesktopCustomizations
if errorlevel 2 goto :RemoveTBTrans
if errorlevel 1 goto :AddTBTrans
:AddTBTrans
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /t REG_DWORD /d "1" /f >nul 2>&1
goto :RestartExplorer
:RemoveTBTrans
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f >nul 2>&1
goto :RestartExplorer
:Blur
cls
echo.===============================================================================
echo.                        Enable\Disable Blur in Start Menu
echo.
echo.===============================================================================
echo.
echo.                        [1]   Enable Blur
echo.
echo.                        [2]   Disable Blur
echo.
echo.                        [3]   File Explorer Cleanup
echo.
echo.                        [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :DesktopCustomizations
if errorlevel 2 goto :RemoveBlur
if errorlevel 1 goto :StartBlur
:StartBlur
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /t REG_DWORD /d "1" /f >nul 2>&1
goto :RestartExplorer
:RemoveBlur
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /f >nul 2>&1
goto :RestartExplorer
:AltTab
cls
echo.===============================================================================
echo.                     Enable\Disable Alternate Alt/Tab View Settings
echo.===============================================================================
echo.
echo.                     [1]   Enable Alternate Alt/Tab View
echo.
echo.                     [2]   Disable Alternate Alt/Tab View
echo.
echo.                     [3]   File Explorer Cleanup
echo.
echo.                     [4]   Main Menu
echo.
echo.===============================================================================
choice /C:1234X /N /M "Enter Your Choice : "
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :DesktopCustomizations
if errorlevel 2 goto :AltTabRestore
if errorlevel 1 goto :StartAltTab
:StartAltTab
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AltTabViewHost" /v "Wallpaper" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AltTabViewHost" /v "Grid_backgroundPercent" /t REG_DWORD /d "0" /f >nul 2>&1
goto :RestartExplorer
:AltTabRestore
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AltTabViewHost" /f >nul 2>&1
goto :RestartExplorer
:x86
cls
echo.
echo.
echo.
echo.===============================================================================
echo.
echo.              Your OS is NOT COMPATIBLE With This Toolkit
echo.
echo.===============================================================================
echo.
echo.
echo.
echo Press Any Key to Exit the Program
pause >nul 2>&1
goto :eof
:QuitProgram
goto :eof