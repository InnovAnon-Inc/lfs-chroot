FROM scratch

#WORKDIR /
# TODO tar -p necessary ?
#USER root
RUN $SHELL -eux 059-changingowner \
 && $SHELL   -x 060-kernfs        \
 && rm -rf          $HOME/.bin    \
 && cd $LFS                       \
 && tar  pcf /lfs.tar .             \
 && exec true || exec false

#FROM innovanon/builder as copyhack
#COPY --from=builder-05 /lfs.tar /

FROM scratch as lfs-chroot
ARG TEST=
ARG LFS=/mnt/lfs
COPY --from=innovanon/lfs-chroot $LFS/ /

#COPY --from=builder-05 --chown=root /lfs.tar /lfs.tar
#COPY --from=builder-05 /lfs.tar /lfs.tar
# TODO copy static tar
#RUN tar xf /lfs.tar -C / \
# && rm -v  /lfs.tar
# TODO rm static tar
# TODO setup "chroot" env

ENV HOME=/root
ENV TERM="$TERM"
ENV PS1='(lfs chroot) \u:\w\$ '
ENV PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
SHELL ["/bin/bash", "--login", "+h", "-c"]

#COPY --from=builder-05 --chown=root /lfs.tar /lfs.tar
#COPY --from=builder-05 /lfs.tar /lfs.tar
# TODO copy static tar
#RUN tar xf /lfs.tar -C / \
# && rm -v  /lfs.tar
# TODO rm static tar
# TODO setup "chroot" env

ENV HOME=/root
ENV TERM="$TERM"
ENV PS1='(lfs chroot) \u:\w\$ '
ENV PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
SHELL ["/bin/bash", "--login", "+h", "-c"]
# TODO support

# TODO install tor
COPY --from=innovanon/builder /etc/profile.d   /etc/profile.d/
COPY --from=innovanon/builder /etc/tor         /etc/tor/
COPY --from=innovanon/builder /etc/tsocks.conf /etc/
COPY --from=innovanon/builder /usr/local/bin   /usr/local/bin/
COPY ./tor /usr/local/bin/tor

#FROM builder-05 as workaround
# TODO 
#SHELL ["/usr/sbin/chroot", "/mnt/lfs",  \
#       "/usr/bin/env", "-i",   \
#         "HOME=/root",         \
#         "PATH=/bin:/usr/bin:/sbin:/usr/sbin", \
#         "/bin/bash", "--login", "+h", "-c"]

#FROM builder-05 as squash-tmp
#USER root
#RUN  squash.sh
#FROM scratch as squash
#ADD --from=squash-tmp /tmp/final.tar /

#FROM builder-05

FROM innovanon/lfs-chroot as test
RUN sleep 91 && curl -L --retries 10 --proxy $SOCKS_PROXY https://duckduckgo.com

FROM innovanon/lfs-chroot
