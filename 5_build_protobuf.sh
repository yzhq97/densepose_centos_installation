source 0_set_variables.sh

cd $PROTOBUF_DIR
mkdir build
cd build
../configure --prefix=$PROTOBUF_DIR/build CXXFLAGS="-fPIC"
make -j16
make install

cp -v bin/protoc "$CONDA_ENV_DIR/bin"
cp -rv include/google "$CONDA_ENV_DIR/include"
cp -v lib/libproto* "$CONDA_ENV_DIR/lib"

cd $PROTOBUF_DIR/python
python2 setup.py build
python2 setup.py install