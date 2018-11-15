# AEM Docker

This project creates a base AEM image that can be used to make author and publish instances.

## Prerequisites

### Docker

Make sure you have Docker installed on your system.

* [Docker for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)
* [Docker for Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows)

### Build Files

The following files are required, but are not included in the repository. Copy them into the project before building the image.

* files/6.4/cq-6.4.0-quickstart.jar
* files/6.4/license.properties

---

## Build

Run the following build command in the project root.

```sh
# Build AEM base image
docker build -t aem-base:6.4 .
```
