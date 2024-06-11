functions --erase fish_greeting

functions -c cd oldcd


function pc
    switch $argv[1]
        case "i" "install"
            pikaur -S --nodiff --noedit $argv[2..-1]
        case "r" "remove"
            pikaur -Rns $argv[2..-1]
        case "u" "update"
            sudo pikaur -Syu --nodiff --noedit && notify-send 'Jetbra command ran' && sudo ~/.config/dotfiles/scripts/jetbra
        case "s" "search"
            pikaur -Ss $argv[2..-1]
        case "ls" "list"
            pikaur -Q | grep (string join \| $argv[2..-1])
        case "info"
            pikaur -Qi $argv[2..-1]
        case "clear"
            pikaur -Scc
        case "*"
            echo "Usage: pc [(i|install) | (r|remove) | (u|update) | (s|search) | (ls|list) | info | clear] [packages...]"
    end
end


function resolve_tilda
    echo "$argv" | sed "s|^~|$HOME|"
end
