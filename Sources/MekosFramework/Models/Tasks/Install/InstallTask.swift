//
//  InstallTask.swift
//  mekos
//
//  Created by Josef Dolezal on 12/06/2017.
//

import Foundation

/// Automated software installer. Installs software from arbitrary provider.
struct InstallTask: TaskType {
    /// Logging service
    var logger: Logger?

    let configurations: [String: Any]

    init(configuration: Any) throws {
        guard let configurations = configuration as? [String: Any] else {
            throw MekosError.invalidConfigurationFile
        }

        self.configurations = configurations
    }

    func run() throws {
        if let brewInstallables = configurations["brew"] as? [String] {
            logger?.log(message: "Running brew software installation.")

            var brewProvider = BrewProvider(installables: brewInstallables)

            brewProvider.logger = logger
            brewProvider.install()

            logger?.log(message: "Brew installation finished.")
        }

        if let appStoreInstallables = configurations["app_store"] as? [String] {
            logger?.log(message: "Running App Store software installation.")

            var appStoreProvider = AppStoreProvider(installables: appStoreInstallables)

            appStoreProvider.logger = logger
            appStoreProvider.install()

            logger?.log(message: "App Store installation finished.")
        }
    }
}
