function pkgs --description 列出值得保留的手动安装软件
    set -l ignore '^(anaconda-.*|dnf5|dracut-live|fedora-release-workstation|filesystem|grub.*|grubby|isomd5sum|kernel.*|kmod-nvidia-.*|livesys-scripts|systemd-oomd-defaults|udisks2-btrfs)$'

    set -l packages (
        dnf repoquery --installed --qf '%{name} %{reason}\n' 2>/dev/null \
        | awk '$NF == "User" {print $1}' \
        | grep -Ev "$ignore" \
        | sort -u
    )

    if test (count $packages) -eq 0
        echo 没有找到手动安装的软件包
        return
    end

    printf '%s\n' $packages | column

    echo
    echo "共 "(count $packages)" 个软件包"
end
