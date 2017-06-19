//
//  ExposeService.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 19/06/2017.
//

import Foundation

struct ExposeService: ServiceType {

    typealias HotCorner = (location: ExposeLocation, action: ExposeAction)

    private static let dockIdentifier = "com.apple.dock"

    private static let defaultsCommand = "defaults"

    private let corners: [HotCorner]

    var logger: Logger?

    init(configuration: Any) throws {
        guard let dictionary = configuration as? [String: String] else {
            throw MekosError.invalidConfigurationFile
        }

        self.corners = try ExposeService.createCorners(from: dictionary)
    }

    static func createCorners(from dictionary: [String: String]) throws -> [HotCorner] {
        return try dictionary.map { location, action in
            guard
                let location = ExposeLocation(rawValue: location),
                let action = ExposeAction(rawValue: action)
                else {
                    throw MekosError.invalidConfigurationFile
            }

            return (location, action)
        }
    }

    func run() throws {
        for corner in corners {
            logger?.log(message: "Running Expose configuration `\(corner.location)` -> `\(corner.action)`.")

            // Create shell commands for expose location
            let setter = ShellCommand(
                command: ExposeService.defaultsCommand,
                arguments: ["write", ExposeService.dockIdentifier, corner.location.identifier,
                            "-int", "\(corner.action.actionCode)"]
            )

            let modifier = ShellCommand(
                command: ExposeService.defaultsCommand,
                arguments: ["write", ExposeService.dockIdentifier, corner.location.modifier,
                            "-int", "\(corner.action.actionCode)"]
            )

            // Run shell commands
            let setterLog = try setter.execute()
            let modifierLog = try modifier.execute()

            // Log all outputs
            logger?.log(message: setterLog)
            logger?.log(message: modifierLog)
        }
    }
}

enum ExposeLocation: String {
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

enum ExposeAction: String {
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

    var actionCode: Int {
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
