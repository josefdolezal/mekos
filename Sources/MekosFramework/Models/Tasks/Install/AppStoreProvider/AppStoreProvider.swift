//
//  AppStoreProvider.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 15/06/2017.
//

import Foundation


struct AppStoreProvider: ProviderType {

    private static let appStoreCommand = "mas"

    var logger: Logger?

    private let commands: [ShellCommand]

    init(installables: [String]) {
        // Map app id's to shell install commands
        self.commands = installables.map { installable in
            return ShellCommand(command: AppStoreProvider.appStoreCommand,
                                arguments: [AppStoreCommand.install.rawValue, installable])
        }
    }

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
                logger?.log(warning: "The `\(installable)` could not be installed with AppStore.")
            }
        }
    }
}

/// MAS CLI API wrapper
///
/// - install: Installs new package
enum AppStoreCommand: String {
    case install
}
