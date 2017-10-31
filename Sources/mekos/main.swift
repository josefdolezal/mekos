import Foundation
import MekosFramework
import Commander
import PathKit

let main = command(
    Flag("verbose", default: false, flag: "v", description: "Sets logs level to verbose mode")
) { verbose in
    let configFile = ".mekos.yaml"

    // Shared logger
    let logsMode: LoggerMode = verbose ? .verbose : .quite
    let logger = Logger(mode: logsMode)

    // Load tasks configuration from file
    logger.log(message: "Loading configuration from yaml.")
    let configuration = try Configuration(configurationFile: Path(configFile), logger: logger)
    logger.log(message: "Configuration successfully loaded.")

    // Create runner with file configuration
    let runner = MekosRunner(configuration: configuration)

    // Run tasks
    logger.log(message: "Runner created. Running tasks...")
    try runner.run()
}

main.run()
