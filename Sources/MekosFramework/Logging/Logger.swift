//
//  Logger.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 09/06/2017.
//

import Foundation

/// User friendly logging service.
public class Logger {
    /// Shell text color
    enum ShellColor: String {
        case orange = "\u{001B}[0;33m"
        case green = "\u{001B}[0;32m"
        case red = "\u{001B}[0;31m"
        case standard = "\u{001B}[0;39m"
    }

    public init() { }

    /// Shortcut for success messages
    ///
    /// - Parameter success: Success message
    public func log(success: String) {
        createLogEntry(text: "✅  \(success)", highlight: .green)
    }

    /// Shortcut for warning logs
    ///
    /// - Parameter warning: Warning log
    public func log(warning: String) {
        createLogEntry(text: "⚠️  \(warning)", highlight: .orange)
    }

    /// Shortcut for error log
    ///
    /// - Parameter error: Error
    public func log(error: Error) {
        createLogEntry(text: "❌  \(error.localizedDescription)", highlight: .red)
    }

    /// Formats log with colors
    ///
    /// - Parameters:
    ///   - text: Text to be printed out
    ///   - highlight: Text color of message
    private func createLogEntry(text: String, highlight: ShellColor = .standard) {
        print("\(highlight.rawValue)\(text)\(ShellColor.standard.rawValue)")
    }
}
