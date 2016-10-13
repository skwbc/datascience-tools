FROM ubuntu:16.04
MAINTAINER Shota Kawabuchi <shota.kawabuchi+github@gmail.com>

RUN set -x && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    wget \
    git \
    vim \
    libgtk2.0 && \
  apt-get clean && \
  wget https://repo.continuum.io/archive/Anaconda3-4.1.1-Linux-x86_64.sh && \
  bash Anaconda3-4.1.1-Linux-x86_64.sh -b && \
  rm Anaconda3-4.1.1-Linux-x86_64.sh

ENV PATH /root/anaconda3/bin:$PATH

RUN set -x &&\
  conda install -c https://conda.binstar.org/menpo opencv3 -y && \
  conda install -c conda-forge tensorflow -y && \
  conda install jupyter -y

COPY jupyter_notebook_config.py /root/.jupyter/

# TensorBoard
EXPOSE 6006 

# Jupyter Notebook
EXPOSE 8888 

RUN mkdir /workspace
VOLUME /workspace
VOLUME /mnt
WORKDIR /workspace
