' spongebob_prank.vbs
Option Explicit

Dim WshShell, imagePath
Set WshShell = CreateObject("WScript.Shell")

' Path to the image you saved (change if you saved it elsewhere)
imagePath = WshShell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Pictures\spongebob.jpg"

' -- Safety check: verify file exists --
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
If Not fso.FileExists(imagePath) Then
    MsgBox "Cannot find image at:" & vbCrLf & imagePath & vbCrLf & vbCrLf & "Save the image to this location first.", vbExclamation, "Image not found"
    WScript.Quit
End If

' -- Write registry values Windows reads for wallpaper --
WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", imagePath, "REG_SZ"
WshShell.RegWrite "HKCU\Control Panel\Desktop\WallpaperStyle", "10", "REG_SZ"   ' 10 = Fill
WshShell.RegWrite "HKCU\Control Panel\Desktop\TileWallpaper", "0", "REG_SZ"

' -- Force Windows to reload wallpaper (notify Explorer) --
' Use Rundll32 to make Explorer refresh the per-user system parameters
WshShell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 0, True

' -- Show the prank message --
X = MsgBox("Message Description", 0+16, "youve been hacked")


