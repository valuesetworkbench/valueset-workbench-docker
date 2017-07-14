@echo off

docker run -v %cd%:/work ubuntu /bin/bash -c "cd /work; cp key.pem cert.pem; cat ca.pem >> cert.pem; awk 1 ORS='\\n' cert.pem > cert.haproxy; cat cert.haproxy"