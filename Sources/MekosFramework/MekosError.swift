//
//  MekosError.swift
//  mekos
//
//  Created by Josef Dolezal on 07/06/2017.
//
//

import Foundation

public enum MekosError: Error, CustomStringConvertible {
    case missingTask(name: String)
    case invalidDotfile(file: String)
    case invalidConfigurationFile

    public var description: String {
        switch self {
        case let .missingTask(name):
            return "The required task `\(name)` is not presented in configuration file."

        case let .invalidDotfile(file):
            return "The given dotfile `\(file)` is not valid."

        case .invalidConfigurationFile:
            return "Given configuration file does not have valid format."
        }
    }
}
