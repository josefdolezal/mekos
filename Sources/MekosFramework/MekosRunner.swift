//
//  MekosRunner.swift
//  mekos
//
//  Created by Josef Dolezal on 07/06/2017.
//
//

import PathKit

public struct MekosRunner {

    let configuration: Configuration

    public init(configuration: Configuration) throws {
        self.configuration = configuration
    }

    public func linkDotfiles() throws {
        for file in configuration.dotfiles {
            // Symlink must be normalized because of `~` resolving
            let symlink = Path("~/\(file.lastComponent)").normalize()

            print("Creating link for dotfile `\(file.lastComponent)`.")

            try symlink.symlink(file)

            print("Link created.")
        }
    }
}
