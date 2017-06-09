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

    /// Tasks logger
    let logger: Logger?

    /// Creates new instance with configuration loaded from file.
    /// The given file must be valid yaml.
    ///
    /// - Parameters:
    ///   - configurationFile: Path for yaml configuration file
    ///   - logger: Tasks logger
    /// - Parameter configurationFile:
    /// - Throws: MekosError when given path is not valid yaml file
    public init(configurationFile: Path, logger: Logger? = nil) throws {
        // Read file content
        let configuration: String = try configurationFile.read()

        // Try to interpret file content as yaml
        guard let yaml = try Yams.load(yaml: configuration) as? [String: Any] else {
            throw MekosError.invalidConfigurationFile
        }

        self.tasksConfiguration = yaml
        self.logger = logger
    }

    /// Creates new instance with given configuration.
    /// The configuration must match the yaml spec.
    ///
    /// - Parameters:
    ///   - tasksConfiguration: Yaml format configuration
    ///   - logger: Tasks logger
    public init(tasksConfiguration: TasksConfiguration, logger: Logger? = nil) {
        self.tasksConfiguration = tasksConfiguration
        self.logger = logger
    }

    internal func configure(task: TaskType.Type, for key: String) throws -> TaskType? {
        // Search given configuration for requested key
        guard let configuration = tasksConfiguration[key] else {
            print("No configuration for `\(key)` key was provided. Skipping.")
            return nil
        }

        var configuredTask = try task.init(configuration: configuration)

        configuredTask.logger = logger

        return configuredTask
    }
}
