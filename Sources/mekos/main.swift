import Foundation
import MekosFramework
import PathKit

let configFile = ".mekos.yaml"
let logger = Logger(mode: .verbose)

// Load tasks configuration from file
logger.log(message: "Loading configuration from yaml.")
let configuration = try Configuration(configurationFile: Path(configFile), logger: logger)
logger.log(message: "Configuration successfully loaded.")

// Create runner with file configuration
let runner = MekosRunner(configuration: configuration)

// Run tasks
logger.log(message: "Runner created. Running tasks...")
try runner.run()
