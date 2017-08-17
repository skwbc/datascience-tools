FROM ubuntu:16.04
MAINTAINER Shota Kawabuchi <shota.kawabuchi+git@gmail.com>

RUN set -x && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    libatlas-base-dev \
    libopencv-dev \
    wget \
    git \
    vim \
    libgtk2.0 && \
  apt-get clean && \
  wget https://repo.continuum.io/archive/Anaconda3-4.1.1-Linux-x86_64.sh && \
  bash Anaconda3-4.1.1-Linux-x86_64.sh -b && \
  rm Anaconda3-4.1.1-Linux-x86_64.sh

ENV PATH /root/anaconda3/bin:$PATH
RUN set -x && \
  conda install -c menpo opencv3 -y && \
  conda install graphviz jupyter seaborn -y && \
  conda install -c conda-forge pymc3 -y && \
  conda install -c conda-forge librosa -y && \
  pip install \
    fastFM \
    graphviz \
    line_profiler \
    memory_profiler && \
  pip install "https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp35-cp35m-linux_x86_64.whl"

# xgboost
RUN set -x && \
  git clone --recursive https://github.com/dmlc/xgboost && \
  cd xgboost; make -j4 && \
  cd python-package; python setup.py install

COPY jupyter_notebook_config.py /root/.jupyter/
COPY matplotlibrc /root/.config/matplotlib/

# TensorBoard
EXPOSE 6006

# Jupyter Notebook
EXPOSE 8888

RUN mkdir /workspace
VOLUME /workspace
VOLUME /mnt
WORKDIR /workspace
