SERVER_HOST=$1

if [ -z "$1" ]
  then
    echo "No external facing host name was passed in."
    echo " - example: start.sh myhost.org"
    echo ""
    echo "Attempting to guess target host name."
    case "$(uname -s)" in

   Darwin)
     echo 'Found Mac OS X'
     echo '... setting hostname to `docker-machine ip`'
     SERVER_HOST="$(docker-machine ip)"
     ;;

   Linux)
     echo 'Found Linux'
     echo '... setting hostname to `$HOST`'
     SERVER_HOST=$HOST
     ;;

   *)
     echo 'Unknown OS'
     exit 1
     ;;
esac
fi

if [ ! -f ./ssl/cert.haproxy ]; then
    echo "HAProxy SSL cert not found."
    echo "... generating a self-signed cert."
    cd ssl
    sh make_self_signed_keys.sh
    sh make_ssl_cert.sh
    cd ..
fi

export SERVER_HOST=$SERVER_HOST
export EXTERNAL_URL=https://$SERVER_HOST
export DEFAULT_SSL_CERT="$(cat ./ssl/cert.haproxy)"
export ENV_FILE=./conf/config.env

docker-compose build --pull
docker-compose up -d

echo ""
echo "Value Set Workbench is starting at https://$SERVER_HOST/"
echo " * NOTE: Service may take a few minutes to start."
