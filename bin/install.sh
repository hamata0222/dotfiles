#!/bin/bash

pushd $(dirname ${BASH_SOURCE:-$0})

# Create link to dotfiles at home directory.
for f in `find $(cd ../; pwd) -name '.*' -type f`
do
    ln -sfv $f ${HOME}
done

popd
