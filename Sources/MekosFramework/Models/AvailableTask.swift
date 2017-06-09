//
//  AvailableTask.swift
//  mekos
//
//  Created by Josef Dolezal on 09/06/2017.
//

import Foundation

/// Represents available task with its identifier expected in configuration.
enum AvalaibleTask: String {
    /// Dotfiles installation task
    case dotfiles

    /// Task class type
    var type: TaskType.Type {
        switch self {
        case .dotfiles: return DotfilesTask.self
        }
    }

    /// Task configuration identifier
    var identifier: String {
        return rawValue
    }

    /// All available tasks
    static var all: [AvalaibleTask] {
        return [.dotfiles]
    }
}
