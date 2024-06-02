#!/usr/bin/env fish

set -Ux FZF_DEFAULT_OPTS "\
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
"


if test -f "$DOTFILES_PATH/.env"
    set lines (cat "$DOTFILES_PATH/.env" | grep -v "^#")

    for line in $lines
        set parts (string split -m1 "=" -- $line)

        if test (count $parts) -eq 2
            set key (string trim $parts[1])
            set value (string trim $parts[2])
            set -gx $key "$value"
        end
    end
else
    echo "File $DOTFILES_PATH/.env not found"
end
