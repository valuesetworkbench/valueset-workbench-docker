@echo off

set SERVER_HOST=%COMPUTERNAME%
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