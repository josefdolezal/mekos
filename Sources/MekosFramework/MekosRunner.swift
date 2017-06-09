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
        let tasks = try AvalaibleTask.all.flatMap { task in
            return try configuration.configure(task: task.type, for: task.identifier)
        }

        // Run tasks one by other
        for task in tasks {
            try task.run()
        }
    }
}
