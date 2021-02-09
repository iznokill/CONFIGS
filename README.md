# CONFIGS

This is the most basic .vimrc you could have that works for both c files and Makefiles.
Do this !!!!!!!!!!:

1 -Installation requires Git and triggers git clone for each configured repository to ~/.vim/plug.vim/ by default. Curl is required for search.

Set up Vundle:

2 - ```curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim```

      3 - launch vim and do < :PlugInstall > to install plugins

      4 - for autocomplete to work you'll have to open a file with the extension of your choice then write < TabNine::sem>




# CLANG-FORMAT

      my vimrc contains a plugin that automatically clang-formats your C/C++ files
      you should copy Clang/.clang-format to $HOME to have it work correctly
      for python you should update pip
      and for other extensions you should get whatever does the same to them

      ENJOY!!!
