# punct

[dot-file](https://en.wikipedia.org/wiki/Dot_file) version control using git. This repo codifies a way to track and version control dot-files in git. It is inspired by this [Hacker News thread](https://news.ycombinator.com/item?id=11071754) and works with minor setup:

* a bare git repo with a little bit of local configuration in `~/.punct`
* a simple `alias punct='/usr/bin/git --git-dir=$HOME/.punct/ --work-tree=$HOME'`

In addition, I've added [bash autocomplete](https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html) by wrapping gits autocomplete.

If you want to know the details of how this works, check out this [nice post](https://www.atlassian.com/git/tutorials/dotfiles) by [Nicola Paolucci](https://twitter.com/durdn).

## Prerequisites

* bash
* bash-autocomplete

### Support for other shells

This technique can be used in other shells like zsh. The current setup script provided here in this repo is only supporting bash because it is what I need. Contributions are welcome.

## Installing

punct isn't really something that you install, it's just a bit of configuration in your shell/environment.
The script [punct.sh](./punct.sh) can be used to do the required setup or remove the configuration alltogether.

```bash
# first, get the script and make it executable
wget https://raw.githubusercontent.com/krilor/punct/main/punct.sh
chmod +x punct.sh

# then do the setup
./punct.sh setup
# source .bashrc to get the alias and autocomplete working right away
. ~/.bashrc
# start using punct
punct status

# if you want to remove the setup, you can do
./punct.sh remove

```

## Usage

When using punct to add/remove files, it's always helps to change the shell working directory to home (~).
Otherwise, you'll have to specify absolute paths. The following examples assume that the current working directory is home.

You can use all git commands, so the following is just a few examples.

### Adding a remote

The repo can be wherever you want. Add it like so.

```
punct remote add origin git@github.com:krilor/.punct.git
```

If the remote repo is empty, your can push your main branch like so

```
punct branch -M main
punct push -u origin main
```

If the remote repo already contains config, then you can fetch it

```bash
punct fetch origin
punct checkout main
```

The checkout might give you a warning if there are files that overlap

> error: The following un-tracked working tree files would be overwritten by checkout:
>
>	.vimrc
>
> Please move or remove them before you switch branches.
> Aborting

You can force replace the un-tracked files like so (or manually delete/backup them as you see fit)

```
punct checkout main -f
```

### Adding files (or folders)

This example assumes that you want to add `~/.vimrc` into punct version control.

```bash
punct add .vimrc
punct commit -m "start tracking .vimrc"
```

### Viewing changes (to tracked files)

Git diff to the rescue.

```
punct diff
```

### Viewing tracked files

Use ls-files.

```
punct ls-files
```

## Other options for versioning dot-files

You might want to look into other options for managing your dot-files. Here are a few:

* https://dotty.cloud/
* https://github.com/knoebber/dotfile
* https://medium.com/@waterkip/managing-my-dotfiles-with-gnu-stow-262d2540a866

## Contributions

Very welcome! Please open an issue first.
