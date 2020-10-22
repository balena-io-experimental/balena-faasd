# faasd Balena app

This repo contains the Balenified [faasd](https://github.com/openfaas/faasd) application. 


**Limitations**

* The current version uses a containerized `containerd` daemon. A version that uses the engine containerd daemon is in progress
* Only works on balenaOs Rpi4 64biy, since it requires the `overlayfs` module and we only include it that version


## Running the tests

The repo includes a simple testing script that tests all the basic `faaad` functionalities:

* Login to faasd
* Deployment of applications from the store
* Sync functions
* Async functions
* Custom function deployment (it deploys the `kaisoz/hello-world-faasd:latest` function)
* Custom function sync invocation

In order to run this tests:

1. `curl -sLfS https://cli.openfaas.com | sudo sh`
2. Deploy the Balena app. The password will be shown in the last line of the logs
3. Run `test/run_tests. PASSWORD`

**CAVEAT:** The script does not check the results automatically, you have to make sure all worked properly

The test version also includes the source code of the custom function (`test/hello-world-node` and `test/hello-world-node.yml`, as well as its conversion to a Docker project (`test/build`).
