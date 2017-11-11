//
//  Expose.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 19/06/2017.
//

import Foundation

public struct Expose {
    private static let dockIdentifier = "com.apple.dock"

    private static let defaultsCommand = "defaults"

    public func topLeft(do action: ExposeAction) {
        setup(corner: .topLeft, action: action)
    }

    public func topRight(do action: ExposeAction) {
        setup(corner: .topRight, action: action)
    }

    public func bottomLeft(do action: ExposeAction) {
        setup(corner: .bottomLeft, action: action)
    }

    public func bottomRight(do action: ExposeAction) {
        setup(corner: .bottomRight, action: action)
    }

    private func setup(corner: HotCorner, action: ExposeAction) {
        let setter = ShellCommand(
            command: Expose.defaultsCommand,
            arguments: ["write", Expose.dockIdentifier, corner.identifier,
                        "-int", "\(action.code)"]
        )

        let modifier = ShellCommand(
            command: Expose.defaultsCommand,
            arguments: ["write", Expose.dockIdentifier, corner.modifier,
                        "-int", "\(action.code)"]
        )

        _ = try! setter.execute()
        _ = try! modifier.execute()
    }
}

enum HotCorner: String {
    case topRight = "top_right"
    case topLeft = "top_left"
    case bottomLeft = "bottom_left"
    case bottomRight = "bottom_right"

    var identifier: String {
        switch self {
        case .topRight: return "wvous-tr-corner"
        case .topLeft: return "wvous-tl-corner"
        case .bottomLeft: return "wvous-bl-corner"
        case .bottomRight: return "wvous-br-corner"
        }
    }

    var modifier: String {
        switch self {
        case .topRight: return "wvous-tr-modifier"
        case .topLeft: return "wvous-tl-modifier"
        case .bottomLeft: return "wvous-bl-modifier"
        case .bottomRight: return "wvous-br-modifier"
        }
    }
}

public enum ExposeAction: String {
    case none
    case missionControl = "mission-control"
    case applicationWindows = "application-windows"
    case desktop
    case startScreensaver = "start-screensaver"
    case disableScreensaver = "disable-screensaver"
    case dashboard
    case sleepDisplay = "sleep-display"
    case launchpad
    case notificationCenter = "notification-center"

    var code: Int {
        switch self {
        case .none: return 0
        case .missionControl: return 2
        case .applicationWindows: return 3
        case .desktop: return 4
        case .startScreensaver: return 5
        case .disableScreensaver: return 6
        case .dashboard: return 7
        case .sleepDisplay: return 10
        case .launchpad: return 11
        case .notificationCenter: return 12
        }
    }
}
