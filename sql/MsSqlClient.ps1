
Write-Host "Started MsSqlClient.ps1: XL Deploy"
echo "Started MsSqlClient.ps1: XL Deploy"

$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "sqlcmd.exe"
$pinfo.Arguments = '-S localhost -M -E -Q "SELECT CURRENT_USER;"'
$pinfo.Username = "$cUser"
$pinfo.Domain = "TESTENT"
$pinfo.Password = (ConvertTo-SecureString -String "$cPass" -AsPlainText -Force) 
$pinfo.RedirectStandardError = $true 
$pinfo.RedirectStandardOutput = $true 
$pinfo.UseShellExecute = $false 
$p = New-Object System.Diagnostics.Process 
$p.StartInfo = $pinfo
$p.Start() | Out-Null
$p.WaitForExit()
$output = $p.StandardOutput.ReadToEnd()
$output += $p.StandardError.ReadToEnd()
write-host $output
