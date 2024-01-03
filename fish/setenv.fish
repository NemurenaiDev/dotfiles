#!/usr/bin/env fish

set envFile "$DOTFILES_PATH/.env"

if test -f $envFile
    set lines (cat $envFile | grep -v "^#")

    for line in $lines
        set parts (string split -m1 "=" -- $line)

        if test (count $parts) -eq 2
            set key (string trim $parts[1])
            set value (string trim $parts[2])
            set -gx $key "$value"
        end
    end
else
    echo "File $envFile not found"
end
