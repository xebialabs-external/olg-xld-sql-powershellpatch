
Write-Host "Started MsSqlClient.ps1: XL Deploy"
echo "Started MsSqlClient.ps1: XL Deploy"

Write-Host 'powershell_context: script -> $sqlScriptToExecute = ' $sqlScriptToExecute
Write-Host 'powershell_context: self.__deployed -> $deployed = ' $deployed
Write-Host 'powershell_context: self.deployed.container -> $container = ' $container
Write-Host 'powershell_context: deployed.container.serverName -> $serverName = ' $serverName
Write-Host 'powershell_context: deployed.container.databaseName -> $databaseName = ' $databaseName
Write-Host 'powershell_context: $cUser = ' $cUser
Write-Host 'powershell_context: $cPass = ' $cPass

write-host '------------------------------------------------'
write-host '$pinfo' = New-Object System.Diagnostics.ProcessStartInfo
write-host '$pinfo.FileName' = "sqlcmd.exe"
write-host '$pinfo.Arguments = -S' $serverName '-M -E -d' "$databaseName" '-i' "$sqlScriptToExecute"
write-host '$pinfo.Username' = ' ${sanitize(cmn.lookup('username'))}'
write-host '$pinfo.Domain = "TESTENT"'
write-host '$pinfo.Password = (ConvertTo-SecureString -String " ${sanitize(cmn.lookup('password'))}" -AsPlainText -Force) $pinfo.RedirectStandardError = $true $pinfo.RedirectStandardOutput = $true $pinfo.UseShellExecute = $false $p = New-Object System.Diagnostics.Process $p.StartInfo = $pinfo'
write-host '$p.Start() | Out-Null'
write-host '$p.WaitForExit()'
write-host '$output = $p.StandardOutput.ReadToEnd()'
write-host '$output += $p.StandardError.ReadToEnd()'
write-host 'write-host $output'
write-host '------------------------------------------------'

