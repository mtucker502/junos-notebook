FROM jupyter/base-notebook

MAINTAINER mtucker502

USER root

RUN apt-get update && \
	apt-get install -yq build-essential \
	libssl-dev

RUN pip install junos-eznc

USER $NB_USER
