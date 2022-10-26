FROM alpine:3.16 AS build

RUN \
   apk --no-cache add build-base linux-headers cmake git && \
   apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.16/community add fuse3-dev flatbuffers-dev

WORKDIR /build
RUN git clone https://github.com/szatmary/PlotFS.git
RUN cd PlotFS && cmake . && make && make install

FROM alpine:3.16
RUN apk --no-cache add libstdc++ fuse3
COPY --from=build /usr/local/bin/plotfs /usr/local/bin/mount.plotfs /usr/local/bin/
COPY entrypoint.sh /
RUN mkdir /var/local/plotfs

VOLUME "/var/local/plotfs"

ENTRYPOINT ["/entrypoint.sh"]