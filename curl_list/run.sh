#!/bin/bash

PERF_OUTPUT=data/
echo "[+] Delete users..."
#/usr/bin/time -f "%e" -a sh perf-delete-users.sh
echo "[+] Delete users done"
sleep 1

echo "[+] Create users..."
#/usr/bin/time -f "%e" -a sh perf-create-users.sh
echo "[+] Create users done"
sleep 1


echo "[+] User Login GET token..."
#sh curl.sh >zongzongming.json

rm ${PERF_OUTPUT}user_token.json
#sh curl_admin.sh >${PERF_OUTPUT}admin_token.json
#python checkout_toekn_admin.py
/usr/bin/time -f "%e" -a sh curl_user.sh >>${PERF_OUTPUT}user_token.json
echo "[+] User Login GET token done"
sleep 1

python checkout_toekn_user.py



echo "[+] Validata tokens..."
/usr/bin/time -f "%e" -a sh curl_user_validate.sh
