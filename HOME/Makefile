
all:ssh \
	$(HOME)/.vimrc \
	$(HOME)/.zshrc \
	$(HOME)/.config/nvim/init.lua \
	$(HOME)/.tmux.conf \
	$(HOME)/.config/terminator/config \
	$(HOME)/.config/uv/config.toml

ssh: $(HOME)/.ssh/authorized_keys $(HOME)/.ssh/config

$(HOME)/.vimrc:$(HOME)/g/rui_env/HOME/dot.vimrc 
	rm -vf $@ && ln -sf  $< $@
$(HOME)/.zshrc:$(HOME)/g/rui_env/HOME/dot.zshrc 
	rm -vf $@ && ln -sf  $< $@
$(HOME)/.ssh/authorized_keys:$(HOME)/g/rui_env/HOME/authorized_keys
	rm -vf $@ && ln -sf  $< $@
$(HOME)/.ssh/config:$(HOME)/g/rui_env/HOME/ssh_config
	rm -vf $@ && ln -sf  $< $@

$(HOME)/.tmux.conf:$(HOME)/g/rui_env/HOME/dot.tmux.conf
	rm -vf $@ && ln -sf  $< $@
$(HOME)/.config/terminator/config:$(HOME)/g/rui_env/HOME/terminator_config
	mkdir -p $(HOME)/.config/terminator
	rm -vf $@ && ln -sf  $< $@

$(HOME)/.config/nvim/init.lua:$(HOME)/g/rui_env/HOME/config_nvim_init.lua
	mkdir -p $(HOME)/.config/nvim
	rm -vf $@ && ln -sf  $< $@

$(HOME)/.config/uv/config.toml:$(HOME)/g/rui_env/HOME/config_uv_config.toml
	mkdir -p $(HOME)/.config/uv
	rm -vf $@ && ln -sf  $< $@
