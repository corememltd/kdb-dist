[kdb+](https://kx.com) Conda Distribution.

## Related Links

 * [https://www.anaconda.com](Anaconda)

# Build

Follow the OS specific instructions below and then run:

    conda install -y conda-build conda-verify`
    cd /path/to/project/kdb-dist
    conda build conda
    conda install -y -f --use-local kdb

## Linux and macOS

You will need to have installed [Miniconda](https://conda.io/miniconda.html).

Users of [Docker instead can use](https://hub.docker.com/r/continuumio/miniconda3/):

    docker run -it -v $(pwd):/usr/src/kdb-dist continuumio/miniconda3

## Windows

You will need to have installed [Visual Studio (Community edition suffices)](https://visualstudio.microsoft.com/vs/).  Alternatively [Microsoft make available a developer VM](https://developer.microsoft.com/en-us/windows/downloads/virtual-machines) that contains this.

You will need to have installed [Miniconda](https://conda.io/miniconda.html).

For the terminal, you open the Start Menu and search for 'Anaconda Prompt'.

If you are using VS 2017, before you start the build you need to run:

    "\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
