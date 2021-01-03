.PHONY: all chroot push clean
.SECONDARY: sources/.sentinel

all:    chroot
push:   chroot
	docker push     innovanon/lfs-$<
chroot: sources/.sentinel
	docker build -t innovanon/lfs-$@ .

sources/.sentinel: $(shell find sources -type f)
	touch $@

clean:
	rm -vf */.sentinel .sentinel

