//
//  SystemTask.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 17/06/2017.
//

/// System task covers all system configurations.
/// These configurations are grouped into Service classes and runned independentli.
struct SystemTask: TaskType {
    /// Task logging service
    var logger: Logger?

    /// Creates new system configuration task instance with given configuration.
    ///
    /// - Parameter configuration: Task configuration
    /// - Throws: MekosError on invalid configuration
    init(configuration: Any) throws {

    }

    /// Runs system configuration task
    ///
    /// - Throws: MekosError on runtime error
    func run() throws {

    }
}
