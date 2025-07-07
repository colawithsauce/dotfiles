if status is-interactive
    # Commands to run in interactive sessions can go here
    # ~/.config/fish/config.fish
    set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
    carapace _carapace | source

    # ~/.config/fish/config.fish
    starship init fish | source

    eval "$(pixi completion --shell fish)"

    # 设置通用 socket 路径
    set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket

    if test "$TERM_PROGRAM" = vscode
        set -x EDITOR "code --wait"
        set -x VISUAL "code --wait"
        set -x DIFFTOOL "code --wait --diff"
        alias vi "code --wait"
        alias vim "code --wait"
        alias diff "code --wait --diff"
    else if test "$TERM_PROGRAM" = zed
        set -x EDITOR "zed -a"
        set -x VISUAL "zed -a"
        alias vi "zed -a"
        alias vim "zed -a"
    else
        # 如果已有 nvim session，就用 nvr，否则 fallback 到 nvim
        if test "$NVIM_LISTEN_ADDRESS"
            set -x EDITOR "nvr -s --remote-tab"
            set -x VISUAL "$EDITOR"
            alias vi "$EDITOR"
            alias vim "$EDITOR"
        else
            set -x EDITOR nvim
            set -x VISUAL nvim
            alias vi nvim
            alias vim nvim
        end
    end

    if test "$TERM_PROGRAM" = kitty
        alias ssh "kitty +kitten ssh"
    end

    set -x http_proxy "http://127.0.0.1:12334"
    set -x https_proxy "http://127.0.0.1:12334"
    set -x XDG_DATA_DIRS "/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
    set -x SANITIZER "-fsanitize=address -O1 -fno-omit-frame-pointer -g"

    set BINDIR (string match -r '^.+$' "$XDG_BIN_HOME"; or echo "$HOME/.local/bin")

    if not contains $BINDIR $PATH
        set -x PATH $PATH $BINDIR
    end

    set -x CARGO_HOME "$HOME/.cargo"
    set -x PATH "$CARGO_HOME/bin" $PATH

    starship init fish | source
    leetcode completions fish | source

    set -x VOLTA_HOME "$HOME/.volta"
    set -x PATH "$VOLTA_HOME/bin" $PATH

    set -x PATH "$HOME/.config/emacs/bin" $PATH
    set -x PATH "$HOME/go/bin" $PATH

end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/colawithsauce/miniconda3/bin/conda
    eval /home/colawithsauce/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/home/colawithsauce/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/colawithsauce/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /home/colawithsauce/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<
