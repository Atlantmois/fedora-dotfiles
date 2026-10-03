set --export EDITOR hx
set --export VISUAL hx
fish_add_path --path $HOME/.local/bin

if status is-interactive
    starship init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path --path --move $BUN_INSTALL/bin

if status is-interactive
    # fzf：Ctrl+R 搜索历史、Ctrl+T 选文件、Alt+C 跳目录。
    # 注：fzf 0.48+ 用 `fzf --fish` 取代了旧的 source key-bindings.fish / completion.fish
    if command -q fzf
        fzf --fish | source
    end

    # zoxide：z <关键词> 跳到常去目录、zi 交互式选择
    if command -q zoxide
        zoxide init fish | source
    end

end
