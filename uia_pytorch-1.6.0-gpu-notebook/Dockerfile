# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="bendik dyrli bendik.dyrli@uia.no"

USER root

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Install PyTorch
RUN pip install --quiet --no-cache-dir \
    'torch==1.6.0' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
