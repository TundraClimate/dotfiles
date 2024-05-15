cd `dirname $0`

echo create .zshrc symlink
if [ ! -e ${HOME}/.zshrc ]; then
  ln -s ${PWD}/.zshrc ${HOME}/.zshrc
fi
echo create .vimrc symlink
if [ ! -e ${HOME}/.vimrc ]; then
  ln -s ${PWD}/.vimrc ${HOME}/.vimrc
fi
echo create Neovim conf symlink
if [ ! -d ${HOME}/.config/nvim ]; then
  ln -s ${PWD}/.config/nvim ${HOME}/.config/nvim
fi

source ${HOME}/.zshrc
