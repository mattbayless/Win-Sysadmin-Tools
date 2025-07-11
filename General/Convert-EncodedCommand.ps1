function ConvertTo-Base64String {
	[Alias("ConvertTo-EncodedCommand","ctec")]
	param (
		[Parameter (ValueFromPipeline)][Alias("Command")][string]$String
	)
	[Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($String))
}

function ConvertFrom-Base64String {
	[Alias("ConvertFrom-EncodedCommand","cfec")]
	param (
		[Parameter (ValueFromPipeline)][Alias("Command")][string]$String
	)
	[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($String))
}

# what about line breaks? https://github.com/helpimnotdrowning/PwshUtils/blob/master/Base64.ps1