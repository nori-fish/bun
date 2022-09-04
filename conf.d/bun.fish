function _bun_install --on-event bun_install --on-event bun_update
    if command --query bun
        command bun upgrade
    else
        echo "Downloading bun binary..."
        curl -s https://bun.sh/install | bash >/dev/null

    end
    set --query BUN_INSTALL
    or set --universal --export BUN_INSTALL $HOME/.bun

    _nori_add_path $BUN_INSTALL/bin
end

function _bun_uninstall --on-event bun_uninstall
    if set --query BUN_INSTALL
        rm -rf $BUN_INSTALL
        set -Ue BUN_INSTALL
    end
    _nori_remove_path $BUN_INSTALL/bin
end
