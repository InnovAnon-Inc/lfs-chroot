FROM innovanon/lfs-prechroot as builder-04
ARG LFS=/mnt/lfs
ARG TEST=
COPY --from=innovanon/book --chown=root /home/lfs/lfs-sysd-commands/chapter06/* \
                              /home/lfs/.bin/
RUN sleep 31 \
 && dl m4-1.4.18.tar.xz                        \
 && cd              m4-1.4.18                     \
 && $SHELL -eux 041-m4                            \
 && cd $LFS/sources                               \
 && rm -rf          m4-1.4.18                     \
 \
 && dl ncurses-6.2.tar.gz                        \
 && cd              ncurses-6.2                     \
 && $SHELL -eux 042-ncurses                         \
 && cd $LFS/sources                                 \
 && rm -rf          ncurses-6.2                     \
 \
 && dl bash-5.1.tar.gz                        \
 && cd              bash-5.1                     \
 && $SHELL -eux 043-bash                         \
 && cd $LFS/sources                              \
 && rm -rf          bash-5.1                     \
 \
 && dl coreutils-8.32.tar.xz                        \
 && cd              coreutils-8.32                     \
 && $SHELL -eux 044-coreutils                          \
 && cd $LFS/sources                                    \
 && rm -rf          coreutils-8.32                     \
 \
 && dl diffutils-3.7.tar.xz                        \
 && cd              diffutils-3.7                     \
 && $SHELL -eux 045-diffutils                         \
 && cd $LFS/sources                                   \
 && rm -rf          diffutils-3.7                     \
 \
 && dl file-5.39.tar.gz                        \
 && cd              file-5.39                     \
 && $SHELL -eux 046-file                          \
 && cd $LFS/sources                               \
 && rm -rf          file-5.39                     \
 \
 && dl findutils-4.7.0.tar.xz                        \
 && cd              findutils-4.7.0                     \
 && $SHELL -eux 047-findutils                           \
 && cd $LFS/sources                                     \
 && rm -rf          findutils-4.7.0                     \
 \
 && dl gawk-5.1.0.tar.xz                        \
 && cd              gawk-5.1.0                     \
 && $SHELL -eux 048-gawk                           \
 && cd $LFS/sources                                \
 && rm -rf          gawk-5.1.0                     \
 \
 && dl grep-3.6.tar.xz                        \
 && cd              grep-3.6                     \
 && $SHELL -eux 049-grep                         \
 && cd $LFS/sources                              \
 && rm -rf          grep-3.6                     \
 \
 && dl gzip-1.10.tar.xz                        \
 && cd              gzip-1.10                     \
 && $SHELL -eux 050-gzip                          \
 && cd $LFS/sources                               \
 && rm -rf          gzip-1.10                     \
 \
 && dl make-4.3.tar.gz                        \
 && cd              make-4.3                     \
 && $SHELL -eux 051-make                         \
 && cd $LFS/sources                              \
 && rm -rf          make-4.3                     \
 \
 && dl patch-2.7.6.tar.xz                        \
 && cd              patch-2.7.6                     \
 && $SHELL -eux 052-patch                           \
 && cd $LFS/sources                                 \
 && rm -rf          patch-2.7.6                     \
 \
 && dl sed-4.8.tar.xz                        \
 && cd              sed-4.8                     \
 && $SHELL -eux 053-sed                         \
 && cd $LFS/sources                             \
 && rm -rf          sed-4.8                     \
 \
 && dl tar-1.32.tar.xz                        \
 && cd              tar-1.32                     \
 && $SHELL -eux 054-tar                          \
 && cd $LFS/sources                              \
 && rm -rf          tar-1.32                     \
 \
 && dl xz-5.2.5.tar.xz                        \
 && cd              xz-5.2.5                     \
 && $SHELL -eux 055-xz                           \
 && cd $LFS/sources                              \
 && rm -rf          xz-5.2.5                     \
 \
 && tar xf          binutils-2.35.1.tar.xz \
 && cd              binutils-2.35.1        \
 && $SHELL -eux 056-binutils-pass2         \
 && cd $LFS/sources                        \
 && rm -rf          binutils-2.35.1        \
 \
 && tar xf          gcc-10.2.0.tar.xz \
 && cd              gcc-10.2.0        \
 && tar xf ../isl-0.23.tar.xz         \
 && mv -v     isl{-0.23,}             \
 && $SHELL -eux 057-gcc-pass2         \
 && cd $LFS/sources                   \
 && rm -rf          gcc-10.2.0

#USER root
#RUN rm -rf /home/lfs/.bin

FROM builder-04 as builder-05
ARG TEST=
COPY --from=innovanon/book --chown=root /home/lfs/lfs-sysd-commands/chapter07/* \
                              /home/root/.bin/
#WORKDIR /
USER root

RUN chmod -v +x $HOME/.bin/*
RUN $SHELL -eux 059-changingowner \
 && $SHELL   -x 060-kernfs        \
 && rm -rf          $HOME/.bin    \
 && cd /tools                     \
 && tar cf /tools.tar .

FROM scratch as lfs-chroot
ARG TEST=
COPY --from=builder-05 --chown=root /tools.tar /tools.tar
# TODO copy static tar
RUN tar xf /tools.tar -C / \
 && rm -v  /tools.tar
# TODO rm static tar
# TODO setup "chroot" env

