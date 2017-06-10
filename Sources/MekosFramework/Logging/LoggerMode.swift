//
//  LoggerMode.swift
//  MekosFramework
//
//  Created by Josef Dolezal on 10/06/2017.
//

import Foundation

/// Logger level model
///
/// - verbose: Logs all events recorded by logger
/// - quite: Logs only success, warning and error events
public enum LoggerMode {
    case verbose
    case quite
}
