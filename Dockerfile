FROM jupyter/scipy-notebook

MAINTAINER mtucker502

USER root

# Install prereqs for pyez
RUN apt-get update && \
	apt-get install -yq build-essential \
	libssl-dev

# Setup Python and Bash Kernels
RUN python -m ipykernel install --user 
RUN python -m pip install bash_kernel
RUN python -m bash_kernel.install

# Install Python 2 Juniper libraries
RUN pip install junos-eznc junos-netconify jxmlease jsnapy ansible

# Install Juniper's Ansible modules
RUN ansible-galaxy install Juniper.junos

# Change owner so Notebook notebook can write to it
RUN chown -R jovyan:users /home/jovyan/.*

# Kludge because .ansible/tmp ends up corrupted during the install
RUN rm -fr /home/jovyan/.ansible*


USER $NB_USER
