This repository contains the base image to use to run a docker-compose application on Koyeb.

## Usage

Let's say you have a GitHub repository containing a `docker-compose.yml` file that you want to deploy on Koyeb. Your application could be the example application from the [docker-compose documentation](https://docs.docker.com/compose/gettingstarted/).

First, add a new file `Dockerfile.koyeb` with the following content in your repository:

```
FROM koyeb/docker-compose

COPY . /app
```

### Deploy with the control panel

To deploy your service using the [control panel](https://app.koyeb.com/), follow these steps:

* Create a new service on Koyeb.
* Select the deployment method "GitHub".
* Select your repository, and choose the builder "Dockerfile"
* From the "build and deployment settings", set **`Dockerfile.koyeb` as the Dockerfile location**, and **set the flag `Privileged`**.
* From the section "Exposing your service", add the port of your application. This is important, otherwise the application will not become healthy and will not be exposed.
* Create the service!


### Deploy with the CLI

To deploy your service using the [Koyeb CLI](https://github.com/koyeb/koyeb-cli), follow these steps:

Create a new application:

```bash
$ koyeb app create my-compose-app
```

Create a new service:

```bash
$ koyeb service create my-compose-service \
    --app my-compose-app \
    --git github.com/<owner>/<repo> \
    --git-branch master \
    --git-builder docker \
    --git-docker-dockerfile Dockerfile.koyeb \
    --privileged \
    --port 8000 \
    --route /:8000
```

* Replace `<owner>` and `<repo>` with the owner and the name of your GitHub repository.
* Set the port and the route according to your application.
