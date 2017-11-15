FROM debian:latest

ENV RANGE=0.0.0.0/0 \
    PORTS=8080 \
    RATE=1000

RUN apt-get update \
    && apt-get install -y \
         git \
         gcc \
         make \
         libpcap-dev \
         curl \
         clang \
    && git clone https://github.com/robertdavidgraham/masscan \
    && cd masscan \
    && make -j \
    && cp bin/masscan /usr/local/bin/ \
    && apt-get clean \
    && rm -rf /tmp/* /root/..?* /root/.[!.]* /root/* /masscan

COPY proxy_check.sh entrypoint.sh /usr/local/bin/
COPY exclude.conf /

WORKDIR /opt

ENTRYPOINT ["entrypoint.sh"]
