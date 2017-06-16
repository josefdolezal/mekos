//
//  AppStoreProvider.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 15/06/2017.
//

import Foundation

/// AppStore software installation provider.
/// As official API is not provided by Apple, this provider calls `mas` CLI wrapper
/// for App Store API under the hood.
struct AppStoreProvider: ProviderType {
    /// Logging service
    var logger: Logger?

    /// Installation commands for `mas`
    private let commands: [ShellCommand]

    /// Creates new instance of App Store provider
    ///
    /// - Parameter installables: List of software which should be installed
    init(installables: [String]) {
        // Map app id's to shell install commands
        self.commands = installables.map { installable in
            return ShellCommand(command: AppStoreCommand.binName,
                                arguments: [AppStoreCommand.install.rawValue, installable])
        }
    }

    /// Installs software from App Store
    func install() {
        // Install each App Store app separately
        for command in commands {
            // Get app id
            let installable = command.arguments.dropFirst().first ?? "<unknown>"

            logger?.log(message: "Running App Store installation of `\(installable)`.")

            // Try to run shell installation
            do {
                logger?.log(message: try command.execute())
                logger?.log(success: "The `\(installable)` successfully installed.")
            } catch {
                logger?.log(warning: "The `\(installable)` could not be installed with App Store.")
            }
        }
    }
}

/// MAS CLI API wrapper
///
/// - install: Installs new package
enum AppStoreCommand: String {
    case install

    /// AppStore `mas` CLI wrapper binary path
    static let binName = "mas"
}
