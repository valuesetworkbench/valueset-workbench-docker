@echo off

@ECHO OFF
SETLOCAL
Setlocal EnableDelayedExpansion

set SERVER_HOST=%COMPUTERNAME%

:loop
IF NOT "%1"=="" (
    IF "%1"=="-h" (
	echo here %1 %2
        SET SERVER_HOST=%2       
    )
    IF "%1"=="-r" (
 	call:random_password       
    )
    SHIFT
    GOTO :loop
)

set EXTERNAL_URL=https://%SERVER_HOST%
set ENV_FILE=./conf/config.env

if not exist "ssl/cert.haproxy" (
  cd ssl
  call make_self_signed_keys.bat
  call make_ssl_cert.bat
  cd ..
)

(for /f "delims=" %%b in (ssl/cert.haproxy) do (
    set DEFAULT_SSL_CERT=%%b
))

docker-compose build --pull
docker-compose up -d

echo ""
echo "Value Set Workbench is starting at https://%SERVER_HOST%/"
echo " * NOTE: Service may take a few minutes to start."
if defined ADMIN_PASSWORD (
 echo Admin username/password: admin/%ADMIN_PASSWORD%
)

EXIT /B %ERRORLEVEL%

:: from https://superuser.com/a/349478
:random_password
Set _RNDLength=16
Set _Alphanumeric=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum=
:_loop
Set /a _count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum=!_RndAlphaNum!!_Alphanumeric:~%_RND%,1!
If !_count! lss %_RNDLength% goto _loop
endlocal
set ADMIN_PASSWORD=!_RndAlphaNum!
EXIT /B 0