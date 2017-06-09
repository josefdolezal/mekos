//
//  Dotfile.swift
//  mekos
//
//  Created by Josef Dolezal on 09/06/2017.
//
//

import PathKit

/// Represents original dotfile (link destination)
struct Dotfile {
    /// Dotfile link destination (original file)
    let destination: Path

    /// Creates internal dotfile representation.
    ///
    /// - Parameter configuration: Dotfile configuration. Currently only path is supported.
    /// - Throws: MekosError if configuration is not valid
    init(configuration: Any) throws {
        // Try to retrieve file path from given configuration
        guard let path = configuration as? String else {
            throw MekosError.invalidConfigurationFile
        }

        // Destination path must be saved as absolute
        self.destination = Path(path).absolute()
    }
}
