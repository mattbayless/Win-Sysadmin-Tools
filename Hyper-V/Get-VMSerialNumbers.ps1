function Get-VMSerialNumbers {
	param (
		[Parameter()][ValidateNotNullOrEmpty()][string]$HostName = $env:COMPUTERNAME
	)
	Get-CimInstance -ComputerName $HostName -Namespace root\virtualization\v2 -class Msvm_VirtualSystemSettingData | Select-Object elementname, BIOSSerialNumber
}