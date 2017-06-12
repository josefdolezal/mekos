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
        for installable in installables {
            logger?.log(message: "Running brew installation of `\(installable)`.")

            if execShellCommand("/usr/local/bin/brew", arguments: ["install", installable]) {
                logger?.log(success: "The `\(installable)` successfully installed.")
            } else {
                logger?.log(error: "The `\(installable)` could not be installed with brew.")
            }
        }
    }

    private func execShellCommand(_ command: String, arguments: [String]) -> Bool {
        let task = Process()
        let pipe = Pipe()

        task.launchPath = command
        task.arguments = arguments
        task.standardOutput = pipe

        task.launch()
        task.waitUntilExit()

        if let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) {
            logger?.log(message: output)
        }

        return task.terminationStatus == 0 ? true : false
    }
}
