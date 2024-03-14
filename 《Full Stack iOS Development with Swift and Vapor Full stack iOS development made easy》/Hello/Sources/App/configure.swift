import Vapor

//✅ 安装 arch -arm64 brew install vapor
//✅ 新工程 vapor new Hello -n

// 无论默认环境模式如何，我们都可以根据应用程序的需要覆盖日志记录级别，以增加或减少生成的日志量。
// vapor run serve --log debug
// 另一种方法是设置LOG_LEVEL环境变量:
// export LOG_LEVEL=debug
// vapor run serve

// configures your application
public func configure(_ app: Application) async throws {
    // 这是我们应该注册路由、数据库、提供程序等服务的地方
    
    // uncomment to serve files from /Public folder
    // 此文件夹包含如果启用了 FileMiddleware 时将由 Vapor 应用程序提供的所有公共文件。这些文件通常是图像、样式表、浏览器脚本等。我们需要在 configure.swift 文件中启用 FileMiddleware，以使 Vapor 提供公共文件
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    try routes(app)
}
