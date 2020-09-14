#!/usr/bin/env bash

red=$'\e[1;31m'
green=$'\e[1;32m'
normal=$'\e[0m'

REG=urr.uia.no
CUDA_10_0=nvidia_cuda_10.0-cudnn7-devel
CUDA_10_1=nvidia_cuda_10.1-cudnn7-devel
CUDA_10_2=nvidia_cuda_10.2-cudnn7-devel

building_func_name(){
    echo "$green === Building ${FUNCNAME[1]} ===$normal" >&2
}

cd_up(){
    cd ..
}

base_notebook(){
    # Build base-notebook
    building_func_name
    cd ./base-notebook
    docker build -t $REG/jupyter/base-notebook .
    docker build -t $REG/jupyter/base-notebook:$CUDA_10_0 --build-arg BASE_CONTAINER=nvidia/cuda:10.0-cudnn7-devel .
    docker build -t $REG/jupyter/base-notebook:$CUDA_10_1 --build-arg BASE_CONTAINER=nvidia/cuda:10.1-cudnn7-devel .
}

minimal_noteboot(){
    # Build minimal-notebook
    building_func_name
    cd ./minimal-notebook
    docker build -t $REG/jupyter/minimal-notebook --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook .
    docker build -t $REG/jupyter/minimal-notebook:$CUDA_10_0 --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook:$CUDA_10_0 .
    docker build -t $REG/jupyter/minimal-notebook:$CUDA_10_1 --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook:$CUDA_10_1 .
}

scipy_notebook(){
    # Build scipy-notebook
    building_func_name
    cd ./scipy-notebook
    docker build -t $REG/jupyter/scipy-notebook --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook .
    docker build -t $REG/jupyter/scipy-notebook:$CUDA_10_0 --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook:$CUDA_10_0 .
    docker build -t $REG/jupyter/scipy-notebook:$CUDA_10_1 --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook:$CUDA_10_1 .
}

tensorflow_1.15_cpu(){
    # Build tensorflow-v1-notebook
    building_func_name
    cd ./tensorflow-v1-notebook
    docker build -t $REG/jupyter/tensorflow-v1-notebook --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook .
}

tensorflow_1.15_gpu(){
    # Build tensorflow-v1-gpu-notebook
    building_func_name
    cd ./tensorflow-v1-gpu-notebook
    docker build -t $REG/jupyter/tensorflow-v1-gpu-notebook:$CUDA_10_0 --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook:$CUDA_10_0 .
}

tensorflow_2.3_cpu(){
    # Build tensorflow-v2-notebook
    building_func_name
    cd ./tensorflow-v2-notebook
    docker build -t $REG/jupyter/tensorflow-v2-notebook --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook .
}

tensorflow_2.3_gpu(){
    # Build tensorflow-v2-gpu-notebook
    building_func_name
    cd ./tensorflow-v2-gpu-notebook
    docker build -t $REG/jupyter/tensorflow-v2-gpu-notebook:$CUDA_10_1 --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook:$CUDA_10_1 .
}

### MAIN
base_notebook
cd_up

minimal_noteboot
cd_up

scipy_notebook
cd_up

tensorflow_1.15_cpu
cd_up

tensorflow_1.15_gpu
cd_up

tensorflow_2.3_cpu
cd_up

tensorflow_2.3_gpu
cd_up