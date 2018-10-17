FROM jupyter/base-notebook

MAINTAINER mtucker502

USER root

# Install prereqs for pyez
RUN apt-get update && \
	apt-get install -yq build-essential \
	libssl-dev

# Install pyez
RUN pip install junos-eznc

# Setup Python2 environment
RUN apt-get install -y \
	python \
	python-dev \
	python-lxml \
	libssl-dev \
	libffi-dev \
	libzmq-dev

# Python 2 pip is currently broken in the repos. Install with get-pip.py
RUN wget https://bootstrap.pypa.io/get-pip.py; python2 get-pip.py

# Setup Python2 and Bash Kernels
RUN python2 -m pip install ipykernel
RUN python2 -m ipykernel install --user 
RUN python2 -m pip install bash_kernel
RUN python2 -m bash_kernel.install

# Install Python 2 Juniper libraries
RUN alias python="/usr/bin/python2"
RUN pip2 install junos-eznc junos-netconify jxmlease jsnapy ansible ipywidgets

# Install Juniper's Ansible modules
RUN ansible-galaxy install Juniper.junos

# Change owner so Notebook notebook can write to it
RUN chown -R jovyan:users /home/jovyan/.*

# Kludge because .ansible/tmp ends up corrupted during the install
RUN rm -fr /home/jovyan/.ansible*


USER $NB_USER
