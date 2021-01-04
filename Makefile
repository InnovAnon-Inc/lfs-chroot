.PHONY: all chroot push clean commit
.SECONDARY: sources/.sentinel

all:    chroot
push:   chroot
	docker push     innovanon/lfs-$<
chroot: sources/.sentinel
	docker build -t innovanon/lfs-$@ $(TEST) .
commit:
	git add .
	git commit -m '[Makefile] commit'
	git pull
	git push

sources/.sentinel: $(shell find sources -type f)
	touch $@

clean:
	rm -vf */.sentinel .sentinel

