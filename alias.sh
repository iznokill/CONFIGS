#!/bin/sh

echo "##############################alias table######################################\n" >> ~/.bashrc
echo "alias gccc=\"gcc -Werror -Wall -Wextra -pedantic -std=c99\"" >> ~/.bashrc
echo "alias gcccf=\"gccc -g -fsanitize=address -fsanitize=leak\"" >> ~/.bashrc
echo "eval \"$\(thefuck --alias\)\"" >> ~/.bashrc
echo "alias cl=\"clang-format -i\"" >> ~/.bashrc
echo "alias rrm=\"mv -f -t ~/Trash\"" >> ~/.bashrc
echo "alias cclean=\"rm  -ir ~/Trash/\"" >> ~/.bashrc
echo "alias clean=\"rm -r ~/Trash/\"\n" >> ~/.bashrc
echo "#############################alias table#######################################\n\n" >> ~/.bashrc
source ~/.bashrc
