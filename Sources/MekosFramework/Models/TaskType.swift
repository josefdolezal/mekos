//
//  TaskType.swift
//  mekos
//
//  Created by Josef Dolezal on 08/06/2017.
//
//

import Foundation

/// Interface of runnable tasks
protocol TaskType {
    /// Creates new task instance with given configuration.
    ///
    /// - Parameter configuration: Task configuration
    /// - Throws: MekosError on invalid configuration
    init(configuration: Any) throws

    /// Runs task
    ///
    /// - Throws: MekosError on runtime error
    func run() throws

    /// Task logging service
    var logger: Logger? { get set }
}
