fzf_theme_opts="\
--color=bg+:#353940
--color=bg:#000000
--color=spinner:#e1e2e8
--color=hl:#ffb4ab
--color=fg:#e1e2e8
--color=header:#ffb4ab
--color=info:#a2c9fe
--color=pointer:#e1e2e8
--color=marker:#c3c6cf
--color=fg+:#e1e2e8
--color=prompt:#a2c9fe
--color=hl+:#ffb4ab
--color=selected-bg:#43474e
--color=border:#43474e
--color=label:#e1e2e8"

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS
}$fzf_theme_opts"
