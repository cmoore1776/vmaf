FROM ubuntu:16.04

ENV \
  PYTHONPATH=/vmaf/python/src:/vmaf:/vmaf/sureal/python/src:$PYTHONPATH \
  PATH=/vmaf:/vmaf/wrapper:/vmaf/sureal:$PATH

RUN \
  apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends build-essential git python python-setuptools python-dev python-tk \
  python-numpy python-scipy python-matplotlib python-sklearn \
  ipython ipython-notebook python-pandas python-sympy python-nose && \
  easy_install pip && \
  pip install scikit-image h5py && \
  git clone --depth 1 https://github.com/Netflix/vmaf.git vmaf && \
  cd /vmaf && \
  git submodule update --init --recursive && \
  make && \
  rm -rf /vmaf/python/test && \
  apt remove git build-essential -y && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /vmaf

ENTRYPOINT [ "run_vmaf" ]