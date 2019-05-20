IF NOT EXIST D:\Isolation\run MKDIR D:\Isolation\run
imdisk -a -t vm -s 64m -m D:\Isolation\run -p "/fs:ntfs /q /y"
xcopy /E D:\Isolation\config\skeleton\run\* D:\Isolation\run
copy D:\Isolation\config\sids\public D:\Isolation\run\global\sid\free