FROM alpine:3.16.2 AS build

RUN \
   apk add build-base linux-headers cmake git && \
   apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.16/community add fuse3-dev flatbuffers-dev

WORKDIR /build
RUN git clone https://github.com/szatmary/PlotFS.git
RUN cd PlotFS && cmake . && make && make install

FROM alpine:3.16.2
RUN apk add libstdc++ fuse3
COPY --from=build /usr/local/bin/plotfs /usr/local/bin/mount.plotfs /usr/local/bin/

RUN mkdir /var/local/plotfs && plotfs --init && mkdir /plots

VOLUME "/var/local/plotfs"

ENTRYPOINT ["mount.plotfs", "-f", "/plots"]