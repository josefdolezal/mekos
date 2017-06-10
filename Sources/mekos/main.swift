import Foundation
import MekosFramework
import Commander

let main = command(
    Flag("verbose", flag: "v", description: "Sets logs level to verbose mode", default: false)
) { verbose in
    // Shared logger
    let logsMode: LoggerMode = verbose ? .verbose : .quite
    let logger = Logger(mode: logsMode)

    // Load tasks configuration from file
    let configuration = try Configuration(configurationFile: ".mekos.yaml", logger: logger)
    // Create runner with file configuration
    let runner = MekosRunner(configuration: configuration)

    // Run tasks
    try runner.run()
}

main.run()
