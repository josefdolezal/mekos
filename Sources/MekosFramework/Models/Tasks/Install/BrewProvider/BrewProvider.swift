//
//  BrewProvider.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 12/06/2017.
//

import Foundation

/// Provider of brew software, installs given packages.
struct BrewProvider {
    /// Default brew command name
    private static let brewCommand = "brew"

    /// Logging service
    var logger: Logger?

    /// Brew installation commands
    private let commands: [ShellCommand]

    /// Creates new provider which can install brew packages.
    /// The installation itself must be executed manually.
    ///
    /// - Parameter installables: Packages which should be installed with brew
    init(installables: [String]) {
        // Create shell install commands from list of installables
        self.commands = installables.map { installable in
            return ShellCommand(command: BrewProvider.brewCommand,
                                arguments: [BrewCommand.install.rawValue, installable])
        }
    }

    /// Run installation of given commands
    func install() {
        // Install each brew software independently
        for command in commands {
            // Remove the `install` action from arguments
            let installable = command.arguments.dropFirst().first ?? "<unknown>"

            logger?.log(message: "Running brew installation of `\(installable)`.")

            do {
                logger?.log(message: try command.execute())
                logger?.log(success: "The `\(installable)` successfully installed.")
            } catch {
                logger?.log(warning: "The `\(installable)` could not be installed with brew.")
            }
        }
    }
}

/// Brew CLI API wrapper
///
/// - install: Installs new package
enum BrewCommand: String {
    case install
}
