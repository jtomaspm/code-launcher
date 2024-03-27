# Code Launcher

Simple bash script to launch your favourite editor faster than ever!

## Demo

To be developed...

## Quick Setup Guide

Install/Update:
```
wget https://github.com/jtomaspm/code-launcher/raw/main/install/install.sh && chmod +x install.sh &&./install.sh && rm install.sh
```

Run:
```
codl
```

## Configuration

Config in:
```
~/.config/code-launcher/config.yaml
```

Default config:
```
paths:
- ~/Documents/code/
- ~/.config/
launchers:
- Visual Studio Code;code .
- NeoVim;nvim .
```

### Paths

Paths to where code-launcher will look for folders to open.

Format:
```
<path>
```

### Lanchers

Commands to execute.

Format:
```
<display name>;<command>
```