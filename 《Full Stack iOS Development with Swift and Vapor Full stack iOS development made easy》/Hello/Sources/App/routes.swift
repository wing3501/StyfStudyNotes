import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    // path写法  http://127.0.0.1:8080/restaurants/speciality/chinese
//    app.get("restaurants", "speciality", "chinese") { req -> String in
//        return "restaurants/speciality/chinese"
//    }
    
    // 路由参数  http://localhost:8080/restaurants/speciality/region
    app.get("restaurants", "speciality", ":region") { req -> String in
        guard let region = req.parameters.get("region") else {
            throw Abort(.badRequest)
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
