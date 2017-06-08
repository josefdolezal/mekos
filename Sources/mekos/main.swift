import Foundation
import MekosFramework

do {
    let configuration = try Configuration(configurationFile: ".mekos.yaml")
    let runner = try MekosRunner(configuration: configuration)

    try runner.linkDotfiles()
} catch {
    print("An error occured: \(error.localizedDescription)")
}
