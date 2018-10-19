# AEM Docker 

## Prerequisites

### Docker

Make sure you have Docker installed on your system.

* [Docker for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)
* [Docker for Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows)

### Build Files

The following files are required, but are not included in the repository. Copy them into the project before building the images.

* files/cq-6.3.0-quickstart.jar
* files/license.properties

---

## Setup

### Environment

Create a copy of the `.env.sample` file named `.env`. It configures the environment to prevent a timeout issue on initial service startup.

### Build Images

First build the AEM base image. It's used as the starting point when building the author and publish images. Then build the service images configured in docker-compose.

```sh
# Build AEM base image
docker build -t aem-base:6.3 .

# Build service images (author, publish, dispatcher)
docker-compose build
```

---

## Dev Workflow

Images only need to be built once. Docker uses them to create and start services (containers) that run the AEM instances. If the image configuration changes, then they would need to be rebuilt, but for a normal daily workflow, all that is needed is to start/stop services.

The services configured in this project are:

* aem-author
* aem-publish
* dispatcher

### Start Services

With a single command, you can create and start all the services in the stack. Alternatively if you only need to run the author instance, you can start it on its own.

```sh
# Creates and starts services
docker-compose up

# Creates and starts a single service
docker-compose up aem-author
```

### Stop Services

And with another command, all the services can be stopped.

```sh
# Stop and remove running services
docker-compose down
```

### Useful Docker Commands

```sh
# List containers
docker-compose ps

# Start services in a background process
docker-compose up -d

# View and follow service logs
# Optionally specify a service
docker-compose logs -f [service-name]

# Open a bash terminal inside the `aem-author` container
docker-compose exec aem-author bash

# Stop services without removing them
# Optionally specify a service
docker-compose stop [service-name]

# Start services that have not been removed
# Optionally specify a service
docker-compose start [service-name]
```

Full documentation can be found on the [docker-compose CLI reference](https://docs.docker.com/compose/reference/overview/).

---

## Troubleshooting

**HTTP timeouts when starting the services for the first time**

Data volumes have been configured for both author and publish instances. When you first run `docker-compose up`, Docker has to create these volumes and copy their contents from the image to the host filesystem. This is close to 4GB of data and can cause a timeout in the startup process.

Make sure the `.env` file is in the project root and it has a suitable `COMPOSE_HTTP_TIMEOUT` value. See the `.env.sample` file for reference

**A service exits with code 137**

This indicates that the process was stopped by an OOM killer, which means the container ran out of memory.

In *Docker > Preferences > Advanced*, increase the memory available to Docker.
