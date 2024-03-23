#!/usr/bin/env bash

export tmp=$(mktemp -d)
PLUGINS="junegunn/vader.vim:$PLUGINS"
cwd=$(pwd)

cat <<EOF > .vimrc
filetype off
set nocompatible
EOF

echo "set rtp+=$cwd"

old_ifs="$IFS"
IFS=':'
for plugin in $PLUGINS; do
    path="$tmp/$plugin"
    echo "Cloning $plugin to $path"
    gh repo clone "$plugin" "$path"
    echo "set rtp+=$path" >> .vimrc
done
IFS="$old_ifs"


cat <<EOF >> .vimrc
filetype plugin indent on
syntax enable
EOF

echo 'Running vader'
"$EDITOR" -Es -u .vimrc -c "Vader! $TEST_PATTERN"
