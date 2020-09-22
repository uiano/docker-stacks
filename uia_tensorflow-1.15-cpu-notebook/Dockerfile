# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER
ARG PYTHON_VERSION=3.7
ARG PIP_VERSION=3


LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# Install all OS dependencies for TensorRT + PYTHON3.7
RUN apt-get update && apt-get install -yq --no-install-recommends \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt install -yq --no-install-recommends \
    python${PYTHON_VERSION}  \
    python${PIP_VERSION}-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Install Tensorflow
RUN pip${PIP_VERSION} install --no-cache-dir --quiet \
    'tensorflow==1.15.3' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
