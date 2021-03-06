# remove existing symbolic links, if they exist
rm -f ~/.stack/build-plan
rm -f ~/.stack/build-plan-cache
rm -f ~/.stack/indices
rm -f ~/.stack/precompiled
rm -f ~/.stack/setup-exe-cache
rm -f ~/.stack/setup-exe-src
rm -f ~/.stack/snapshots
rm -f ~/.stack/global-project
rm -f ~/.stack/programs

rm -f ~/.hoogle
rm -f ~/.cabal
rm -f ~/.cache/cabal-helper

# create symbolic links
mkdir ~/.stack
ln -s /modules/cs141/.stack/build-plan ~/.stack/build-plan
ln -s /modules/cs141/.stack/build-plan-cache ~/.stack/build-plan-cache
ln -s /modules/cs141/.stack/indices ~/.stack/indices
ln -s /modules/cs141/.stack/precompiled ~/.stack/precompiled
ln -s /modules/cs141/.stack/setup-exe-cache ~/.stack/setup-exe-cache
ln -s /modules/cs141/.stack/setup-exe-src ~/.stack/setup-exe-src
ln -s /modules/cs141/.stack/snapshots ~/.stack/snapshots
ln -s /modules/cs141/.stack/global-project ~/.stack/global-project
ln -s /modules/cs141/.stack/programs ~/.stack/programs

ln -s /modules/cs141/.hoogle ~/.hoogle
ln -s /modules/cs141/.cabal ~/.cabal
ln -s /modules/cs141/.cache/cabal-helper ~/.cache/cabal-helper

# install Atom packages
apm update --no-confirm
apm install atom-ide-ui
apm install language-haskell
apm install ide-haskell-hie
