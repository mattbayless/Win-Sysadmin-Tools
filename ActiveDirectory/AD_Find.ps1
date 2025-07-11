# Does require ActiveDirectory module; not using Requires as it slows profile load

# Can pass through parameters but does not tab complete

function Find-ADUser {
	param (
		[Parameter(Mandatory,ValueFromRemainingArguments)][ValidateNotNullOrEmpty()][string]$Query
	)
	Get-ADUser -Filter "anr -eq '$Query'" @args
}

function Find-ADComputer {
	param (
		[Parameter(ParameterSetName="Query",Mandatory)][ValidateNotNullOrEmpty()][string]$Query,
		[Parameter(ParameterSetName="AssetTag",Mandatory,ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string]$AssetTag

	)
	if ($PSCmdlet.ParameterSetName -eq "AssetTag") {
		$FilterQuery = "*-$AssetTag"
	}
	if ($PSCmdlet.ParameterSetName -eq "Query") {
		$FilterQuery = "*$Query*"
	}
	Get-ADComputer -Filter "Name -like '$FilterQuery'" @args
}