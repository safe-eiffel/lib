#!/bin/sh
# init lib subtree
if [ -d .git]; then
  echo "> already a git repository"
else
  echo "git init"
  git init
fi


if [-f .gitignore ]; then
  echo ">already a .gitignore"
else
git init
  echo "adding a .gitignore"
  touch .gitignore
  git add .gitignore
  git commit -m "Initial commit"
fi

# branches named '' are for subtree branches

echo "creating kernel subtree"
# kernel
  git remote add -f kernel https://github.com/safe-eiffel/kernel.git
  git merge -s ours --no-commit kernel/master
  git read-tree --prefix=kernel/ -u kernel/master
  git commit -m "Subtree merged in kernel"

echo "creating ecli subtree"
# ecli
 git remote add -f ecli https://github.com/safe-eiffel/ecli.git
 git merge -s ours --no-commit ecli/master
 git read-tree --prefix=ecli/ -u ecli/master
 git commit -m "Subtree merged in ecli"

echo "creating epom subtree"
# epom
  git remote add -f epom https://github.com/safe-eiffel/epom.git
  git merge -s ours --no-commit epom/master
  git read-tree --prefix=epom/ -u epom/master
  git commit -m "Subtree merged in epom"

echo "creating epdf subtree"
# epdf
  git remote add -f epdf https://github.com/safe-eiffel/epdf.git
  git merge -s ours --no-commit epdf/master
  git read-tree --prefix=epdf/ -u epdf/master
  git commit -m "Subtree merged in epdf"

echo "creating fo subtree"
# fo
  git remote add -f fo https://github.com/safe-eiffel/fo.git
  git merge -s ours --no-commit fo/master
  git read-tree --prefix=fo/ -u fo/master
  git commit -m "Subtree merged in fo"

echo "creating ecurses subtree"
# ecurses
  git remote add -f ecurses https://github.com/safe-eiffel/ecurses.git
  git merge -s ours --no-commit ecurses/master
  git read-tree --prefix=ecurses/ -u ecurses/master
  git commit -m "Subtree merged in ecurses"


