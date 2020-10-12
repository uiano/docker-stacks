# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="bendik dyrli bendik.dyrli@uia.no"

# Try to avoid cache while testing
# ARG CACHEBUST=1

# Lets start with getting the time correct
ENV TZ=Europe/Oslo
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER root

#https://docs.ray.io/en/latest/installation.html
#https://spinningup.openai.com/en/latest/user/installation.html#installing-spinning-up

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID


# Install Spinningup
RUN conda create -n spinningup python=3.6 && \
    conda activate spinningup

# Install Packages from APT !
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libopenmpi-dev && \
    git clone https://github.com/openai/spinningup.git && \
    cd spinningup && \
    pip install --no-cache-dir -e . && \
    pip install --quiet --no-cache-dir \
    ray[rllib]  && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER