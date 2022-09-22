import Cocoa

func getAvailableData(from fileHandle: FileHandle) -> String {
    let newData = fileHandle.availableData
    if let string = String(data: newData, encoding: .utf8) {
        return string
    }
    return ""
}
// 封装一下
func runCommand(_ command: String, with arguments: [String] = []) async -> String {
    let process = Process()
    
    process.executableURL = URL(fileURLWithPath: command)
    process.arguments = arguments
    
    let outPipe = Pipe()
    let outFile = outPipe.fileHandleForReading
    process.standardOutput = outPipe
    
    do {
        try process.run()
        
        var returnValue = ""
        while process.isRunning {
            let newString = getAvailableData(from: outFile)
            returnValue += newString
        }
        let newString = getAvailableData(from: outFile)
        returnValue += newString
        return returnValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }catch {
        print(error)
    }
    
    return ""
}

func pathTo(command: String) async -> String {
    await runCommand("/bin/zsh", with: ["-c", "which \(command)"])
}

// ✅ 使用案例
//Task {
//    let commandPath = await pathTo(command: "cal")
//    let cal = await runCommand(commandPath, with: ["-h"])
//    print(cal)
//}

//--------------------------

let imagePath = "/Users/styf/Downloads/rosella.png"
let imagePathSmall = "/Users/styf/Downloads/rosella_small.png"

Task {
    let sipsPath = await runCommand("/bin/zsh", with: ["-c", "which sips"])
    
    let args = ["--getProperty", "all", imagePath]
    let imageData = await runCommand(sipsPath, with: args)
    print(imageData)
}

//--------------------------
let process = Process()

// 硬编码
//process.executableURL = URL(fileURLWithPath: "/sbin/ping")

// ✅ 传入参数
//process.arguments = ["-c","5","baidu.com"]

process.executableURL = URL(fileURLWithPath: "/bin/zsh")
process.arguments = ["-c", "which whoami"]

// ✅ 使用自己的输出管道
let outPipe = Pipe()
let outFile = outPipe.fileHandleForReading
process.standardOutput = outPipe


// ✅ 等待执行结束，一次性读取所有数据
//do {
//    try? process.run()
//    process.waitUntilExit()
//    // ✅ 获取输出
//    if let data = try outFile.readToEnd(),
//       let returnValue = String(data: data, encoding: .utf8) {
//        print("Result: \(returnValue)")
//    }
//}catch {
//    print(error)
//}

// ✅ 一点点读取数据

try process.run()

while process.isRunning {
    let newString = getAvailableData(from: outFile)
    print(newString.trimmingCharacters(in: .whitespacesAndNewlines))
}
let newString = getAvailableData(from: outFile)
print(newString.trimmingCharacters(in: .whitespacesAndNewlines))
