fish_add_path -g ~/.local/bin ~/.local/uutils-bin/ ~/.cargo/bin ~/.deno/bin ~/.opencode/bin

set -g fish_greeting ""

if status is-interactive
    if type -q fzf
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
        set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
        set -gx FZF_DEFAULT_OPTS '
        --height=60%
        --layout=reverse
        --border
        --preview "bat --style=numbers --color=always {} 2>/dev/null || eza --tree {}"
        '
    end

    if type -q starship
        starship init fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end

    if type -q atuin
        atuin init fish | source
    end

    if type -q eza
        abbr -a ls eza
        abbr -a ll 'eza -lah --git'
        abbr -a la 'eza -a'
        abbr -a tree 'eza --tree'
    end

    abbr -a poweroff 'doas openrc-shutdown -p now'
    abbr -a nb netbird
    abbr -a y yazi
    abbr -a reload 'exec fish'
    abbr -a fishconfig "$EDITOR $__fish_config_dir/config.fish"

    set --export BUN_INSTALL "$HOME/.bun"
    set --export PATH $BUN_INSTALL/bin $PATH

    set -g fish_color_command blue
    set -g fish_color_keyword magenta
    set -g fish_color_quote green
    set -g fish_color_error red --bold
    set -g fish_color_comment brblack
    set -g fish_color_selection --background=brblack
    set -g fish_color_operator cyan
    set -g fish_color_escape cyan
    set -g fish_color_valid_path magenta --underline
    set -g fish_color_autosuggestion brblack
    set -g fish_color_cancel red
    set -g fish_color_search_match --background=brblack
    set -g fish_color_option yellow

    set -g fish_pager_color_prefix blue
    set -g fish_pager_color_description brblack
    set -g fish_pager_color_selected_background --background=brblack
end
