//
//  BrewInstaller.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 12/06/2017.
//

import Foundation

/// Provider of brew software, installs given packages.
public struct BrewInstaller {
    /// Default brew command name
    private static let brew = "brew"

    /// Run installation of given commands
    public func install(_ packages: [String]) {
        try! BrewInstaller.execute(subcommand: "install", arguments: packages)
    }

    /// Executes brew subcommand with given arguments
    ///
    /// - Parameters:
    ///   - subcommand: Name of brew subcommand (eg. `install`)
    ///   - arguments: Subcommand arguments (eg. swiftenv)
    /// - Returns: Command standard output
    /// - Throws: ShellError
    @discardableResult
    private static func execute(subcommand: String, arguments: [String] = []) throws -> String {
        let command = Shell(command: brew, arguments: arguments)

        return try command.execute()
    }
}
