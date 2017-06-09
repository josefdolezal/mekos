import Foundation
import MekosFramework

do {
    // Load tasks configuration from file
    let configuration = try Configuration(configurationFile: ".mekos.yaml")
    // Create runner with file configuration
    let runner = MekosRunner(configuration: configuration)

    // Run tasks
    try runner.run()
} catch {
    print("An error occured: \(error.localizedDescription)")
}
