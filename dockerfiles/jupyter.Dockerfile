# NVIDIA CUDA image as a base
# We also mark this image as "jupyter-base" so we could use it by name
FROM nvidia/cuda:11.1-runtime AS jupyter-base

# tzdata fix
ENV TZ=Asia/Dubai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /
# Install Python and its tools
RUN apt update && apt install -y --no-install-recommends \
    git \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-opencv
RUN pip3 -q install pip --upgrade
# Install all basic packages
RUN pip3 install \
    # Jupyter itself
    jupyter \
    # Numpy and Pandas are required a-priori
    numpy pandas \
    # PyTorch with CUDA 10.2 support and Torchvision
    torch torchvision \
    # Upgraded version of Tensorboard with more features
    tensorboardX

# Here we use a base image by its name - "jupyter-base"
FROM jupyter-base
# Install additional packages
RUN pip3 install \
    # Hugging Face Transformers
    transformers \
    # Progress bar to track experiments
    barbar
# Install additional libs
RUN pip3 install \
    sklearn \
    opencv-python \
    matplotlib