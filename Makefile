.PHONY: deps-linux deps-mssql

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

deps-mssql:
	curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
	curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
	sudo apt-get update
	sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev
	echo 'export PATH="$$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
