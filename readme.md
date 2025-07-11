# Windows Sysadmin Tools

Some Powershell commands I built and found useful enough to polish up and share. The list so far:

## [AD Find](ActiveDirectory/AD_Find.ps1)
Replicates the functionality of searching in the *Active Directory Users and Computers* GUI.
Requires the ActiveDirectory module.
```powershell
Find-ADUser "john doe" -Properties Office,Title

Find-ADComputer -AssetTag 12345 -Properties whenChanged
```

## [Connect-CMRemoteControlSession](ConfigMgr/CMRC.ps1)
Launches a Configuration Manager Remote Control Viewer connection by device name or asset tag.
Requires the ConfigurationManager module.
```powershell
Connect-CMRemoteControlSession -DeviceName "laptop-12345"

cmrc -AssetTag 12345
```

## [Convert Encoded Command](General/Convert-EncodedCommand.ps1)
Encode or decode Base64 strings, useful for PowerShell's `-EncodedCommand` parameter.
```powershell
ConvertFrom-Base64String "SABlAGwAbABvACAAdABoAGUAcgBlACEA"

ConvertTo-EncodedCommand "Write-Host 'Hello there!'"
```