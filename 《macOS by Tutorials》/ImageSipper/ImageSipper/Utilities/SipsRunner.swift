
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
    
    func resizeImage(picture: Picture, newWidth: String, newHeight: String, newFormat: PicFormat) async -> URL? {
        guard let sipsCommandPath = await checkSipsCommandPath() else {
            return nil
        }
        let fileManager = FileManager.default
        let suffix = "-> \(newWidth) x \(newHeight)"
        var newURL = fileManager.addSuffix(of: suffix, to: picture.url)
        newURL = fileManager.changeFileExtension(of: newURL, to: newFormat.rawValue)
        
        let args = [
            "--resampleHeightWidth", newHeight, newWidth,
            "--setProperty", "format" , newFormat.rawValue,
            picture.url.path,
            "--out", newURL.path
        ]
        // ✅ 使用 Process 去保存新图片，绕过了所有通常的机制
        // 解决方案是，关闭(删除)沙盒。 ⚠️缺点是，不能发布到appStore
        _ = await commandRunner.runCommand(sipsCommandPath, with: args)
        
        return newURL
    }
    
    func createThumbs(in folder: URL, from imageURLs: [URL], maxDimension: String) async {
        guard let sipsCommandPath = await checkSipsCommandPath() else {
            return
        }
        
        for imageURL in imageURLs {
            let args = [
                "--resampleHeightWidthMax", maxDimension,
                imageURL.path,
                "--out", folder.path
            ]
            
            _ = await commandRunner.runCommand(sipsCommandPath, with: args)
        }
    }
}
