# Windows Environment Isolation Controller
## Formerly GMAN

# Why

I needed a way to isolate windows software with file/registry capturing in mind without the use of conflicting windows API versioning and third-party software.

This is intended to isolating PC Games, Save Data, Mods, Registry settings, etc. for backup/migration purposes, however it has been tested with a multitude of applications.

This also helps keep the windows registry clean by isolating registry calls to "ghost" hives
that have their keys saved/loaded from external files.

# How

I have found that windows (since vista) virtualizes registry calls from HKLM/Software to HKCU/Software.

Obviously any software that respects %USERPROFILE% can be redirected by changing this variable at runtime,
but I needed a reliable way to handle absolute path calls based on the registry, and registry keys themselves.

This tool acts as a front-end to the REG tool, sets up a few environment variables used by most applications to locate configuration directories, and loads a "fake user" into the registry to capture changes in temporary hives, which are then saved to (per-key) to seperate hive files for analysis and later loading, effectively isolating the application from the User's hive.

# Warnings

This tool is not for security purposes, and in fact violates nearly every "best practice" of security dos and don'ts, for this reason, its best to consider this less of an application on its own, and more a collection of "exploits" to achieve the intended goal in the most light-weight fashion possible.

I've published this for backup purposes more-so than to share it, as I have neglected to document its configuration and use, nor implement a large number of intended features as the core of the tool is functional for its purpose and supports multiple users.

Be warned, this is in a state of "works-for-me", and will not likely see user-friendly updates in the near-future without the interest of other users, and the nature of this being an "exploit" over and application make it unlikely I will make this more user-friendly to novice users.

I can not in good conscience recommend this tool without warning that this requires the opening of many security wholes in the OS, as it is intended to exist in offline workstations.

# Documentation

As stated above, I have neglected to write documenation for the tool, as its nature likely only make it useful to a small niche of power-users, if at all.

The tool operates from `gman.cmd` and `load.cmd`, and is intended to be launched via explorer shortcuts (.lnk files) pointing to gman.cmd, passing in variables to manipulate to application run.

# Requirements

This tool requires sysinternals PsExec.exe and PsExec64.exe to operate properly, and it is recommended to install ImDisk.

Scripts are provided (and run automatically by default) to use ImDisk to create and mount a ramdisk within the working directory for temporary files and registry hives to live.

"Sister Accounts" must also be made for every instance of applications that can be simultaneously, at least two are recommended at minimum as the windows kernel occasionally locks a file handle on a loaded hive and must be cleared by running an empty application or shell.

Sister accounts must be placed in config/sids/[public,private], named after the "Sister Account" username, and containing the Microsoft SAM Security identifier of the account. Two example SID files are provided to exhibit this.

The primary script is very simple, and more verbose information can be reversed from the script with some small analysis as its inner workings are mostly shelled out to even more simple PowerShell scripts.
