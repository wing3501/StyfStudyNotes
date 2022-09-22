import Cocoa

let process = Process()

process.executableURL = URL(fileURLWithPath: "/usr/bin/whoami")



try? process.run()
