# remove an existing .stack folder if there is one
rm -f ~/.stack

# Update .bashrc to add STACK_ROOT
echo Updating .bashrc...
echo 'export STACK_ROOT=/modules/cs141/2021/stack-data/' >> ~/.bashrc

# install VSCode extensions
echo Installing VSCode extensions...
code --log off --uninstall-extension justusadam.language-haskell
code --log off --uninstall-extension haskell.haskell
code --log off --install-extension justusadam.language-haskell@3.3.0
code --log off --install-extension haskell.haskell@1.2.0

echo Setup completed.