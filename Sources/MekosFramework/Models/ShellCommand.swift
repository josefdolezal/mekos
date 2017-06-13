//
//  ShellCommand.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 13/06/2017.
//

import Foundation

/// Shell command abstraction.
struct ShellCommand {
    /// Command which will be executed by user's default shell
    let command: String

    /// Command arguments
    let arguments: [String]

    /// Path to current user's default shell
    private static let defaultShellPath = "/usr/bin/env"

    /// Expected command rtermination code on success
    private static let successfullExitCode = 0

    /// Creates new instance representing shell command.
    ///
    /// - Parameters:
    ///   - command: Shell command name
    ///   - arguments: Arguments for given command
    init(command: String, arguments: [String]) {
        self.command = command
        self.arguments = arguments
    }

    /// Creates new instance of user's deafult shell and runs command with given arguments.
    /// This operation is synchronous. May be executed multiple times.
    ///
    /// - Returns: Shell command standard output
    /// - Throws: ShellCommandError when command execution fails (i.e. command returns code different form 0)
    func execute() throws -> String {
        // Create new process and output pipe
        let task = Process()
        let stdout = Pipe()
        let stderr = Pipe()

        task.launchPath = ShellCommand.defaultShellPath
        task.arguments = [command] + arguments
        // Log both standerd output and error into created pipe
        task.standardOutput = stdout
        task.standardError = stderr

        // Launch shell command synchronously
        task.launch()
        task.waitUntilExit()

        // Throw error when command returned unsuccessfull status code
        if Int(task.terminationStatus) != ShellCommand.successfullExitCode {
            throw ShellCommandError.unsuccessfullStatusCode(
                command: command,
                error: String(data: stderr.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
            )
        }

        // Return standard output value
        return String(data: stdout.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
    }
}

/// Shell command execution
///
/// - unsuccessfullStatusCode: Thrown when unsuccessfull code is returned from command execution
enum ShellCommandError: Error, CustomStringConvertible {
    case unsuccessfullStatusCode(command: String, error: String?)

    var description: String {
        switch self {
        case let .unsuccessfullStatusCode(command, description):
            if let description = description {
                return "Shell command `\(command)` execution failed with message: \(description)"
            }

            return "Shell command `\(command)` execution failed."
        }
    }
}
