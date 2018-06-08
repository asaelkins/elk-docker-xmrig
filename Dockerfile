FROM alpine:latest

RUN adduser -S -D -H -h /xmrig miner
RUN apk --no-cache upgrade && \
  apk --no-cache add \
  git \
  cmake \
  libuv-dev \
  build-base \
  libmicrohttpd-dev && \
  git clone https://github.com/xmrig/xmrig && \
  cd xmrig && \
  mkdir build && \
  cmake -DCMAKE_BUILD_TYPE=Release . && \
  make && \
  apk del \
  build-base \
  cmake \
  git && \
  cat  "./xmrig --donate-level=$donate -p=$HOSTNAME:$EMAIL -o $POOL -u $WALLET" > run_xmrig.sh && \
  chmod 755 run_xmrig.sh
USER miner
WORKDIR /xmrig
ENTRYPOINT ["./run_xmrig.sh"]
