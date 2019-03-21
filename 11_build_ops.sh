source 0_set_variables.sh

mv $DENSEPOSE_DIR/CMakeList.txt $DENSEPOSE_DIR/CMakeList.txt.original
cp -v CMakeList.txt $DENSEPOSE_DIR/CMakeList.txt

cd $DENSEPOSE_DIR
make ops
