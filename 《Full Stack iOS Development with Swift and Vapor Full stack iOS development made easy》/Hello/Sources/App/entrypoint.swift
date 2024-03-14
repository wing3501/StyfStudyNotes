import Vapor
import Logging

@main
enum Entrypoint {
    static func main() async throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)// 是一个帮助程序方法，它将根据命令行参数和环境变量配置默认日志处理程序。默认日志处理程序可以将消息输出到终端
        // 我们可以覆盖 Vapor 的默认日志处理程序并注册我们自己的日志处理程序
//        LoggingSystem.bootstrap { label in
//            StreamLogHandler.standardOutput(label: label)
//        }
        
        let app = Application(env)
        defer { app.shutdown() }
        
        do {
            try await configure(app)
        } catch {
            app.logger.report(error: error)
            throw error
        }
        // 根据环境执行不同逻辑
//        switch app.environment {
//        case .production:
//            app.databases.use(....)
//        default:
//            app.databases.use(...)
//        }
        
        // ✅ 默认情况下，应用在开发环境中运行。这可以通过在应用启动期间传递 --env （-e） 标志来更改：
        //        production prod
        //        development dev
        //        testing test
//        vapor run serve --env production
        // 也可以使用短名
//        vapor run serve -e prod

        
        try await app.execute()
    }
}
