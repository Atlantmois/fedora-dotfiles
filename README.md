# Fedora dotfiles

从 Fedora 44 Workstation 当前用户配置中精选的个人设置。主要是 Niri + Noctalia 桌面、Kanso Ink Obsidian 配色、Fish、Ghostty、Helix、Yazi、Fcitx5、字体和终端工具；`home/` 里的路径对应用户主目录。

## 内容

| 路径 | 用途 |
| --- | --- |
| `.config/niri`、`.config/noctalia` | 窗口布局、快捷键、面板、主题模板 |
| `.config/ghostty`、`.config/helix`、`.config/yazi`、`.config/btop` | 终端、编辑器和命令行界面 |
| `.config/fish`、`.config/starship.toml` | Shell、缩写、函数和提示符 |
| `.config/fcitx5`、`.local/share/fcitx5/themes` | 输入法设置和定制候选框主题 |
| `.config/fontconfig`、`.config/theme` | 中文字体优先级和共享色板 |
| `.config/gtk-3.0`、`.config/xdg-desktop-portal` | GTK 深色外观和 Niri 下的桌面门户选择 |
| `.config/systemd/user` | GTK 文件选择器的用户级服务覆盖设置 |
| `.omp/agent`、`.config/herdr` | OMP 外观、全局规则与 Herdr 集成设置 |
| `gnome/interface.dconf` | GNOME 外观设置快照，需手动导入 |
| `packages/` | Fedora 和 Flatpak 应用清单，仅供参考 |

`manifest.txt` 是安装脚本的文件清单。只有清单中的文件会进入主目录。

## 安装

先安装需要的程序，参看 `packages/fedora.txt`。字体配置优先使用 **鸿蒙黑体**，并用 **Noto Sans CJK SC** 兜底；Ghostty 使用 **JetBrains Maple Mono**。鸿蒙黑体和 JetBrains Maple Mono 是单独安装的字体，仓库没有复制字体文件。Rime 的 `default.custom.yaml` 选用 **雾凇拼音**，需要另行安装对应方案。

```bash
git clone https://github.com/Atlantmois/fedora-dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh                 # 只预览
./install.sh --apply         # 逐个文件建立符号链接
```

安装时已有文件会移动到 `~/.local/state/fedora-dotfiles-backups/`（或 `$XDG_STATE_HOME/fedora-dotfiles-backups/`）下带随机后缀的目录。脚本不会安装软件，也不会自动载入 GNOME 设置。

`home/.omp/agent/config.yml` 保存了当前 OMP 配置，但其中启用了 `approvalMode: yolo`，因此**不在默认安装清单中**。需要这套审批行为时，检查内容后自行安装。

GNOME 外观设置可单独导入：

```bash
dconf load /org/gnome/desktop/interface/ < gnome/interface.dconf
```

## 换机前检查

- Niri 的 `/dev/dri/renderD128`、`eDP-1` 的 `3200x2000@165`、位置及缩放、`intel_backlight` 和 `Xft.dpi: 192` 是这台 Fedora 笔记本的硬件参数。换机时先调整 `home/.config/niri/config.kdl` 与 `home/.config/niri/xresources`，再启动 Niri。
- Niri 会启动 Noctalia 与 Fcitx5，快捷键还调用 `brightnessctl`、`wpctl` 和 `playerctl`。桌面门户配置使用 GNOME、GTK 和 GNOME Keyring 后端。
- `snapshot` Fish 函数调用 `sudo snapper -c root`；目标机器须先安装并配置 Snapper 的 `root` 快照配置。GTK 文件选择器的 systemd 覆盖设置会强制使用 X11 后端，换机时按需保留。
- Fcitx5 主题 `mellow-graphite-obsidian-lite` 基于 Mellow Graphite dark 1.10.1 修改，来源和修改内容见主题目录内的 `README.txt`。
- Noctalia 的实际壁纸、个人字体文件、浏览器资料、SSH 密钥、Rime 用户词典及同步数据均未收录。个人词典中可能有私人文字，需要自己备份。

## 收录原则

只收录当前使用且可复用的文本配置和少量自制主题资源。没有复制缓存、日志、会话、历史、密钥、浏览器资料、输入法用户数据、大型上游词库或自动生成文件。`fish_variables` 中的编辑器与本地 `bin` 路径已改写到 `config.fish`，避免硬编码原用户名。
