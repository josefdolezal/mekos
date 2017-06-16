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

    /// Providers configurations
    private let configurations: [String: Any]

    /// Creates new task with given configuration.
    /// Tryes to configure providers from given configuration.
    ///
    /// - Parameter configuration: Yaml formatted configuration
    /// - Throws: MekosError on invalid configuration
    init(configuration: Any) throws {
        guard let configurations = configuration as? [String: Any] else {
            throw MekosError.invalidConfigurationFile
        }

        self.configurations = configurations
    }

    /// Runs the installation with configured providers
    ///
    /// - Throws: MekosError on failure
    func run() throws {
        // Try to initiate available providers
        for providerType in AvailableProvider.all {
            // Check if current provider is configured by user
            guard let installables = configurations[providerType.identifier] as? [String] else {
                logger?.log(message: "No configuration for `\(providerType.identifier)` provider. Skipping.")
                continue
            }

            logger?.log(message: "Running `\(providerType.identifier)` software installation.")

            // Create provider and run installations
            var provider = providerType.provider.init(installables: installables)

            provider.logger = logger
            provider.install()

            logger?.log(message: "Provider installation finished.")
        }
    }
}
