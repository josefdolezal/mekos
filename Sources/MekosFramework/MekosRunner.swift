//
//  MekosRunner.swift
//  mekos
//
//  Created by Josef Dolezal on 07/06/2017.
//
//

import Yams
import PathKit

public struct MekosRunner {

    private let dotfiles: [Path]

    public init(configFile: Path) throws {
        // Read configuration from file
        let configuration: String = try configFile.read()
        let yaml = try Yams.load(yaml: configuration) as? [String: [String]]

        // Read list of dotfiles
        guard let dotfilesList = yaml?["dotfiles"] else {
            throw MekosError.missingTask(name: "dotfiles")
        }

        // Valid given dotfiles and create Path objects from it
        self.dotfiles = try dotfilesList.map { path -> Path in
            let file = Path(path)

            guard file.isFile else {
                throw MekosError.invalidDotfile(file: path)
            }

            return file.absolute()
        }
    }

    public func linkDotfiles() throws {
        for file in dotfiles {
            // Symlink must be normalized because of `~` resolving
            let symlink = Path("~/\(file.lastComponent)").normalize()

            print("Creating link for dotfile `\(file.lastComponent)`.")

            try symlink.symlink(file)

            print("Link created.")
        }
    }
}
