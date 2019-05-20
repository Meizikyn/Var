@echo off
setlocal

:DEFAULT_PARAM
set r=0
set u=root
set s=0

:CHECK_PARAM
IF "%1"=="" GOTO :DONE
REM ECHO              %1
SET AUX=%1
IF "%AUX:~0,1%"=="-" (
   SET N=%AUX:~1,250%
) ELSE (
   SET "%N%=%1"
   SET N=
)
SHIFT
GOTO :CHECK_PARAM
:done

echo %p%
echo %r%
echo %u%
echo %s%