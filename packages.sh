# Run ALL official install scripts (e.g. external deb repositories)
./install/*.sh

system_utils=(
htop

)

dev_tools=(
bat
neovim
tldr
)

multimedia=(
cmus
pipes-sh
)

all_packages=(
    "${system_utils[@]}"
    "${dev_tools[@]}"
    "${multimedia[@]}"
)

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install all packages
echo "Installing packages..."
sudo apt install -y "${all_packages[@]}"

echo "Installation complete!"
