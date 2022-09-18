function _bun_install --on-event bun_install --on-event bun_update
    if command --query bun
        command bun upgrade
    else
        echo "Downloading bun binary..."
        curl -s https://bun.sh/install | bash >/dev/null

    end
    set --query BUN_INSTALL
    or set --universal --export BUN_INSTALL $HOME/.bun

    fish_add_path --prepend $BUN_INSTALL/bin
end

function _bun_uninstall --on-event bun_uninstall
    if set --local index (contains --index $BUN_INSTALL/bin $fish_user_paths)
        set --universal --erase fish_user_paths[$index]
    end

    if set --query BUN_INSTALL
        rm -rf $BUN_INSTALL
        set -Ue BUN_INSTALL
    end
end
