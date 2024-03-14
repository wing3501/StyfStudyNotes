import Vapor

func routes(_ app: Application) throws {
//    app.get { req async in
//        "It works!"
//    }

    //渲染首页
    app.get { req -> EventLoopFuture<View> in
        req.view.render("index")
    }
    
    app.get("hello") { req async -> String in
        req.logger.info("日志")
        return "Hello, world!"
    }
    app.logger.info("启动日志")
    
    // 日定义日志记录器
    let logger = Logger(label: "dev.logger.myAppLogs")
    logger.info("some info log")
    
    
    // path写法  http://127.0.0.1:8080/restaurants/speciality/chinese
//    app.get("restaurants", "speciality", "chinese") { req -> String in
//        return "restaurants/speciality/chinese"
//    }
    
    // 路由参数  http://localhost:8080/restaurants/speciality/region
    app.get("restaurants", "speciality", ":region") { req -> String in
        guard let region = req.parameters.get("region") else {
            throw Abort(.badRequest)
            // ✅ Abort的使用
//            throw Abort(.notFound)
//            throw Abort(.unauthorized, reason: "Invalid Credentials")
            
            // 如果 User.find 返回 nil，则将来将失败，并出现提供的错误.否则，flatMap 将提供一个非可选值。
//            User.find(id, on: db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap
//            { user in
//            // Non-optional User supplied to closure.
//            }
            // 如果我们使用 async/await，那么我们可以按如下方式处理可选：
//            guard let user = try await User.find(id, on: db) {
//                throw Abort(.notFound)
//            }
        }
        return "restaurants/speciality/\(region)"
    }
    
    //http://localhost:8080/restaurants/state/location/speciality/region
    app.get("restaurants", ":location", "speciality", ":region") { req -> String in
        guard let location = req.parameters.get("location"), let region = req.parameters.get("region") else {
            throw Abort(.badRequest)
        }
        return "restaurants in \(location) with speciality \(region)"
    }
    
    //Anything route  http://127.0.0.1:8080/routeany/bar/endpoint
    app.get("routeany", "*", "endpoint") { req -> String in
        return "This is anything route"
    }
    
    //CatchAll route  http://127.0.0.1:8080/routeany/xxx/aa
    app.get("routeany", "**") { req -> String in
        return "This is Catch All route"
    }
    
    //处理Query http://localhost:8080/search?keyword=italian&page=10
    app.get("search") { req -> String in
        guard let keyword = req.query["keyword"] as String?, let page = req.query["page"] as String? else {
            throw Abort(.badRequest)
        }
        return "Search for Keyword \(keyword) on Page \(page)"
    }
    
    // 路由组基本上允许您创建前缀
    let games = app.grouped("games")
//    let platforms = games.grouped("ps") //嵌套使用
    // http://localhost:8080/games
//    games.get { req async in
//        return "All games"
//    }
    // http://localhost:8080/games/ps/5
    games.get("ps", ":stars") { req -> String in
        
        
        guard let stars = req.parameters.get("stars") else {
            throw Abort(.badRequest)
        }
        return "ps->\(stars)"
    }
    
    // 注册路由
    try app.register(collection: UserController())
}
