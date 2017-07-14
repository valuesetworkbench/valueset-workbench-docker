@echo off

docker run -v %cd%:/work -it pgarrett/openssl-alpine openssl req -x509 -newkey rsa:2048 -keyout /work/key.pem -out /work/ca.pem -days 1080 -nodes -subj "/CN=*/O=MyCompanyNameLTD/C=US"