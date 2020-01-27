FROM centos:8

LABEL maintainer "@irix_jp"

RUN dnf update -y && \
    dnf install -y glibc-all-langpacks git sudo which tree && \
    dnf install -y gcc make automake autoconf libcurl-devel rpm-build ncurses-devel && \
    dnf clean all

WORKDIR /root
RUN git clone -b release https://github.com/roswell/roswell.git && \
    cd roswell && sh bootstrap && ./configure && make && make install && \
    ros init && \
    ros install sbcl --without-install && \
    cd ../ && rm -rf /root/roswell && \
    echo 'PATH=$PATH:$HOME/.roswell/bin' >> ~/.bashrc

