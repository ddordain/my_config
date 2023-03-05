#!/bin/bash -e

if [[ $(id -u) -eq 0 ]]; then
  SUDO=""
else
  SUDO="sudo"
fi

# Install Zsh
$SUDO apt install -y zsh
wait

# Check Zsh version
zsh --version
wait

# Check if Zsh is available as a valid login shell
if ! grep -q "/usr/bin/zsh" /etc/shells; then
  echo "/usr/bin/zsh" | $SUDO tee -a /etc/shells
fi
wait

# Set Zsh as default shell
$SUDO chsh -s /usr/bin/zsh
wait

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
wait

# Install Powerline font
$SUDO apt install -y fonts-powerline
wait

# Install Powerlevel10k
$SUDO git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
$SUDO sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
wait

# Install Dracula theme for GNOME Terminal
$SUDO apt install -y dconf-cli
$SUDO git clone https://github.com/dracula/gnome-terminal.git
cd gnome-terminal
./install.sh
cd ..
rm -rf gnome-terminal
wait

# Install plugins
$SUDO git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
$SUDO git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
$SUDO sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
wait

# Configure Powerlevel10k
p10k configure

