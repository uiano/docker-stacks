#!/usr/bin/env bash

red=$'\e[1;31m'
green=$'\e[1;32m'
normal=$'\e[0m'

REG=urr.uia.no
CUDA_10_0=nvidia_cuda_10.0-cudnn7-devel
CUDA_10_1=nvidia_cuda_10.1-cudnn7-devel
CUDA_10_2=nvidia_cuda_10.2-cudnn7-devel
CUDA_11_0=nvidia_cuda_11.0-cudnn7-devel

building_func_name(){
    echo -e "\n$green   ===============================$normal"
    echo -e "$green      Building ${FUNCNAME[1]}    $normal" >&2
    echo -e "$green   ===============================$normal\n"
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
    docker build -t $REG/jupyter/base-notebook:$CUDA_10_2 --build-arg BASE_CONTAINER=nvidia/cuda:10.2-cudnn7-devel .
    #docker build -t $REG/jupyter/base-notebook:$CUDA_11_0 --build-arg BASE_CONTAINER=nvidia/cuda:11.0-cudnn7-devel .
    cd_up
}

minimal_noteboot(){
    # Build minimal-notebook
    building_func_name
    cd ./minimal-notebook
    docker build -t $REG/jupyter/minimal-notebook --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook .
    docker build -t $REG/jupyter/minimal-notebook:$CUDA_10_0 --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook:$CUDA_10_0 .
    docker build -t $REG/jupyter/minimal-notebook:$CUDA_10_1 --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook:$CUDA_10_1 .
    docker build -t $REG/jupyter/minimal-notebook:$CUDA_10_2 --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook:$CUDA_10_2 .
    #docker build -t $REG/jupyter/minimal-notebook:$CUDA_11_0 --build-arg BASE_CONTAINER=$REG/jupyter/base-notebook:$CUDA_11_0 .
    cd_up
}

scipy_notebook(){
    # Build scipy-notebook
    building_func_name
    cd ./scipy-notebook
    docker build -t $REG/jupyter/scipy-notebook --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook .
    docker build -t $REG/jupyter/scipy-notebook:$CUDA_10_0 --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook:$CUDA_10_0 .
    docker build -t $REG/jupyter/scipy-notebook:$CUDA_10_1 --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook:$CUDA_10_1 .
    docker build -t $REG/jupyter/scipy-notebook:$CUDA_10_2 --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook:$CUDA_10_2 .
    #docker build -t $REG/jupyter/scipy-notebook:$CUDA_11_0 --build-arg BASE_CONTAINER=$REG/jupyter/minimal-notebook:$CUDA_11_0 .
    cd_up
}


pytorch_1.7.0_cpu(){
    # Build pytorch-1.7.0-notebook
    building_func_name
    cd ./uia_pytorch-1.7.0-cpu-notebook
    docker build -t $REG/jupyter/pytorch-1.7.0-notebook --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook .
    cd_up
}

pytorch_1.7.0_gpu(){
    # Build pytorch-1.7.0-gpu-notebook
    building_func_name
    cd ./uia_pytorch-1.7.0-gpu-notebook
    docker build -t $REG/jupyter/pytorch-1.7.0-gpu-notebook:$CUDA_10_2 --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook:$CUDA_10_2 .
    #docker build -t $REG/jupyter/pytorch-1.7.0-gpu-notebook:$CUDA_11_0 --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook:$CUDA_11_0 .
    cd_up
}


tensorflow_1.15_cpu(){
    # Build tensorflow-v1-notebook
    building_func_name
    cd ./uia_tensorflow-1.15-cpu-notebook
    docker build -t $REG/jupyter/tensorflow-v1-notebook --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook .
    cd_up
}

tensorflow_1.15_gpu(){
    # Build tensorflow-v1-gpu-notebook
    building_func_name
    cd ./uia_tensorflow-1.15-gpu-notebook
    docker build -t $REG/jupyter/tensorflow-v1-gpu-notebook:$CUDA_10_0 --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook:$CUDA_10_0 .
    cd_up
}

tensorflow_2.3_cpu(){
    # Build tensorflow-v2-notebook
    building_func_name
    cd ./uia_tensorflow-2.3-cpu-notebook
    docker build -t $REG/jupyter/tensorflow-v2-notebook --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook .
    cd_up
}

tensorflow_2.3_gpu(){
    # Build tensorflow-v2-gpu-notebook
    building_func_name
    cd ./uia_tensorflow-2.3-gpu-notebook
    docker build -t $REG/jupyter/tensorflow-v2-gpu-notebook:$CUDA_10_1 --build-arg BASE_CONTAINER=$REG/jupyter/scipy-notebook:$CUDA_10_1 .
    cd_up
}

### MAIN
build(){
    base_notebook
    minimal_noteboot
    scipy_notebook
    tensorflow_1.15_cpu
    tensorflow_1.15_gpu
    tensorflow_2.3_cpu
    tensorflow_2.3_gpu
    pytorch_1.7.0_cpu
    pytorch_1.7.0_gpu
}

build
