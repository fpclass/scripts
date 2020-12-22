# remove an existing .stack folder if there is one
rm -f ~/.stack

# Update .bashrc to add STACK_ROOT
echo Updating .bashrc...
echo 'export STACK_ROOT=/modules/cs141/2021/stack-data/' >> ~/.bashrc

# Just in case someone doesn't follow the instructions, make STACK_ROOT available in this session
export STACK_ROOT=/modules/cs141/2021/stack-data/

# install VSCode extensions
echo Installing VSCode extensions...
code --uninstall-extension haskell.haskell
code --uninstall-extension justusadam.language-haskell
code --install-extension justusadam.language-haskell@3.3.0
code --install-extension haskell.haskell@1.2.0

echo Setup completed. Please close all active terminal sessions and start a new one to ensure the changes take effect.
