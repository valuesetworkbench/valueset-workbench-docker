cp key.pem cert.pem
cat ca.pem >> cert.pem

awk 1 ORS='\\n' cert.pem > cert.haproxy