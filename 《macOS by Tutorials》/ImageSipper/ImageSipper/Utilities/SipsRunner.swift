
import SwiftUI

class SipsRunner: ObservableObject {
    var commandRunner = CommandRunner()
    
    var sipsCommandPath: String?
    
    func checkSipsCommandPath() async -> String? {
        if sipsCommandPath == nil {
            sipsCommandPath = await commandRunner.pathTo(command: "sips")
        }
        return sipsCommandPath
    }
    
    func getImageData(for imageURL: URL) async -> String {
        guard let sipsCommandPath = await checkSipsCommandPath() else {
            return ""
        }
        let args = ["--getProperty", "all", imageURL.path]
        let imageData = await commandRunner.runCommand(sipsCommandPath, with: args)
        return imageData
    }
}
