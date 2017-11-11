//
//  AppStoreInstaller.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 15/06/2017.
//

import Foundation

/// AppStore software installation provider.
/// As official API is not provided by Apple, this provider calls `mas` CLI wrapper
/// for App Store API under the hood.
public struct AppStoreInstaller {
    /// Default AppStore command name
    private static let appStoreCommand = "mas"

    /// Installs software from App Store
    public func install(_ applications: [String]) {

    }
}
