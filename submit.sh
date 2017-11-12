#!/bin/sh
### General options
### –- specify queue --
#BSUB -q gpuqueuetitanx
### -- set the job Name --
#BSUB -J bridge
### -- ask for number of cores (default: 1) --
#BSUB -n 8
### -- Select the resources: 2 gpus in exclusive process mode --
#BSUB -R "rusage[ngpus_excl_p=1]"
### -- set walltime limit: hh:mm --
#BSUB -W 16:00
### -- set the email address --
# please uncomment the following line and put in your e-mail address,
# if you want to receive e-mail notifications on a non-default address
#BSUB -u kendixd@gmail.com
### -- send notification at start --
#BSUB -B
### -- send notification at completion--
#BSUB -N
### -- Specify the output and error file. %J is the job-id --
### -- -o and -e mean append, -oo and -eo mean overwrite --
#BSUB -o hpc_messages/gpu-%J.out
#BSUB -e hpc_messagesgpu_%J.err
### -- small workaround -- no comment ;)
#BSUB -L /bin/bash
# -- end of LSF options --

# -- run in the current working (submission) directory --
if test X$PBS_ENVIRONMENT = XPBS_BATCH; then cd $PBS_O_WORKDIR; fi
# here follow the commands you want to execute

#nvidia-smi

# Load required modules
module load numpy/1.11.2-python-2.7.12-openblas-0.2.15_ucs4
module load scipy/scipy-0.18.1-python-2.7.12_ucs4
module load cudnn/v6.0-prod

# Activate the already installed virtual environment
source ~/.local/bin/virtualenvwrapper.sh
workon bridge

cd ~/src/Keras-FCN/
# Execute the python script with linked c compilers
# Following example from /appl/tensorflow/how_to_tf1.1gpu
echo "execfile('train.py')" | /appl/glibc/2.17/lib/ld-linux-x86-64.so.2  --library-path /appl/glibc/2.17/lib/:/appl/gcc/4.8.5/lib64/:/lib64:/usr/lib64:$LD_LIBRARY_PATH $(which python)
# Test line
# echo "import tensorflow" | /appl/glibc/2.17/lib/ld-linux-x86-64.so.2  --library-path /appl/glibc/2.17/lib/:/appl/gcc/4.8.5/lib64/:/lib64:/usr/lib64:$LD_LIBRARY_PATH $(which python)
