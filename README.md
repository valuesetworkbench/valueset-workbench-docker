# Value Set Workbench Docker Installation

*valueset-workbench-docker* is a [Docker Compose](https://docs.docker.com/compose/)-based system for deploying the suite to tools comprising the Value Set Workbench.

The following components will be installed:
* [valueset-workbench](https://github.com/valuesetworkbench/valueset-workbench) - The Value Set Workbench web-based user interface.
* [arangodb-service](https://github.com/valuesetworkbench/arangodb-service) - A [CTS2-compliant](http://www.omg.org/spec/CTS2/) terminology service.
* [valueset-standardizer](https://github.com/valuesetworkbench/valueset-standardizer) - An automated value set standardization service.
* [valueset-automap](https://github.com/valuesetworkbench/valueset-automap) - An automated value set mapping service.
* An [Elasticsearch](https://www.elastic.co/products/elasticsearch) service.
* An [ArangoDB](https://www.arangodb.com/) graph database.

## Prerequisites
* Docker >= 1.12.0 (https://docs.docker.com/engine/installation/)
* docker-compose >= 1.8.0 (https://docs.docker.com/compose/install/)

## Installation
```
git clone https://github.com/valuesetworkbench/valueset-workbench-docker.git
cd valueset-workbench-docker
./start.sh
```
By default, when started the Value Set Workbench will be available at https://localhost/



On a Mac, you will need to substitute ```localhost``` with the IP address the Docker Machine. You can find this address by running ```docker-machine ip```.

