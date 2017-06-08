//
//  Configuration.swift
//  mekos
//
//  Created by Josef Dolezal on 08/06/2017.
//
//

import Yams
import PathKit

public struct Configuration {

    public typealias TasksConfiguration = [String: Any]

    let dotfiles: [Path]

    public init(configurationFile: Path) throws {
        let configuration: String = try configurationFile.read()
        let yaml = try Yams.load(yaml: configuration) as? [String: [String]]

        dotfiles = try Configuration.resolveFilesLocation(paths: yaml?["dotfiles"] ?? [])
    }

    public init(tasksConfiguration: TasksConfiguration) throws {
        let files = tasksConfiguration["dotfiles"] as? [String] ?? []

        self.dotfiles = try Configuration.resolveFilesLocation(paths: files)
    }

    internal static func resolveFilesLocation(paths: [String]) throws -> [Path] {
        return try paths.map { path -> Path in
            let file = Path(path)

            guard file.isFile else {
                throw MekosError.invalidDotfile(file: path)
            }

            return file.absolute()
        }
    }
}
