//
//  ProviderType.swift
//  mekos
//
//  Created by Josef Dolezal on 15/06/2017.
//

/// Common interface for software providers.
protocol ProviderType {
    /// Logging service
    var logger: Logger? { get set }

    /// Creates new software provider
    ///
    /// - Parameter installables: List of specified packages which should be installed
    init(installables: [String])

    /// Installs list of installables given by user
    func install()
}
