# This script does not support use of existing user profile as container
# Must use GMAN sid containers for hives to work
#
# If attempt to run with real user profile, may cause
# damage to existing keys, and software may stop functioning properly
If (!($args[0] -eq 'INTENTION')) {EXIT}

$savekeys = $args[1]
$sid = $args[2]
$root = $args[3]
$user = $args[4]
$program = $args[5]

$root
$user
$program

Function Save-Profile-Keys () {
	$QueryKeys = (REG QUERY HKU\$sid\SOFTWARE) | ForEach { Split-Path -Path REGISTRY::$_ -Leaf -Resolve }
	#$Blacklist = (Get-Content $root\data\$user\config\blacklist\keys)


	$Keys = $QueryKeys #| Where { $Blacklist -NotContains $_ }

	$Keys | ForEach {
		$Key = (Split-Path -Path REGISTRY::HKEY_USERS\$sid\SOFTWARE\$_ -Leaf -Resolve)
		REG SAVE HKU\$sid\SOFTWARE\$_ $root\profiles\$user\$program\.keys\$Key
		#If ($?) { If ($savekeys -eq 1) {REG DELETE HKU\$sid\SOFTWARE\$_ } }
	}
}



Save-Profile-Keys	