curl -i \
  -H "Content-Type: application/json" \
  -d '
{ "auth": {
    "identity": {
      "methods": ["token"],
      "token": {
        "id": "4f7520f84de842ea9ceb2354568bc090"
      }
    }
  }
}' \
  http://127.0.0.1:35357/v3/auth/tokens ; echo

