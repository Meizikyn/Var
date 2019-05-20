# This script does not support use of existing user profile as container
# Must use GMAN sid containers for hives to work
#
# If attempt to run with real user profile, may cause
# damage to existing keys, and software may stop functioning properly
If (!($args[0] -eq 'INTENTION')) {EXIT}

Set-PSDebug -Trace 1

$sid = $args[1]
$root = $args[2]
$user = $args[3]
$program = $args[4]

$root
$user
$program

Function Save-Profile-Hive-Diff () {
	$ProfileKeys = (Get-ChildItem -Name $root\profiles\$user\$program\.keys)
	$QueryKeys = (REG QUERY HKU\$sid\SOFTWARE) | ForEach { Split-Path -Path REGISTRY::$_ -Leaf -Resolve }
	#$Blacklist = (Get-Content $root\data\$user\config\blacklist\keys)


	$Keys = $QueryKeys #| Where { $ProfileKeys -NotContains $_ }

	$Keys | Where { $Blacklist -NotContains $_ } | ForEach {
		$Key = (Split-Path -Path REGISTRY::HKEY_USERS\$sid\SOFTWARE\$_ -Leaf -Resolve)
		REG SAVE HKU\$sid\SOFTWARE\$_ $root\profiles\$user\$program\.keys\$Key
		If ($?) { REG DELETE $_ }
	}
}



Save-Profile-Hive-Diff	