#!/usr/bin/env bash

export tmp=$(mktemp -d)
PLUGINS="junegunn/vader.vim:$PLUGINS"

cat <<EOF > .vimrc
filetype off
set rtp+=.
EOF

old_ifs="$IFS"
IFS=':'
for plugin in $PLUGINS; do
    path="$tmp/$plugin"
    git clone --depth 1 "git@github.com:$plugin.git" "$path"
    echo "set rtp+=$path" >> .vimrc
done
IFS="$old_ifs"


cat <<EOF >> .vimrc
filetype plugin indent on
syntax enable
EOF

if [ "$EDITOR" = "neovim" ]; then
    EDITOR=nvim
fi

"$EDITOR" -Es -u .vimrc -c "Vader! $TEST_PATTERN"
