#!/bin/bash
IP=
OPENFAAS_URL=http://${IP}:8080
CALLBACK_URL=
PASSWORD=$1

usage() {
    echo "Usage: run_tests.sh PASSWORD"
}


test -z "$PASSWORD" && usage && exit 1

echo -e "\n--> Login"
echo $PASSWORD | faas-cli login -s
echo && read -p "* Press Enter key to continue"

echo -e "\n--> Deploying figlet"
faas-cli store deploy --platform armhf figlet
echo && read -p "* Press Enter to continue"

echo -e "\n--> Testing sync functions using faas-cli"
echo "Balena" | faas-cli invoke figlet
echo && read -p "* Press Enter to continue"

echo -e "\n--> Deploying NodeInfo"
faas-cli store deploy --platform armhf nodeinfo
echo && read -p "* Press Enter to continue"

echo -e "\n--> Testing async functions"
curl -d "verbose" \
  ${OPENFAAS_URL}/async-function/nodeinfo \
  --header "X-Callback-Url: $CALLBACK_URL"
echo && read -p "* Check \"$CALLBACK_URL\" and press Enter to continue"

echo -e "\n--> Testing function deployment"
faas-cli deploy -f hello-world-node.yml
echo && read -p "* Press Enter to continue"

echo -e "\n--> Testing just deployed function using curl"
curl ${OPENFAAS_URL}/function/hello-world-node
echo && read -p "* Press Enter to continue"

