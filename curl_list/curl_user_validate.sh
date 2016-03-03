#!/bin/sh
while read USER_TOKEN;do 
    curl -i \
      -H "Content-Type: application/json" \
      -d '
    { "auth": {
        "identity": {
          "methods": ["token"],
          "token": {
            "id": "'${USER_TOKEN}'"
          }
        }
      }
    }' \
      http://127.0.0.1:5000/v3/auth/tokens >data/uesr_token.list
    if [ "$?" != 0 ]; then
        echo "Token validation failed"
        break
    fi
done < data/user_token.txt
