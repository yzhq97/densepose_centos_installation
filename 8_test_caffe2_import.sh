python2 -c 'from caffe2.python import core' 2>/dev/null && echo "Success" || echo "Failure"
python2 -c 'from caffe2.python import workspace; print(workspace.NumCudaDevices())'
