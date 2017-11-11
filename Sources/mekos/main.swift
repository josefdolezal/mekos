import MekosFramework

// Install Apps from AppStore & brew

system.brew.install(["swiftenv", "swiftlint", "sourcery"])
system.appStore.install(["Slack", "Xcode", "Tweetbot", "Frank DeLoupe"])

// Setup Exposé
system.expose.topLeft(do: .missionControl)
system.expose.topRight(do: .none)
system.expose.bottomLeft(do: .applicationWindows)
system.expose.bottomRight(do: .desktop)
