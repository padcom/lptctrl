@echo off

set path=C:\LPTCtrl\Install;%PATH%

gacutil /i C:\LPTCtrl\Service\Cassini.dll 
gacutil /i C:\LPTCtrl\Service\FirebirdSql.Data.FirebirdClient.dll

pause
