# installs the scripts into /modules/cs141 folder
cp haskell-setup-1920.sh /modules/cs141
cp haskell-setup-2021.sh /modules/cs141
rm -f /modules/cs141/haskell-setup.sh
ln -s /modules/cs141/haskell-setup-1920.sh /modules/cs141/haskell-setup.sh
cp update-paths.sh /modules/cs141

# give haskell-setup.sh the correct permissions
chmod o+rx /modules/cs141/haskell-setup-1920.sh
chmod o+rx /modules/cs141/haskell-setup-2021.sh
chmod o+rx /modules/cs141/haskell-setup.sh
