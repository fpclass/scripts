# remove an existing .stack folder if there is one
rm -f ~/.stack

# Update .bashrc to add STACK_ROOT
echo Updating .bashrc...
if grep -q 'export STACK_ROOT=/modules/cs141/2021/.stack/' ~/.bashrc; then
    echo Not required
else
    echo 'export STACK_ROOT=/modules/cs141/2021/.stack/' >> ~/.bashrc
    echo Done
fi

# install VSCode extensions
echo Installing VSCode extensions...
code --uninstall-extension haskell.haskell
code --uninstall-extension justusadam.language-haskell
code --install-extension justusadam.language-haskell@3.3.0
code --install-extension haskell.haskell@1.2.0
code --install-extension MS-vsliveshare.vsliveshare-pack@0.4.0

# install Atom packages
apm update --no-confirm
apm install atom-ide-ui
apm install language-haskell
apm install haskell

echo Setup completed. Please close all active terminal sessions and start a new one to ensure the changes take effect.
