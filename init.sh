#!/usr/bin/env bash

# Tell bash to fail immediately on any error as well as unset variables
# set -e -o pipefail

export DEBIAN_FRONTEND=noninteractive
export PYTHON_VERSION=3.11.6
export PYENV_ROOT="$HOME/.pyenv"
export DEFAULT_VENV="${HOME}/.virtualenvs/default"

symlink() {
	# A symlink function that makes sure the target symlink's parent path
	# exists.

	# Expand ~ to $HOME if present
	local source="${1/#\~/$HOME}"
	local target="${2/#\~/$HOME}"

	[[ -e ${target} ]] && echo "'${target}' exists, skipping" && return

	mkdir -p "$(dirname ${target})"
	ln -s "${source}" "${target}"
}

# Se up the dotfiles repository
setup_dotfiles() {
	local workspace="${HOME}/workspace"
	local dotfiles_dir="${workspace}/dotfiles"
	mkdir -p "${workspace}"

	if [[ -d "${dotfiles_dir}" ]]; then
		echo "dotfiles already cloned, skipping"
	else
		{
			git git@github.com:philipforget/dotfiles.git "${dotfiles_dir}"
		} || {
			echo "Unable to clone via ssh, falling back to https"
			git clone https://github.com/philipforget/dotfiles.git "${dotfiles_dir}"
		}
	fi

	# Set up symlinks
	symlink "${dotfiles_dir}/aliases" ~/.aliases
	symlink "${dotfiles_dir}/aliases_linux" ~/.aliases_linux
	symlink "${dotfiles_dir}/aliases_mac" ~/.aliases_mac
	symlink "${dotfiles_dir}/bash_custom" ~/.bash_custom
	symlink "${dotfiles_dir}/bash_linux" ~/.bash_linux
	symlink "${dotfiles_dir}/bash_mac" ~/.bash_mac
	symlink "${dotfiles_dir}/distraction" ~/.distraction
	symlink "${dotfiles_dir}/docker_config.json" ~/.docker/config.json
	symlink "${dotfiles_dir}/gitconfig" ~/.gitconfig
	symlink "${dotfiles_dir}/pylintrc" ~/.pylintrc
	symlink "${dotfiles_dir}/tmux.conf" ~/.tmux.conf
	symlink "${dotfiles_dir}/vim" ~/.vim
	symlink "${dotfiles_dir}/xmodmap" ~/.xmodmap
	symlink "${dotfiles_dir}/sync-authorized-keys" ~/bin/sync-authorized-keys

	# Mac only symlinks
	if [[ $(uname) == "Darwin" ]]; then
		symlink "${dotfiles_dir}/com.knollsoft.Rectangle.plist" "${HOME}/Library/Preferences/com.knollsoft.Rectangle.plist"
	fi

	# Add sourcing of ~/.bash_custom to .bashrc and .profile if not present
	if ! grep -Fxq 'source ~/.bash_custom' "${HOME}/.bashrc"; then
		echo 'source ~/.bash_custom' >>"${HOME}/.bashrc"
	fi
	if ! grep -Fxq 'source ~/.bash_custom' "${HOME}/.profile"; then
		echo 'source ~/.bash_custom' >>"${HOME}/.profile"
	fi
}

setup_system() {
	if [[ $(uname) == "Darwin" ]]; then
		# On MacOS, install and use brew package manager
		if ! which brew &>/dev/null; then
			echo 'Installing brew package manager: https://brew.sh/'
			echo 'Requires user password'
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		fi
		echo "Installing packages with brew"
		brew install \
			age \
			bash \
			bash-completion \
			git \
			git-lfs \
			mosh \
			neovim \
			pyenv \
			python3 \
			ripgrep \
			shellcheck \
			sops \
			tmux \
			vim

		git lfs install

		brew install --cask \
			1password \
			docker \
			google-chrome \
			microsoft-remote-desktop \
			rectangle \
			signal

		# Install a newer bash than ships with MacOS and set it as the default shell
		brew_bash="$(brew --prefix)/bin/bash"
		# Bail early if ${brew_bash} doesn't exist for any reason
		[[ ! -f ${brew_bash} ]] && echo "Unable to set brew-installed bash as shell!" || {
			echo "Adding ${brew_bash} to /etc/shells if not present"
			grep ${brew_bash} /etc/shells &>/dev/null || echo ${brew_bash} | sudo tee -a /etc/shells
			[[ ${SHELL} = ${brew_bash} ]] || chsh -s ${brew_bash} $(whoami | xargs echo -n)
		}

		# Add ssh agent to system keychain on first unlock
		ssh_agent_config="AddKeysToAgent yes"
		grep "${ssh_agent_config}" ~/.ssh/config &>/dev/null || echo "${ssh_agent_config}" >>~/.ssh/config

	else
		if grep -qE "Ubuntu|Debian|Raspbian" /etc/issue; then
			echo "Installing required packages"
			# Use sudo -E to inherit our current environment, including
			# DEBIAN_FRONTEND set above
			sudo add-apt-repository -y ppa:neovim-ppa/stable
			sudo -E apt-get -qq update
			sudo -E apt-get -qq install -y \
				--no-install-recommends \
				age \
				bash-completion \
				build-essential \
				curl \
				curl \
				dnsutils \
				git \
				git-lfs \
				libbz2-dev \
				libffi-dev \
				liblzma-dev \
				libncursesw5-dev \
				libreadline-dev \
				libsqlite3-dev \
				libssl-dev \
				libxml2-dev \
				libxmlsec1-dev \
				llvm \
				shellcheck \
				tk-dev \
				neovim \
				ripgrep \
				tmux \
				vim-nox \
				xz-utils \
				zlib1g-dev

			# Install pyenv and install a new global python version
			curl https://pyenv.run | bash

			git lfs install

			# Set vim as default system editor
			sudo update-alternatives --set editor /usr/bin/vim.nox

			# Install sops from github releases
			curl -L https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64 -o "${HOME}/bin/sops" && chmod +x "${HOME}/bin/sops"
		fi
	fi

	# Install volta for managing node and npm versions
	curl https://get.volta.sh | bash -s -- --skip-setup

}

setup_python() {
	default_venv="${HOME}/.virtualenvs/default"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"

	# With pyenv installed on the system, install our default virtualenv
	pyenv install -s "${PYTHON_VERSION}"
	pyenv global "${PYTHON_VERSION}"

	"${PYENV_ROOT}/shims/python3" -m venv "${default_venv}"
	"${default_venv}/bin/python3" -m pip install -U pip
	"${default_venv}/bin/python3" -m pip install \
		black \
		flask \
		ipython \
		mypy \
		requests \
		ruff
}

init() {
	local github_username="${1}"

	setup_system

	setup_python

	# If a github username is provided, import its public keys
	if [[ -n ${github_username} ]]; then
		mkdir -p "${HOME}/.ssh"
		curl -L https://github.com/philipforget.keys >>"${HOME}/.ssh/authorized_keys"
	fi

	setup_dotfiles

	echo "Installing vim plugins"
	vim +'PlugInstall --sync' +qall &>/dev/null

	echo "setup complete, run 'source ~/.bashrc' to source changes"
}

# When piping in from stdin (eg curl), BASH_SOURCE[0] will be unset, and
# when executing via ./init.sh or bash init.sh, BASH_SOURCE[0] and ${0}
# will be equal
if [ "${BASH_SOURCE[0]}" == "${0}" ] || [ -z "${BASH_SOURCE[0]}" ]; then
	init "$@"
fi
