SET PROFILE_CN=Isolation-001
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v %PROFILE_CN% /t REG_DWORD /d 0
