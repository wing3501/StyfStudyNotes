import Cocoa

func getAvailableData(from fileHandle: FileHandle) -> String {
    let newData = fileHandle.availableData
    if let string = String(data: newData, encoding: .utf8) {
        return string
    }
    return ""
}

let process = Process()

process.executableURL = URL(fileURLWithPath: "/sbin/ping")

// ✅ 传入参数
process.arguments = ["-c","5","baidu.com"]

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
