#!/bin/bash
set -e

cd /src/github.com/openfaas/faasd
faasd install

password=$(cat /var/lib/faasd/secrets/basic-auth-password)

echo "Password: $password"
echo "Now you can:"
echo "  * Login with: echo $password | fass-cli login -s"
echo "  * Run tests with: run_tests.sh $password"
