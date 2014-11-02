FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y git-core erlang \
  && rm -rf /var/lib/apt/lists/*

RUN git clone git://github.com/rebar/rebar.git /tmp/rebar \
  && cd /tmp/rebar \
  && ./bootstrap \
  && cp rebar /usr/bin/rebar \
  && cd \
  && rm -rf /tmp/rebar

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD . /usr/src/app

CMD [ "rebar", "-vvv", "eunit" ]
