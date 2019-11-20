# Repository to backup my PC configuration files
The idea is borrowed [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

## Setup new system(right now works with ubuntu-based distro)

1. Download helper script

```bash
wget https://raw.githubusercontent.com/rodmax/dotfiles/master/scripts/setup.sh -o /tmp/setup.sh
chmod +x /tmp/setup.sh
```

2. Install initial set of programs

```bash
/tmp/setup.sh run_0
```

3. Put SSH key to github account

```bash
# Copying...
cat ~/.ssh/id_rsa.pub
...
# And paste to your profile on github.com
```

4. Clone and init dotfiles  repository

```bash
/tmp/setup.sh run_1
```

5. Install ohmyzsh

```bash
/tmp/setup.sh run_1
```

6. Install node + nvm

```bash
/tmp/setup.sh run_2
```

7. Install vim plugins

Open vim and run `:PlugInstall`
