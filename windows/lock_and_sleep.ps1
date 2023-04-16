<#

This PowerShell script locks your current session, then immediately turns off your monitor.

You don't have to wait for or alter your screen timeout, 
or use a sleep button set to turning off monitor that doesn't exist on your computer.

#>

$LockWorkStation = Add-Type -Name "Win32LockWorkStation" -PassThru -MemberDefinition @"
    [DllImport("user32.dll")]
    public static extern int LockWorkStation();
"@ 

$PostMessage = Add-Type -Name "Win32PostMessage" -PassThru -MemberDefinition @"
    [DllImport("user32.dll")]
    public static extern int PostMessage(int hWnd, int hMsg, int wParam, int lParam);
"@

# lock workstation

Write-Information -MessageData "Locking workstation" -InformationAction Continue
if (0 -eq $LockWorkStation::LockWorkStation()) {
    throw 'Failed to lock workstation'
}

# turn off monitor

$WM_SYSCOMMAND = 0x0112
$SC_MONITORPOWER = 0xF170

Write-Information -MessageData "Turning off monitor" -InformationAction Continue
if (0 -eq $PostMessage::PostMessage(-1, $WM_SYSCOMMAND, $SC_MONITORPOWER, 2)) {
    throw 'Failed to turn off monitor'
}

