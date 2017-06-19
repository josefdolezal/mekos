//
//  ServiceType.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 19/06/2017.
//

/// Common interface for system services
protocol ServiceType {
    /// Logging service
    var logger: Logger? { get set }

    /// Creates new service with given configuration
    ///
    /// - Parameter configuration: User specified configuration for service
    /// - Throws: MekosError on failure
    init(configuration: Any) throws

    /// Runs the service
    ///
    /// - Throws: MekosError on runtime error
    func run() throws
}
