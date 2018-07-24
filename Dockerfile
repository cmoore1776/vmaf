FROM ubuntu:16.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq
RUN apt-get install -y build-essential git

RUN apt-get install -y python python-setuptools python-dev python-tk \
  python-numpy python-scipy python-matplotlib python-sklearn \
  ipython ipython-notebook python-pandas python-sympy python-nose

RUN easy_install pip
RUN pip install scikit-image h5py

RUN git clone --depth 1 https://github.com/Netflix/vmaf.git vmaf
WORKDIR /vmaf
RUN git submodule update --init --recursive
ENV PYTHONPATH=/vmaf/python/src:/vmaf:/vmaf/sureal/python/src:$PYTHONPATH
ENV PATH=/vmaf:/vmaf/wrapper:/vmaf/sureal:$PATH
RUN make