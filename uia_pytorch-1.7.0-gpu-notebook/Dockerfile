ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="bendik dyrli bendik.dyrli@uia.no"

USER root

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

RUN touch /home/$NB_USER/.fidje && \
  echo "Bendik i Tårnet" >> /home/$NB_USER/.fidje

# Install PyTorch
RUN pip install --quiet --no-cache-dir \
  'torch' 'torchvision' 'nltk' 'torchsummary' && \
  pip uninstall jedi --yes && \
  fix-permissions $CONDA_DIR && \
  fix-permissions /home/$NB_USER