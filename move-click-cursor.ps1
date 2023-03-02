$MYJOB = Start-Job -ScriptBlock {

    $MOVEMENTSIZE = 15
    $SLEEPTIME = 3

    Add-Type -AssemblyName System.Windows.Forms
    while ($true) {
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x += $MOVEMENTSIZE
    $POSITION.y += $MOVEMENTSIZE
    [Windows.Forms.Cursor]::Position = $POSITION
    Start-Sleep -Seconds $SLEEPTIME
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x -= $MOVEMENTSIZE
    $POSITION.y -= $MOVEMENTSIZE
    [Windows.Forms.Cursor]::Position = $POSITION
    $signature=@' 
      [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
      public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@ 
    $SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru 

    $SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
    $SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
    Start-Sleep -Seconds $SLEEPTIME
    }
}
