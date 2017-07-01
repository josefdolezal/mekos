# mekos [![Build Status](https://travis-ci.com/josefdolezal/mekos.svg?token=AxpSW7yys3aiQpPG9zMW&branch=master)](https://travis-ci.com/josefdolezal/mekos)

`mekos` is an automation tool for macOS.
It allows you to create installation bootstrap file, dynamic app environments or simple configuration scripts.

## Installation

1. Clone repository
2. Run `make build`
3. Prepare `.mekos.yaml` file
4. Run `mekos` from your terminal
5. Have fun :tada:

## Configuration file

`mekos` works with its configuration file.
This file must be named `.mekos.yaml` and must be placed in directory where `mekos` command is executed at.

### Task

Available actions are called `Task`.
Tasks are configurable units of work.
Currently supported tasks are

* `Dotfiles` - Links dotfiles to your home directory
* `Install` - Installs specified software from `brew` and/or `Mac AppStore` providers
* `System` - Groups system configuration services

### Format

```yaml
dotfiles:
  - .gitconfig
  - .zshrc
  - .vimrc

install:
    brew:
        - swiftlint
        - carthage
        - swiftenv
    
    app_store:
        - 2252567676542
        - 9114578639323

system:
    expose:
        top_left: desktop
        top_right: all_windows
        bottom_left: screen_saver
        bottom_right: notification_center
```
