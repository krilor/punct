#/usr/bin/env bash
set -e

# same as the punct alias
function _punct {
   /usr/bin/git --git-dir=$HOME/.punct/ --work-tree=$HOME $@
}

# "setup" punct
function setup() {

    # init repo
    if [ ! -d $HOME/.punct ]; then
        echo "Making bare git repo in $HOME/.punct"
        git init --bare $HOME/.punct
    fi

    _punct config status.showUntrackedFiles no


    # alias
    echo "Ensuring alias in $HOME/.bashrc"

    grep -Eq '^alias punct=' $HOME/.bashrc &&
    sed -i "s/^alias punct=.*/alias punct='\/usr\/bin\/git --git-dir=\$HOME\/.punct\/ --work-tree=\$HOME'/" $HOME/.bashrc ||
    echo "alias punct='/usr/bin/git --git-dir=\$HOME/.punct/ --work-tree=\$HOME'" >> $HOME/.bashrc


    # bash-completion
    completion_file=$HOME/.local/share/bash-completion/completions/punct
    if [ ! -f $completion_file ]; then
        echo "source /usr/share/bash-completion/completions/git" > $completion_file
        echo "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main punct" >> $completion_file
    fi

    echo "Done! You probably want to source ~/.bashrc now"
}

# "unsetup" punct
function remove(){
    echo "Removing repo, alias and autocomplete"
    rm -rf ~/.punct
    sed -i "/^complete .* punct$/d" ~/.bashrc
    sed -i "/^alias punct=/d" ~/.bashrc
    echo "Done"
}

case "$1" in
    setup)
        setup
        ;;
    remove)
        remove
        ;;
    *)
       echo "Usage: $0 {setup|remove}"
esac

exit 0
