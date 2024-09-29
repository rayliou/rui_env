RSYNC?=rsync -e 'ssh -p2231'
REMOTE_DEV_HOST?=HOST_REMOTE
all: $(HOME)/g

$(HOME)/g:
	$(RSYNC) --delete -Pavur $@/ $(REMOTE_DEV_HOST):$@/

.PHONY:$(HOME)/g
