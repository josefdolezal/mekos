//
//  BrewProvider.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 12/06/2017.
//

import Foundation

struct BrewProvider {

    enum BrewCommand {
        case install(String)

        static let launchPath = "/usr/local/bin/brew"

        var action: String {
            switch self {
            case .install: return "install"
            }
        }

        var arguments: [String] {
            switch self {
            case let .install(installable): return [action, installable]
            }
        }
    }

    var logger: Logger?

    private let commands: [BrewCommand]

    init(installables: [String]) {
        // Create install commands from list of installables
        self.commands = installables.map { BrewCommand.install($0) }
    }

    func install() {
        for command in commands {
            logger?.log(message: "Running brew installation of `\(command.arguments)`.")

            if run(command: command) {
                logger?.log(success: "The `\(command.arguments)` successfully installed.")
            } else {
                logger?.log(warning: "The `\(command.arguments)` could not be installed with brew.")
            }
        }
    }

    private func run(command: BrewCommand) -> Bool {
        let task = Process()
        let pipe = Pipe()

        task.launchPath = BrewCommand.launchPath
        task.arguments = command.arguments
        task.standardOutput = pipe
        task.standardError = pipe

        task.launch()
        task.waitUntilExit()

        if let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) {
            logger?.log(message: output)
        }

        return task.terminationStatus == 0 ? true : false
    }
}
