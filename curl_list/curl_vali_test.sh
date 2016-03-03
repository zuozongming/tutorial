#!/bin/sh

unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
export OS_AUTH_URL=http://localhost:5000/v3.0
export OS_TENANT_NAME=demo
export OS_PASSWORD=nomoresecrete
export OS_USERNAME=admin
ADMIN_TOKEN=`sed -n "${num}p" data/admin_token.txt`
while read USER_TOKEN; do
    echo "X-Auth-Token:${ADMIN_TOKEN}" http://0.0.0.0:5000/v2.0/tokens/${USER_TOKEN} \
    #curl -I -H “X-Auth-Token: ${USER_TOKEN}″ http://0.0.0.0:35357/v2.0/tokens/${USER_TOKEN}


    #curl -H "X-Auth-Token:${ADMIN_TOKEN}" http://0.0.0.0:5000/v3.0/tokens/${USER_TOKEN} \
        #2>&1 | grep "issued_at" > /dev/null
        #2>&1 | grep "issued_at" > /dev/null
    if [ "$?" != 0 ]; then
        echo "Token validation failed"
        break
    fi
done < data/user_token.txt
