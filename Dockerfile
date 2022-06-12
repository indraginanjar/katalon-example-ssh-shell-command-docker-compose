FROM debian:buster-20220527

RUN apt-get update && \
    apt-get install -y openssh-server

ARG USERNAME
ARG PASSWORD
RUN adduser --gecos "" --disabled-password $USERNAME
RUN echo "$USERNAME:$PASSWORD" | chpasswd
EXPOSE 22
