# Lingua Franca Plugin for Vim

This Vim plugin provides basic support for Lingua Franca files.
It brings basic syntax highlighting, basic indentation rules and rudimentary text-object support for the target code blocks.

## Installation

The best and easiest solution for installing the Plugin is one of the available Plugin managers for Vim.
If you're using [vim-plug](https://github.com/junegunn/vim-plug), simply add the following:
```Vim
Plug 'lf-lang/lingua-franca.vim'
```

Alternatively, you can install the plugin manually by copying the three directories (ftplugin, ftdetect, syntax) and their contents into:

- `~/.vim/` if you're using Vim
- `~/.config/nvim/` if you're using Neovim
- Or really anywhere in your Vim 'runtimepath'

## Caveats

- There are some bugs with the nested syntax highlighting where some lines aren't highlighted; they likely originate in Vim's syntax highlight engine and I don't think changes at the plugin level can fix them.
- The target language of your file is determined when the filetype is set. So, if you decide to change the target while editing the file, you need to either:
  - do `:set ft=linguafranca`
  - delete and reopen the buffer
  - close and reopen `(n)vim`

## Indentation
Due to the nature of Vim's indentation rules (the fact that they are regex based), those rules are pretty much all “ad-hoc”.
I think what it is there now is better than nothing, but if you find an example of a situation where the automatic indenting isn't satisfying, please open an issue.
