# mekos [![Build Status](https://travis-ci.com/josefdolezal/mekos.svg?token=AxpSW7yys3aiQpPG9zMW&branch=master)](https://travis-ci.com/josefdolezal/mekos)

`mekos` is an automation library for macOS written in Swift. The main purpose is to automate process of clean OS bootstrap. But it's not all! You can also create dynamic environments or configuration scrips.

## Usage

Mekos is currently library with simple DSL, which you include in your own scripts, for example with [Marathon](https://github.com/JohnSundell/Marathon). Just import `MekosFramework` to your Swift script and use the DSL:

``` swift
import MekosFramework

// Update brew repositories
system.brew.update()

// Install Apps from AppStore & brew
system.brew.install(["swiftenv", "swiftlint", "sourcery"])
system.appStore.install(["Slack", "Xcode", "Tweetbot", "Frank DeLoupe"])

// Setup Exposé
system.expose.topLeft(do: .missionControl)
system.expose.topRight(do: .none)
system.expose.bottomLeft(do: .applicationWindows)
system.expose.bottomRight(do: .desktop)
```

## What's in the box? :package:

Mekos is still in developments and only few tools are supported now. However, we are working hard to cover most of generally used functions. List of currently supported functions:

* System
  * Expose - Set system hot corners from your script
  * Install
    * Brew - Install packages via brew
    * AppStore - Automatically install apps from AppStore
