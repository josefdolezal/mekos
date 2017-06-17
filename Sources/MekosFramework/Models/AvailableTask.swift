//
//  AvailableTask.swift
//  mekos
//
//  Created by Josef Dolezal on 09/06/2017.
//

import Foundation

/// Represents available task with its identifier expected in configuration.
/// - dotfiles: Dotfiles linking task
/// - install: Software installation task
/// - system: System configuration task
enum AvalaibleTask: String {
    case dotfiles
    case install
    case system

    /// Task class type
    var type: TaskType.Type {
        switch self {
        case .dotfiles: return DotfilesTask.self
        case .install: return InstallTask.self
        case .system: return SystemTask.self
        }
    }

    /// Task configuration identifier
    var identifier: String {
        return rawValue
    }

    /// All available tasks
    static var all: [AvalaibleTask] {
        return [.dotfiles, .install, .system]
    }
}
