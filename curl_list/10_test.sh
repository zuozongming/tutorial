curl -i \
  -H "Content-Type: application/json" \
  -d '
{ "auth": {
    "identity": {
      "methods": ["token"],
      "token": {
        "id": "54be9cd1664c4d1780d2274675412555"
      }
    }
  }
}' \
  http://127.0.0.1:35357/v3/auth/tokens ; echo

