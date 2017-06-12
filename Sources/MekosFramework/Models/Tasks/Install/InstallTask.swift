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

    let installables: [String]

    init(configuration: Any) throws {
        guard let installables = configuration as? [String] else {
            throw MekosError.invalidConfigurationFile
        }

        self.installables = installables
    }

    func run() throws {

        logger?.log(message: "Running brew software installation.")

        var brewProvider = BrewProvider(installables: installables)

        brewProvider.logger = logger
        brewProvider.install()

        logger?.log(message: "Brew installation finished.")
    }
}
