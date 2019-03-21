# DensePose installation with CentOS 7 and Anaconda built Caffe2

[@linkinpark213](https://github.com/linkinpark213) figured out how to install `DensePose` on `CentOS 7` with `Anaconda` in this brilliant [blog post](http://linkinpark213.com/2018/11/18/densepose-minesweeping/). He is the Sherlock Holmes. [@Johnqczhang](https://github.com/Johnqczhang) wrote this brilliant [tutorial](https://github.com/Johnqczhang/densepose_installation). This repository follows their instructions. These shell scripts help speed up the installation process. Especially when you fail, it saves time if you start over.

## Who may use this, and why?

* wants to install DensePose (obviously)
* your computer/server/cluster uses `CentOS 7` operation system 
* don't want to compile `Caffe2` yourself and would like to install `Caffe2` from `Anaconda`

You will fail if you follow the official [installation guide](https://github.com/facebookresearch/DensePose/blob/master/INSTALL.md). The problems are that:

* Although it is stated on the official `Caffe2` [installation guide](https://caffe2.ai/docs/getting-started.html?platform=mac&configuration=prebuilt) that simply running `conda install pytorch-nightly -c pytorch` "will install Caffe2 and _all of its required dependencies_ into the current conda environment", it won't. 
* `DensePose` uses some customized operations that needs to be manually compiled. However, the `Caffe2` you installed from `Anaconda` (with pytorch 1.0.0) was originally built with `gcc-4.9.2` and `protobuf-3.5.0`. You need to compile the customized operations with `gcc-4.9.2` and `protobuf-3.5.0`, otherwise they won't work.
* `gcc-4.9.2` and `protobuf-3.5.0` are not available from `Anaconda`.

## Environment

My environment:
* CentOS 7.2 cluster
* GTX 1080ti GPU
* Nvidia driver 384.98
* CUDA 9.0
* CuDNN 7.3.1 (installed from `Anaconda`)
* Anaconda 4.6.8
* Python 2.7.15 (installed from `Anaconda`)

## How to use ?

### 0. set up some variables

In `0_set_variables.sh`, you need to specify the anaconda environment name and where you would like to install `DensePose`. It's okay to use default values. It installs `DensePose` under your `$HOME/densepose` by default.

```bash
DENSEPOSE_DIR="$HOME/densepose" # The place where you want to install DensePose
CONDA_ENV_NAME="densepose" # The name of your anaconda environment
CUDA_DIR="/mnt/lustre/share/cuda-9.0" # path to your cuda installation directory
```

In `CMakeList.txt`, you need to specify the path to your `Anaconda` environment.
```cmake
set(CONDA_ENV_DIR "/mnt/lustre/yangzhuoqian/anaconda3/envs/densepose")
```

### 1. create an anaconda environment with the name you specified, and activate it.

You can just run `sh 1_create_conda_environment.sh`. It will create an environment with Python 2.7 and add the CUDA paths into the environment variables of this anaconda environment.

after this, activate the environment: `conda activate densepose` (if the name of your environment is `densepose`)

### 2. install dependencies; build gcc-4.9.2, protobuf-3.5.0 and cocoapi; install pytorch-1.0.0

```bash
sh 2_download_resources.sh
sh 3_install_dependencies.sh
sh 4_build_gcc492.sh
sh 5_build_protobuf.sh
sh 6_build_cocoapi.sh
sh 7_install_pytorch.sh
```
These scripts could take about an hour, or more.

### 3. test your pytorch and Caffe2 installation

```bash
sh 8_test_caffe2_import.sh
```
Expected output:
```
Success
4 # depends on the number of gpus in your system
```

### 4. build detectron and test

```bash
sh 9_build_detecron.sh
sh 10_test_detectron.sh
```
Expected test output:
```
[E init_intrinsics_check.cc:43] CPU feature avx is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
[E init_intrinsics_check.cc:43] CPU feature avx2 is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
[E init_intrinsics_check.cc:43] CPU feature fma is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
...
----------------------------------------------------------------------
Ran 3 tests in 8.237s

OK
```

### 5. build ops and test

```bash
sh 11_build_ops.sh
sh 12_test_ops.sh
```
This is where most people are stuck. Note that the `11_build_ops.sh` moves the modified `CMakeList.txt` into your `DensePose` directory, replacing the old one. If something reports wrong about `CMake`, you should probably modify your own `CMakeList.txt` from this [CMakeLists.txt](https://github.com/Johnqczhang/densepose_installation/blob/master/CMakeLists.txt)

If everything turns out right, you should see something like:
```
[E init_intrinsics_check.cc:43] CPU feature avx is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
[E init_intrinsics_check.cc:43] CPU feature avx2 is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
[E init_intrinsics_check.cc:43] CPU feature fma is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
............
----------------------------------------------------------------------
Ran 12 tests in 38.621s

OK
```

Phew, for a minute there, I lost myself.

## Acknowledgements

* Official [DensePose](https://github.com/facebookresearch/DensePose) repository
* [[MineSweeping] The Long Struggle of DensePose Installation](http://linkinpark213.com/2018/11/18/densepose-minesweeping/) by [@linkinpar213](https://github.com/linkinpark213), the one who figured it all out.
* The [real installation guide](https://github.com/Johnqczhang/densepose_installation) from [@Johnqczhang](https://github.com/Johnqczhang)
