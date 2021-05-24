FROM ubuntu:20.10
ARG U=max
ARG P=pass


RUN apt-get update && \
      apt -y install sudo python3 python3-pip less

RUN useradd -m $U && echo "$U:$P" | chpasswd && adduser $U sudo

USER $U
WORKDIR /home/$U
CMD /bin/bash