#!/usr/bin/env fish

set envFile "$DOTFILES_PATH/.env"

if test -f $envFile
    set lines (cat $envFile)

    for line in $lines
        if test -n "$line"
            if string match -q -- "^#" $line
                echo $line
            else
                set parts (string split -m1 "=" -- $line)

                if test (count $parts) -eq 2
                    set key (string trim $parts[1])
                    set value (string trim $parts[2])
                    set -gx $key $value
                end
            end
        end
    end
else
    echo "File $envFile not found"
end
