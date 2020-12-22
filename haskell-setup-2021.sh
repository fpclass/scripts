# remove an existing .stack folder if there is one
rm -f ~/.stack

# create symbolic links
mkdir ~/.stack
mkdir ~/.stack/pantry
ln -s /modules/cs141/2021/stack-data/pantry/pantry.sqlite3 ~/.stack/pantry/pantry.sqlite3
ln -s /modules/cs141/2021/stack-data/config.yaml ~/.stack/config.yaml
ln -s /modules/cs141/2021/stack-data/programs ~/.stack/programs
ln -s /modules/cs141/2021/stack-data/setup-exe-cache ~/.stack/setup-exe-cache
ln -s /modules/cs141/2021/stack-data/setup-exe-src ~/.stack/setup-exe-src
ln -s /modules/cs141/2021/stack-data/snapshots ~/.stack/snapshots
ln -s /modules/cs141/2021/stack-data/stack.sqlite3 ~/.stack/stack.sqlite3

# install VSCode extensions
echo Installing VSCode extensions...
code --install-extension justusadam.language-haskell@3.3.0
code --install-extension haskell.haskell@1.2.0

echo Setup completed.