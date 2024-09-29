
all:$(HOME)/.vimrc \
	$(HOME)/.zshrc \
	$(HOME)/.ssh/authorized_keys

$(HOME)/.vimrc:$(HOME)/g/rui_env/HOME/dot.vimrc 
	rm -vf $@ && ln -sf  $< $@
$(HOME)/.zshrc:$(HOME)/g/rui_env/HOME/dot.zshrc 
	rm -vf $@ && ln -sf  $< $@
$(HOME)/.ssh/authorized_keys:$(HOME)/g/rui_env/HOME/authorized_keys
	rm -vf $@ && ln -sf  $< $@
