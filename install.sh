# Install nvim
mkdir -p ~/.local/bin
curl -sLo ~/.local/bin/nvim https://github.com/neovim/neovim-releases/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x ~/.local/bin/nvim

# Install lazygit
tar xf archive/lazygit_0.60.0_linux_x86_64.tar.gz lazygit
mv lazygit ~/.local/bin/

# Install ripgrep
tar xf ./archive/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
mv ripgrep-15.1.0-x86_64-unknown-linux-musl/rg ~/.local/bin/
rm -rf ripgrep-15.1.0-x86_64-unknown-linux-musl

# Configure PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi
source ~/.bashrc
