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
  'torch==1.7.0+cpu' 'torchvision==0.8.1+cpu' 'torchaudio==0.7.0' 'nltk' 'torchsummary' \
  -f https://download.pytorch.org/whl/torch_stable.html && \
  fix-permissions $CONDA_DIR && \
  fix-permissions /home/$NB_USER