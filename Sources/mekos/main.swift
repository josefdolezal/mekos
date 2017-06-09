import Foundation
import MekosFramework

// Shared logger
let logger = Logger()

do {
    // Load tasks configuration from file
    let configuration = try Configuration(configurationFile: ".mekos.yaml", logger: logger)
    // Create runner with file configuration
    let runner = MekosRunner(configuration: configuration)

    // Run tasks
    try runner.run()
} catch {
    logger.log(error: error)
}
