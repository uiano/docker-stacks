# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER
ARG PYTHON_VERSION=3.7

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Install Tensorflow
RUN python3.7 -m pip install --quiet --no-cache-dir \
    'tensorflow==1.15.3' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
