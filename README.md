# Repository to backup my PC configuration files
The idea is borrowed [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

## Setup new system(right now works with ubuntu-based distro)

1. Download helper script

```bash
wget https://raw.githubusercontent.com/rodmax/dotfiles/master/scripts/setup.sh -O /tmp/setup.sh
chmod +x /tmp/setup.sh
```

2. Install initial set of programs
Run `/tmp/setup.sh run_{number}` commands step by step

3. Install vim plugins

    Open vim and run `:PlugInstall`

4. Install "shellcheck"

    apt repository is out of date
    so install pre-compiled [Linux, x86_64 binary](https://github.com/koalaman/shellcheck#installing) to `$HOME/bin` instead
5. JMeter
This repo provide bin wrapper and desktop icon for JMeter tool
If you want use it, please donwload last version to `~/tools/jmeter/` folder
