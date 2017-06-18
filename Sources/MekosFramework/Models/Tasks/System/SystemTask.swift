//
//  SystemTask.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 17/06/2017.
//

/// System task covers all system configurations.
/// These configurations are grouped into Service classes and runned independentli.
struct SystemTask: TaskType {
    /// Task logging service
    var logger: Logger?

    var expose: [String: String]

    private static let defaultsCommand = "defaults"

    /// Creates new system configuration task instance with given configuration.
    ///
    /// - Parameter configuration: Task configuration
    /// - Throws: MekosError on invalid configuration
    init(configuration: Any) throws {
        guard let expose = configuration as? [String: String] else {
            throw MekosError.invalidConfigurationFile
        }

        self.expose = expose
    }

    /// Runs system configuration task
    ///
    /// - Throws: MekosError on runtime error
    func run() throws {
        // Throw error if unknown location is provided
        let actions = try expose.map { hotCorner -> (ExposeLocation, ExposeAction) in
            guard
                let location = ExposeLocation(rawValue: hotCorner.key),
                let action = ExposeAction(rawValue: hotCorner.value)
            else {
                throw MekosError.invalidConfigurationFile
            }

            return (location, action)
        }

        for action in actions {
            // Create shell commands for expose location
            let setter = ShellCommand(
                command: SystemTask.defaultsCommand,
                arguments: ["write", "com.apple.dock", action.0.identifier, "-int", "\(action.1.actionCode)"]
            )

            let modifier = ShellCommand(
                command: SystemTask.defaultsCommand,
                arguments: ["write", "com.apple.dock", action.0.modifier, "-int", "\(action.1.actionCode)"]
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
