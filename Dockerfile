FROM ubuntu as build

RUN apt-get update && apt-get -y install \
  libcurl4-openssl-dev \
  gcc \
  xdg-utils \
  make \
  curl \
  git \
  gpg \
  xz-utils \
  build-essential \
  pkg-config \
  libsqlite3-dev

RUN curl -fsS https://dlang.org/install.sh | bash -s dmd

RUN /bin/bash -c "source ~/dlang/dmd-*/activate"

RUN git clone -b v2.3.10 https://github.com/abraunegg/onedrive.git
RUN /bin/bash -c "source ~/dlang/dmd-*/activate && cd onedrive && ./configure && make clean && make && make install"

FROM ubuntu

RUN apt-get update && apt-get -y install \
  libcurl4-openssl-dev \
  libsqlite3-dev

COPY --from=build /usr/local/bin/onedrive /usr/local/bin/onedrive

VOLUME ["/usr/local/etc/my_onedrive.conf", "/onedrive"]

RUN mkdir /root/.config

ADD ./onedrive.conf /root/.config/
ADD ./start.sh /root/

RUN apt-get clean

CMD /root/start.sh
