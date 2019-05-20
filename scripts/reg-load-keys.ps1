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

Function Load-Profile-Keys () {
	$Keys = Get-ChildItem -Path $root\profiles\$user\$program\.keys -Name
	$Keys
	$Keys | ForEach {
		REG ADD HKU\$sid\SOFTWARE\$_
		REG RESTORE HKU\$sid\SOFTWARE\$_ $root\profiles\$user\$program\.keys\$_
	}
}



Load-Profile-Keys	