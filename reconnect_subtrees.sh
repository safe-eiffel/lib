#!/bin/sh

# kernel
  git remote add -f kernel https://github.com/safe-eiffel/kernel.git
  git merge -s ours --no-commit --squash kernel/master
  git pull -s subtree kernel master
# ecli
  git remote add -f ecli https://github.com/safe-eiffel/ecli.git
  git merge -s ours --no-commit --squash ecli/master
  git pull -s subtree ecli master
# epom
  git remote add -f epom https://github.com/safe-eiffel/epom.git
  git merge -s ours --no-commit --squash epom/master
  git pull -s subtree epom master
# epdf
  git remote add -f epdf https://github.com/safe-eiffel/epdf.git
  git merge -s ours --no-commit --squash epdf/master
  git pull -s subtree epdf master
# fo
  git remote add -f fo https://github.com/safe-eiffel/fo.git
  git merge -s ours --no-commit --squash fo/master
  git pull -s subtree fo master
# ecurses
  git remote add -f ecurses https://github.com/safe-eiffel/ecurses.git
  git merge -s ours --no-commit --squash ecurses/master
  git pull -s subtree ecurses master
