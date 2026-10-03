# Interactive fish abbreviations.
if status is-interactive
    # ── General ────────────────────────────────────────────────────────
    abbr -a e exit
    abbr -a c clear
    abbr -a s 'exec fish'
    abbr -a .. 'cd ..'
    abbr -a ... 'cd ../..'

    # ── Git ────────────────────────────────────────────────────────────
    abbr -a gs 'git status --short --branch'
    abbr -a ga 'git add'
    abbr -a gd 'git diff'
    abbr -a gds 'git diff --staged'
    abbr -a gl 'git log --oneline --decorate -10'
    abbr -a gcm --set-cursor 'git commit -m "%"'

    # ── Dnf ───────────────────────────────────────────────────────
    abbr -a ds 'dnf search'
    abbr -a di 'sudo dnf install'
    abbr -a dr 'sudo dnf remove'
    abbr -a dar 'sudo dnf autoremove'
    abbr -a du 'sudo dnf upgrade --refresh'
    abbr -a dl pkgs
end
