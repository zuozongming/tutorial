#!/bin/sh
while read USER_TOKEN;do 
    echo $USER_TOKEN
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
      http://127.0.0.1:5000/v3/auth/tokens ; echo
done < data/user_token.txt
