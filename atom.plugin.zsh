if  [[ "$OSTYPE" = darwin* ]]; then
    local _atom_darwin_paths > /dev/null 2>&1
    _atom_darwin_paths=(
        "/usr/local/bin/atom"
        "/Applications/atom.app/Contents/macos/atom"
        "/Applications/atom.app/Contents/macos/atom"
        "/Applications/atom.app/Contents/macos/atom"
        "$HOME/Applications/atom.app/Contents/macos/atom"
        "$HOME/Applications/atom.app/Contents/macos/atom"
        "$HOME/Applications/atom.app/Contents/macos/atom"
    )
    for _atom_path in $_atom_darwin_paths; do
        if [[ -a $_atom_path ]]; then
            atom () { "$_atom_path" $* }
            alias atom=atom
            break
        fi
    done

fi

alias atom='atom .'

find_project()
{
    local PROJECT_ROOT="${PWD}"
    local FINAL_DEST="."

    while [[ $PROJECT_ROOT != "/" && ! -d "$PROJECT_ROOT/.git" ]]; do
        PROJECT_ROOT=$(dirname $PROJECT_ROOT)
    done

    if [[ $PROJECT_ROOT != "/" ]]; then
        local PROJECT_NAME="${PROJECT_ROOT##*/}"

        local ATOM_DIR=$PROJECT_ROOT
        while [[ $ATOM_DIR != "/" && ! -f "$ATOM_DIR/$PROJECT_NAME.atom-project" ]]; do
            ATOM_DIR=$(dirname $ATOM_DIR)
        done

        if [[ $ATOM_DIR != "/" ]]; then
            FINAL_DEST="$ATOM_DIR/$PROJECT_NAME.atom-project"
        else
            FINAL_DEST=$PROJECT_ROOT
        fi
    fi

    atom $FINAL_DEST
}

alias stp=find_project
