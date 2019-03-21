# manually set these variables
DENSEPOSE_DIR="$HOME/densepose" # The place where you want to install DensePose
CONDA_ENV_NAME="densepose" # The name of your anaconda environment
CUDA_DIR="/mnt/lustre/share/cuda-9.0" # path to your cuda installation directory

# these variables are automatically created
CONDA_ENV_DIR="$HOME/anaconda3/envs/$CONDA_ENV_NAME"
CACHE_DIR="$DENSEPOSE_DIR/installation/cache"
COCOAPI_DIR="$DENSEPOSE_DIR/installation/cocoapi"
PROTOBUF_DIR="$DENSEPOSE_DIR/installation/protobuf-3.5.0"
GCC_DIR="$DENSEPOSE_DIR/installation/gcc-4.9.2"
TORCH_DIR="$CONDA_ENV_DIR/lib/python2.7/site-packages/torch"
