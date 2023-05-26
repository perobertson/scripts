.DEFAULT_GOAL := install

fonts_to_install := $(wildcard *.ttf) $(wildcard *.otf)
fonts := $(patsubst %, ~/.local/share/fonts/%, $(fonts_to_install))

~/.local/share/fonts/:
	mkdir -p ~/.local/share/fonts

$(fonts): ~/.local/share/fonts/
	cp $(fonts_to_install) ~/.local/share/fonts/

.PHONY: install
install: $(fonts)
	fc-cache -v
