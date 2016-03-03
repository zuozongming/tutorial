curl -i \
  -H "Content-Type: application/json" \
  -d '
{ "auth": {
    "identity": {
      "methods": ["password"],
      "password": {
        "user": {
          "name": "perf_testuser_0001",
          "domain": { "id": "default" },
          "password": "demopass"
        }
      }
    },
    "scope": {
      "project": {
        "name": "demo",
        "domain": { "id": "default" }
      }
    }
  }
}' \
  http://127.0.0.1:5000/v3/auth/tokens ; echo

