all: bin plugins.lua

compile: FNLFILES

%.lua: %.fnl bin
	fennel --compile $< > $@

bin: ~/.local/bin/fennel

~/.local/bin/fennel:
	mkdir -p $(dirname $@)
	curl -fsSL https://fennel-lang.org/downloads/fennel-1.0.0 -o $@
	chmod +x $@
	curl https://fennel-lang.org/downloads/fennel-1.0.0.asc \
	| gpg --verify - $@ \
	|| echo "WARNING: gpg couldn't verify the validity of the fennel script. Proceed with caution"
