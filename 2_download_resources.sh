source 0_set_variables.sh

DENSEPOSE_LINK="https://github.com/facebookresearch/DensePose.git"
COCOAPI_LINK="https://github.com/cocodataset/cocoapi.git"
PROTOBUF350_LINK="https://github.com/protocolbuffers/protobuf/releases/download/v3.5.0/protobuf-all-3.5.0.tar.gz"
GCC492_LINK="https://ftp.gnu.org/gnu/gcc/gcc-4.9.2/gcc-4.9.2.tar.gz"

git clone $DENSEPOSE_LINK $DENSEPOSE_DIR
git clone $COCOAPI_LINK $COCOAPI_DIR

wget $PROTOBUF350_LINK -P $CACHE_DIR -timeout 5 -t 999999
wget $GCC492_LINK -P $CACHE_DIR -timeout 5 -t 999999

echo "extracting protobuf"
tar -zxf $CACHE_DIR/protobuf-all-3.5.0.tar.gz -C $PROTOBUF_DIR
echo "extracting protobuf"
tar -zxf $CACHE_DIR/gcc-4.9.2.tar.gz -C $GCC_DIR
