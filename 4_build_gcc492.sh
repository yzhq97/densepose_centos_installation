source 0_set_variables.sh

cd $GCC_DIR
./contrib/download_prerequisites

mkdir build
cd build

../configure --prefix=$GCC_DIR/build --enable-checking=release --enable-languages=c,c++ --disable-multilib
make -j20
make install

ln -sv $GCC_DIR/build/bin/gcc $GCC_DIR/build/bin/cc
cp -rv $GCC_DIR/build/include/c++ $CONDA_ENV_DIR/include

cd $CONDA_ENV_DIR
mkdir -p ./etc/conda/activate.d
mkdir -p ./etc/conda/deactivate.d
echo "export PATH=$GCC_DIR/build/bin:\$PATH" >> ./etc/conda/activate.d/env_vars.sh
echo "'export PATH=$GCC_DIR/build/bin:\$PATH' added to env_vars.sh"
echo "export LD_LIBRARY_PATH=$GCC_DIR/build/lib64:\$LD_LIBRARY_PATH" >> ./etc/conda/activate.d/env_vars.sh
echo "export LD_LIBRARY_PATH=$GCC_DIR/build/lib64:\$LD_LIBRARY_PATH' added to activate.d/env_vars.sh"
