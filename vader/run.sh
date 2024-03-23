#!/usr/bin/env bash

export tmp=$(mktemp -d)
export PLUGINS="junegunn/vader:$PLUGINS"

cat <<EOF > .vimrc
filetype off
set rtp+=.
set rtp+=vader.vim
EOF

old_ifs="$IFS"
IFS=':'
for plugin in $PLUGINS; do
    git clone --depth 1 "https://github.com/$plugin.git" "$tmp/$plugin"
    echo "set rtp+=$tmp/$plugin" >> .vimrc
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
