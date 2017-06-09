//
//  Configuration.swift
//  mekos
//
//  Created by Josef Dolezal on 08/06/2017.
//
//

import Yams
import PathKit

/// Runner configuration for available tasks.
public struct Configuration {
    /// Shortcut for yaml file format
    public typealias TasksConfiguration = [String: Any]

    /// Yaml representation of tasks configuration
    let tasksConfiguration: TasksConfiguration

    /// Creates new instance with configuration loaded from file.
    /// The given file must be valid yaml.
    ///
    /// - Parameter configurationFile: Path for yaml configuration file
    /// - Throws: MekosError when given path is not valid yaml file
    public init(configurationFile: Path) throws {
        // Read file content
        let configuration: String = try configurationFile.read()

        // Try to interpret file content as yaml
        guard let yaml = try Yams.load(yaml: configuration) as? [String: Any] else {
            throw MekosError.invalidConfigurationFile
        }

        self.tasksConfiguration = yaml
    }

    /// Creates new instance with given configuration.
    // The configuration must match the yaml spec.
    ///
    /// - Parameter tasksConfiguration: Yaml format configuration
    public init(tasksConfiguration: TasksConfiguration) {
        self.tasksConfiguration = tasksConfiguration
    }

    internal func configure(task: TaskType.Type, for key: String) throws -> TaskType? {
        // Search given configuration for requested key
        guard let configuration = tasksConfiguration[key] else {
            print("No configuration for `\(key)` key was provided. Skipping.")
            return nil
        }

        return try task.init(configuration: configuration)
    }
}
