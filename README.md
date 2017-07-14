# Value Set Workbench Docker Installation
The Value Set Workbench includes a [Docker Compose](https://docs.docker.com/compose/)-based system for deploying the suite of tools comprising the Value Set Workbench.

## Before You Begin
The Value Set Workbench requires minimal dependencies to install, but is dependent on having a running [Docker](https://docs.docker.com/) installation. Ensure you have the following perquisites installed:

* [Docker](https://docs.docker.com/engine/installation/) >= 1.12.0
* [docker-compose](https://docs.docker.com/compose/install/) >= 1.8.0

Specific Docker installation instructions can be found for [Mac OSX](https://docs.docker.com/docker-for-mac/install/), [MS Windows 10](https://docs.docker.com/docker-for-windows/install/), and a variety of [cloud](https://docs.docker.com/engine/installation/#cloud) and [Linux server](https://docs.docker.com/engine/installation/#server) configurations.

The following components will be installed as Docker containers:

* [valueset-workbench](https://github.com/valuesetworkbench/valueset-workbench) - The Value Set Workbench web-based user interface.
* [arangodb-service](https://github.com/valuesetworkbench/arangodb-service) - A [CTS2-compliant](http://www.omg.org/spec/CTS2/) terminology service.
* [valueset-standardizer](https://github.com/valuesetworkbench/valueset-standardizer) - An automated value set standardization service.
* [valueset-automap](https://github.com/valuesetworkbench/valueset-automap) - An automated value set mapping service.
* An [Elasticsearch](https://www.elastic.co/products/elasticsearch) service.
* An [ArangoDB](https://www.arangodb.com/) graph database.


## Installation Steps (Quick Start)

* [x] ***Download the Installer.*** If you have [Git](https://git-scm.com/book/id/v2/Getting-Started-Installing-Git) installed, you can clone the latest Docker installation scripts:
```
git clone https://github.com/valuesetworkbench/valueset-workbench-docker.git
```

Or [download the zip](https://github.com/valuesetworkbench/valueset-workbench-docker/archive/master.zip) if you don't have Git installed.

!!! info
    Downloading and unzipping the above zip file will result in a directory called ```valueset-workbench-docker-master```. To align with further instructions below, rename that directory to ```valueset-workbench-docker```.


* [x] ***Execute the Installation Script.***
```
cd valueset-workbench-docker
./start.sh (for Mac/Linux)
./start.bat (for Windows)
```

!!! warning
    This Quick Start installations should be used for local workstation installations only! This will generate a self-signed certificate and leave the admin username/password set to the default (```admin/admin```). For more secure installation options, see below.

By default, when started the Value Set Workbench will be available at ```https://localhost/```. For a Mac, the service will be available at IP address the Docker Machine. You can find this address by running ```docker-machine ip```.

## Installation Steps (Customized)
An installation may be tailored in several ways by either introducing new files or adding parameters to the ```./start.sh``` script. These options are described below

### External Host Name    
If you are deploying the Value Set Workbench in a production environment, you may need to tell it the hostname where it will be accessed. This is necessary for several functions including OAuth2 callbacks.

You may sepecify an external host via the ```start.sh``` script:
```
./start.sh -h yourhost.com
```

If you do not provide an external host parameter, default behaviour depends on the deployment operating system:

* **Linux** - ```$HOST```
* **OSX** - the result of ```docker-machine ip```
* **Windows** - ```%COMPUTERNAME%```

### Custom Admin Password    
By default, a new installation of the Value Set Workbench comes installed with an administator account loaded. This account by default has the username/password: ```admin/admin```

The admin account password may be randomized on install:
```
./start.sh/bat -r
```
 
The ```-r``` option sets the admin password to a randomized string. The output text of ```start.sh``` will display the password that it has generated:

```
Value Set Workbench is starting at https://192.168.99.100/
 * NOTE: Service may take a few minutes to start.
Admin username/password: admin/VIw9+mNh+KRs8KqCp^eftaqSD03Hop%N
```

### Custom OAuth2
The Value Set Workbench allows integrates with your existing OAuth2 strategy. See [here for details](custom_oauth).

### Custom Terms/Privacy Statements
Customized Terms of Use and Privacy statements are may be added to align with different institutional policies. To substitute custom versions of these files, add either a ```terms.txt``` or ```privacy.txt``` (or both) to the ```valueset-workbench-docker/valueset-workbench/policy``` directory. These files may be in plain-text or [Markdown](https://daringfireball.net/projects/markdown/syntax) format.

### Custom SSL
By default, the Value Set Workbench will deploy with a self-signed SSL certificate. To use your own, place your custom Private Key and Certificate in the following locations:

* **Private key:** ```valueset-workbench-docker/ssl/key.pem```
* **Certificate:** ```valueset-workbench-docker/ssl/ca.pem```

