source 0_set_variables.sh

conda create -n $CONDA_ENV_NAME python=2.7 -y

cd $CONDA_ENV_DIR
mkdir -p ./etc/conda/activate.d
mkdir -p ./etc/conda/deactivate.d
echo "export PATH=$CUDA_DIR/bin:\$PATH" >> ./etc/conda/activate.d/env_vars.sh
echo "'export PATH=$CUDA_DIR/bin:\$PATH' added to env_vars.sh"
echo "export LD_LIBRARY_PATH=$CUDA_DIR/lib64:\$LD_LIBRARY_PATH" >> ./etc/conda/activate.d/env_vars.sh
echo "'export LD_LIBRARY_PATH=$CUDA_DIR/lib64:\$LD_LIBRARY_PATH' added to activate.d/env_vars.sh"
