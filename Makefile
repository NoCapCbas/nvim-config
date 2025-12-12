.PHONY: deps-linux

deps-linux:
	# System dependencies
	sudo apt-get update
	sudo apt-get install -y unzip python3-venv python3-pip curl git ripgrep fd-find
	# Go, Java, TeX
	sudo apt-get install -y golang-go default-jdk texlive texlive-latex-extra latexmk
	# Node-based LSP servers
	npm install -g pyright typescript typescript-language-server vscode-langservers-extracted @tailwindcss/language-server yaml-language-server dockerfile-language-server-nodejs
	# Python tools
	pip3 install --user ruff debugpy
