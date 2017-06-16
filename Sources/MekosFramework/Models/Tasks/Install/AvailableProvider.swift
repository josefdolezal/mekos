//
//  AvailableProvider.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 16/06/2017.
//

import Foundation

/// Represents software installation provider
/// - brew: Brew package manager
/// - appStore: System software manager
enum AvailableProvider: String {
    case brew
    case appStore = "app_store"

    /// Provider class type
    var provider: ProviderType.Type {
        switch self {
        case .brew: return BrewProvider.self
        case .appStore: return AppStoreProvider.self
        }
    }

    /// Configuration identifier
    var identifier: String {
        return rawValue
    }

    /// Set of all available providers
    static var all: [AvailableProvider] {
        return [.brew, .appStore]
    }
}
