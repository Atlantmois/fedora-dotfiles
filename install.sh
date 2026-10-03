#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
mode=${1:---dry-run}
case "$mode" in
  --dry-run|--apply) ;;
  *) printf '用法: %s [--dry-run|--apply]\n' "$0" >&2; exit 2 ;;
esac

state_dir=${XDG_STATE_HOME:-"$HOME/.local/state"}
backup_dir=''

while IFS= read -r relative_path || [[ -n "$relative_path" ]]; do
  [[ -n "$relative_path" ]] || continue
  [[ "$relative_path" != /* && "$relative_path" != *'..'* ]] || {
    printf '非法路径: %s\n' "$relative_path" >&2
    exit 1
  }

  source_file="$repo_dir/home/$relative_path"
  destination="$HOME/$relative_path"
  [[ -f "$source_file" && ! -L "$source_file" ]] || {
    printf '缺少源文件: %s\n' "$source_file" >&2
    exit 1
  }

  if [[ -L "$destination" && "$(readlink -- "$destination")" == "$source_file" ]]; then
    printf '已安装  %s\n' "$relative_path"
    continue
  fi

  if [[ "$mode" == --dry-run ]]; then
    if [[ -e "$destination" || -L "$destination" ]]; then
      printf '将备份并链接  %s\n' "$relative_path"
    else
      printf '将链接  %s\n' "$relative_path"
    fi
    continue
  fi

  mkdir -p -- "$(dirname -- "$destination")"
  if [[ -e "$destination" || -L "$destination" ]]; then
    if [[ -z "$backup_dir" ]]; then
      mkdir -p -- "$state_dir/fedora-dotfiles-backups"
      backup_dir=$(mktemp -d -- "$state_dir/fedora-dotfiles-backups/backup.XXXXXXXX")
    fi
    mkdir -p -- "$(dirname -- "$backup_dir/$relative_path")"
    mv -- "$destination" "$backup_dir/$relative_path"
  fi
  ln -s -- "$source_file" "$destination"
  printf '已链接  %s\n' "$relative_path"
done < "$repo_dir/manifest.txt"

if [[ "$mode" == --dry-run ]]; then
  printf '\n这是预览。确认后运行: %s --apply\n' "$0"
elif [[ -n "$backup_dir" ]]; then
  printf '\n原文件已备份到: %s\n' "$backup_dir"
fi
