import Foundation
import MekosFramework

print("Running Mekos")

do {
    let runner = try MekosRunner(configFile: ".mekos.yaml")

    try runner.linkDotfiles()
} catch {
    print("An error occured: \(error.localizedDescription)")
}
