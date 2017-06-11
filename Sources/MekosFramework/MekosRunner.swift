//
//  MekosRunner.swift
//  mekos
//
//  Created by Josef Dolezal on 07/06/2017.
//
//

import PathKit

/// MacOS tasks runner.
/// Runs tasks specified by given configuration.
public struct MekosRunner {

    /// Tasks configuration
    let configuration: Configuration

    /// Creates new runner with given tasks configuration
    ///
    /// - Parameter configuration: Tasks configuration
    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    /// Runs tasks specified by configuration.
    ///
    /// - Throws: MekosError when task cannot be configured or on runtime error
    public func run() throws {
        // Create tasks with specified configurations
        let tasks = try AvalaibleTask.all.flatMap { task -> (AvalaibleTask, TaskType)? in
            guard let configuredTask = try configuration.configure(task: task.type, for: task.identifier) else {
                return nil
            }

            return (task, configuredTask)
        }

        // Run tasks one by other
        for task in tasks {
            configuration.logger?.log(message: "Running task `\(task.0.identifier)`.")
            try task.1.run()
            configuration.logger?.log(message: "Task `\(task.0.identifier)` finished successfully.")
        }
    }
}
