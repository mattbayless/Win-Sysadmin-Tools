#Requires -Module ConfigurationManager

function Connect-CMRemoteControlSession {
	[Alias("cmrc")]
	[CmdletBinding(SupportsShouldProcess,DefaultParameterSetName="DeviceName")]
	param (
		[Parameter(ValueFromPipelineByPropertyName,Mandatory,ParameterSetName="DeviceName")][Alias("Name")][string]$DeviceName, # Can be piped from get-adcomputer, get-iiqasset
		[Parameter(ValueFromPipelineByPropertyName,Mandatory,ParameterSetName="AssetTag")][Alias("Asset")][string]$AssetTag,
		[switch]$SkipOnlineCheck,
		[pscredential]$Credential
	)
	function Resolve-CMDevice {
		$SavedPWD = $PWD
		Set-Location -LiteralPath "$((Get-PSDrive -PSProvider CMSite)[0]):"
		$script:CMDevice = Get-CMDevice -Fast @args
		Set-Location -Path $SavedPWD
	}
	if ($PSCmdlet.ParameterSetName -eq "AssetTag") {
		Resolve-CMDevice -Name "*-$AssetTag"
		if ($CMDevice) {
			$DeviceName = $CMDevice.Name
		}
		else {
			Write-Error "No match for `"$AssetTag`" in Configuration Manager." -ErrorAction Stop -Category ObjectNotFound
		}
	}
	if (!$SkipOnlineCheck) {
		if (!$CMDevice) {
			Resolve-CMDevice -Name $DeviceName
		}
		if ($CMDevice) {
			if ($CMDevice.CNIsOnline -ne $true) {
				Write-Host "$($CMDevice.Name) is not online." # Write-Warning?
				return
			}
		}
		else {
			Write-Error "Device `"$DeviceName`" not found in Configuration Manager." -ErrorAction Stop -Category ObjectNotFound
		}
	}
	$params = @{
		ArgumentList = $DeviceName
	}
	if ($PSBoundParameters.ContainsKey('Credential')) {
		$params.Add("Credential", $Credential)
	}
	if ($PSCmdlet.ShouldProcess("$DeviceName")) {
		Start-Process "${env:ProgramFiles(x86)}\Microsoft Endpoint Manager\AdminConsole\bin\i386\CmRcViewer.exe" @params
	}
}