//
//  DotfilesTask.swift
//  mekos
//
//  Created by Josef Dolezal on 08/06/2017.
//
//

import PathKit

/// Dotfiles linking task.
/// This tasks creates symbolic links in user's home directory to each dotfile from given list.
struct DotfilesTask: TaskType {
    /// Task logging service
    var logger: Logger?

    /// List of dotfiles
    let dotfiles: [Dotfile]

    init(configuration: Any) throws {
        // Retrives dotfiles info from given configuration
        guard let paths = configuration as? [Any] else {
            throw MekosError.invalidConfigurationFile
        }

        self.dotfiles = try paths.map { try Dotfile(configuration: $0) }
    }

    func run() throws {
        for file in dotfiles {
            // Symlink must be normalized because of `~` resolving
            let linkName = Path("~/\(file.destination.lastComponent)").normalize()

            // Try to create actual symlink
            do {
                try linkName.symlink(file.destination)
                logger?.log(success: "Created symlink at \(linkName).")
            } catch {
                logger?.log(warning: error.localizedDescription)
            }
        }
    }
}
