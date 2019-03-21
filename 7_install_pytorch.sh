source 0_set_variables.sh
conda install pytorch==1.0.0 cudatoolkit=9.0 cudnn -y
ln -s $TORCH_DIR/lib $DENSEPOSE_DIR/lib