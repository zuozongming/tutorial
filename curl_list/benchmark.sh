set -e
HOST=127.0.0.1
sh latest_curl_user.sh
ADMIN_TOKEN=`sed -n "${num}p" data/user_token_ben.txt`
SUBJECT_TOKEN=`sed -n "${num}p" data/user_token_ben.txt`
echo "Warming up Apache..."
ab -c 100 -n 1000 -T 'application/json' http://$HOST:35357/ > /dev/null 2>&1

echo "Benchmarking token creation..."
ab -r -c 1 -n 200 -p auth.json -T 'application/json' http://$HOST:35357/v3/auth/tokens > latest_create_token
if grep -q 'Non-2xx' latest_create_token; then
echo 'Non-2xx return codes! Aborting.'
fi


echo "Benchmarking token validation..."
ab -r -c 1 -n 10000 -T 'application/json' -H "X-Auth-Token: $ADMIN_TOKEN" -H "X-Subject-Token: $SUBJECT_TOKEN" http://$HOST:35357/v3/auth/tokens > latest_validate_token
if grep -q 'Non-2xx' latest_validate_token; then
echo 'Non-2xx return codes! Aborting.'
fi

echo "Benchmarking token creation concurrently..."
ab -r -c 100 -n 2000 -p auth.json -T 'application/json' http://$HOST:35357/v3/auth/tokens > latest_create_token_concurrent
if grep -q 'Non-2xx' latest_create_token_concurrent; then
  echo 'WARNING: Non-2xx return codes!'
fi

echo "Benchmarking token validation concurrency..."
ab -r -c 100 -n 100000 -T 'application/json' -H "X-Auth-Token: $ADMIN_TOKEN" -H "X-Subject-Token: $SUBJECT_TOKEN" http://$HOST:35357/v3/auth/tokens > latest_validate_token_concurrent
if grep -q 'Non-2xx' latest_validate_token_concurrent; then
  echo 'WARNING: Non-2xx return codes!'
fi
