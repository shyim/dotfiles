set -U fish_greeting ""

status is-login; and begin
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
    export BUILDKIT_PROGRESS=plain

    function kn-switch
        kubectl config set-context --current --namespace=$argv
    end

    function kc-switch
        kubectl config use-context $argv
    end

    function awsp
        set -gx AWS_PROFILE (aws configure list-profiles | fzf -1)
        echo "switched to profile: $AWS_PROFILE"
    end

    alias sudo="sudo --preserve-env=TERMINFO"

    fish_add_path $HOME/go/bin
    fish_add_path /opt/homebrew/bin
    fish_add_path $HOME/.bun/bin
end

status is-interactive; and begin
    alias la 'lsd -A'
    alias ll 'lsd -l'
    alias lla 'lsd -lA'
    alias llt 'lsd -l --tree'
    alias ls lsd
    alias lt 'lsd --tree'

    if test "$TERM" != dumb
        eval (starship init fish)
    end

    atuin init fish --disable-up-arrow | source
end
