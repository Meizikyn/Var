* Windows Environment Isolation Controller (EIC)
** Formerly called gman

You probably don't want to use this, might not end well, your call

* Purpose

I needed a way to isolate windows software with file/registry capturing in mind

This is intended to isolating PC Games, Save Data, Mods, Registry settings, etc. for backup/migration purposes

This also helps keep the windows registry clean by isolating registry calls to "ghost" hives
that have their keys saved/loaded from external files.

* How
I found that windows (since vista) virtualizes registry calls from HKLM/Software to HKCU/Software

Obviously any software that respects %USERPROFILE% can be redirected 

* Warnings
This tool is not for security purposes, and in fact violates nearly every "best practice" of security dos and don'ts

I published this really for backup purposes, but there is nothing stopping someone else from using it

Be warned, this is in a state of "works-for-me", and I don't see myself making user-friendly updates in the future
as I'm pretty much done with this unless I see enough people wanting it, but the requirements for multiple windows profiles
and bad security practices by nature make that unlikely, and I can not in good conscience recommend this software
(or the use of windows in general, for that matter).

* If you really really want to use this

This MUST live in `D:\Isolation`, at least I think so, can't remember

This MUST have the following new directories created there, each with a subdir named after a user
```
/software%USERNAME%
/profiles/%USERNAME%
```

--- got lazy, stopped writing here, crack open the files and figure it out, or message me/comment here to show interest and I'll finish the documentation
