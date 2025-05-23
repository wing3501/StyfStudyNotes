import Vapor
import Leaf

//✅ 安装 arch -arm64 brew install vapor
//✅ 新工程 vapor new Hello -n

//✅ 无论默认环境模式如何，我们都可以根据应用程序的需要覆盖日志记录级别，以增加或减少生成的日志量。
// vapor run serve --log debug
// 另一种方法是设置LOG_LEVEL环境变量:
// export LOG_LEVEL=debug
// vapor run serve

//✅ 若要使用 SwiftBacktrace，应用必须在编译期间包含调试符号：
//swift build -c release -Xswiftc -g

// configures your application
public func configure(_ app: Application) async throws {
    // 这是我们应该注册路由、数据库、提供程序等服务的地方
    
    // uncomment to serve files from /Public folder
    // 此文件夹包含如果启用了 FileMiddleware 时将由 Vapor 应用程序提供的所有公共文件。这些文件通常是图像、样式表、浏览器脚本等。我们需要在 configure.swift 文件中启用 FileMiddleware，以使 Vapor 提供公共文件
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //若要自定义 AbortError 和 DebuggableError 之外的错误处理，我们可以将 ErrorMiddleware 替换为我们自己的错误处理逻辑。为了实现这一点，首先，我们需要通过将 app.middleware 设置为中间件到空配置。然后，将自定义错误处理中间件作为第一个中间件添加到应用程序。
    // 删除所有现有中间件。
    // app.middleware = .init()
    // 首先添加自定义错误处理中间件。
    // app.middleware.use（MyErrorMiddleware（））
    
    // 使用leaf   https://docs.vapor.codes/leaf/getting-started/
    // 当我们使用 Vapor 时，它将在名为 Resources 的目录中查找 Leaf 页面。此目录必须位于项目级别，因此我可以继续添加一个新文件夹，该文件夹应命名为 Resources。
    app.views.use(.leaf)
    
    // ✅ 默认情况下，Xcode 将从 DerivedData 文件夹运行您的项目。此文件夹与项目的根文件夹（Package.swift 文件所在的位置）不同。这意味着 Vapor 将无法找到 .env 或 Public 等文件和文件夹。
    // 若要解决此问题，请在 Xcode 方案中为项目设置自定义工作目录。  设置为项目根目录
    
    // register routes
    try routes(app)
}
