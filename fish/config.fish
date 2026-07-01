source /usr/share/cachyos-fish-config/cachyos-config.fish

# Disable fastfetch
function fish_greeting
    # noop
end

# Set preferred editor
export EDITOR="nvim"

# Set rootless Docker socket
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"

# Add CUDA binaries to PATH
export CUDA_PATH="/opt/cuda"
fish_add_path '/opt/cuda/bin'
export PATH

# Set the default host compiler for nvcc. This will need to be switched back
# and forth between the latest and previous g++ version, whatever nvcc
# currently supports.
export NVCC_CCBIN="$(which g++-15)"

# Aliases
alias restart-cmus-discord-rpc="systemctl --user restart cmus-discord-rich-presence.service"
alias fishcfg="$EDITOR ~/.config/fish/config.fish"

# sync-music command
function sync-music
    echo "Syncing over Tailnet"
    
    if test "$(tailscale status --self --json | jq -r '.BackendState')" != "Running"
      echo "Tailscale not running. Attempting to start..."
      tailscale up
      echo "Started Tailscale"
    end

    rsync -avz user@music-server-tunnel-2:/music/ "$HOME/Music/"
end

# Patch ssh for Kitty
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# SoC printing
function soc-print
  set USERNAME "nusstu/e1525944"
  set DOMAIN "nts27b.res.nus.edu.sg"
  set PRINTER "pstsc"

  echo "Printing $argv[1] to $DOMAIN/$PRINTER on account $USERNAME"
  smbclient -U "$USERNAME" //"$DOMAIN/$PRINTER" -c "print $argv[1]"
end
