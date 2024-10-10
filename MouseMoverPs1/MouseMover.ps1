Add-Type -AssemblyName System.Windows.Forms

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class MouseMover {
    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);
    public struct POINT {
        public int X;
        public int Y;
    }
}
"@

$initialPos = [MouseMover+POINT]::new()
[MouseMover]::GetCursorPos([ref]$initialPos)

$screenWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
$screenHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height

Write-Host "El ancho de la pantalla es: $screenWidth"
Write-Host "La altura de la pantalla es: $screenHeight"

while ($true) {
    Start-Sleep -Milliseconds 60000
    $currentPos = [MouseMover+POINT]::new()
    [MouseMover]::GetCursorPos([ref]$currentPos)   
       
    $randomX = Get-Random -Minimum 0 -Maximum $screenWidth
    $randomY = Get-Random -Minimum 0 -Maximum $screenHeight
	
	Write-Host "RandomX: $randomX | RandomY: $randomY"
	
    [MouseMover]::SetCursorPos($randomX, $randomY)
}