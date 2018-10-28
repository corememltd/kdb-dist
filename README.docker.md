[kdb+](https://kx.com) Docker Distribution.

## Issues

 * Until this project is moved to `KxSystems`, you need to replace `kxsys/kdb` with `coremem/kdb`, including in the `gce.metadata.user-data` file

## Related Links

 * [Docker](https://docker.com)
     * [Google - Deploying Containers on VMs and Managed Instance Groups](https://cloud.google.com/compute/docs/containers/deploying-containers)

# Usage

You should be able to run:

    docker run --rm -it kxsys/kdb

You can drop straight into `bash` with:

    docker run --rm -it kxsys/kdb bash

Lastly you can pipe your program in (or look to [`Q_INIT`](#headless) below):

    $ echo 3+3 | docker run --rm -i kxsys/kdb q -q
    6

## Headless

You can use [environment variables](https://docs.docker.com/engine/reference/run/#env-environment-variables) (or [instance or project level metadata for GCE](https://cloud.google.com/compute/docs/storing-retrieving-metadata)) to handle any interactive component of starting the container.

 * **`Q_INIT`:** [base64 encoded](https://en.wikipedia.org/wiki/Base64) [`tar`](https://en.wikipedia.org/wiki/Tar_(computing)) ([`gzip`](https://en.wikipedia.org/wiki/Gzip) supported) or [`zip`](https://en.wikipedia.org/wiki/Zip_(file_format)) file that will be extracted to `HOME` and will [automatically begin executing `q.q` if present](https://www.kdbfaq.com/how-can-i-have-kdb-automatically-load-q-code-at-startup-in-every-session/)
     * as inside the container [`QLIC=$HOME`](https://code.kx.com/q/tutorials/licensing/#keeping-the-license-key-file-elsewhere) you may include your `kc.lic` (or `k4.lic`) file
         * it is recommended to use [`QLIC_KC`](#on-demand-license) or [`QLIC_K4`](#commercial-license) so to decouple the licensing from your codebase
     * your upper limit for your `Q_INIT` is something short of the output from `getconf ARG_MAX` (inclusive of the base64 encoding overhead)
         * [GCE limits you to 256kB of metadata](https://cloud.google.com/compute/docs/storing-retrieving-metadata#custom_metadata_size_limitations)
         * [AWS limits you to 16kB of metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html#instancedata-add-user-data)

If your project code lives in the directory `mycode`, this lets you invoke `q` using:

    docker run --rm -it -e Q_INIT=$(tar -C mycode -c . | gzip -9 | openssl base64 -e -A) kxsys/kdb

Alternatively, if your project code lives in a ZIP file called `mycode.zip`:

    docker run --rm -it -e Q_INIT=$(openssl base64 -e -A -in mycode.zip) kxsys/kdb

### Google Cloud Engine

**N.B.** on-demand is not permitted for use on a third party cloud provider's computer as per the [license agreement](https://ondemand.kx.com/)

An example of [running a Docker container on a GCE instance](https://cloud.google.com/container-optimized-os/docs/how-to/run-container-instance#starting_a_docker_container_via_cloud-config) is as follows using the [`gce.metadata.user-data`](gce.metadata.user-data) included in this project:

    gcloud compute --project=MYPROJECT instances create kdb \
    	--zone=europe-west1-b --machine-type=f1-micro \
    	--metadata-from-file=user-data=gce.metadata.user-data \
    	--metadata=QLIC_K4=$(openssl base64 -e -A -in k4.lic) \
    	--image=family/cos-stable --image-project=cos-cloud

The metadata supplied can also be set at the project level rather than instance.

### License

#### On-demand

**N.B.** on-demand is not permitted for use on a third party cloud provider's computer as per the [license agreement](https://ondemand.kx.com/)

The following is supported:

 * **`QLIC_KC`:** base64 encoded contents of your `kc.lic` file

This lets you invoke `q` using:

    docker run --rm -it -e QLIC_KC=$(openssl base64 -e -A -in "$QHOME/kc.lic") kxsys/kdb

#### Commercial

The following is supported:

 * **`Q_USER` (default: `kx`):** username inside the container in which to run `q`
 * **`QLIC_K4`:** base64 encoded contents of your `k4.lic` file

To amend the hostname of the container, you should use the [`h` parameter](https://docs.docker.com/engine/reference/run/#uts-settings---uts) as follows:

    docker run --rm -it -h myhostname ...

# Build

The instructions below are for building your own Docker image. A pre-built Docker image is available on Docker Cloud, if you only want to run the `q` image then you should read ignore this section and follow the [pre-flight](#pre-flight) and [usage](#usage) sections above on how to do this.

You will need [Docker installed](https://www.docker.com/community-edition) on your workstation; make sure it is a recent version.

To build locally, run from within the project:

    docker build -t kdb -f docker/Dockerfile .

Once built, you should have a local `kdb` image, you can run the following to use it:

    docker run --rm -it kdb
