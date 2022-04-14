//
//  GithubAPI.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/13.
//

import Foundation
import Combine

enum APIFailureCondition: Error {
    case invalidServerResponse
}

struct GithubAPIUser: Decodable {
    let login: String
    let public_repos: Int
    let avatar_url: String
}

struct GithubAPI {
    //暴露了一个发布者，使用布尔值以在发送网络请求时反映其状态
    static let networkActivityPublisher = PassthroughSubject<Bool, Never>()
    
    static func retrieveGithubUser(username: String) -> AnyPublisher<[GithubAPIUser], Never> {
        if username.count < 3 {
            return Just([]).eraseToAnyPublisher()
        }
        let assembledURL = String("https://api.github.com/users/\(username)")
        let publisher = URLSession.shared.dataTaskPublisher(for: URL(string: assembledURL)!)
//        handleEvents 操作符是我们触发网络请求发布者更新的方式。 我们定义了在订阅和终结（完成和取消）时触发的闭包，它们会在 passthroughSubject 上调用 send()
            .handleEvents(receiveSubscription: { _ in
                networkActivityPublisher.send(true)
            }, receiveCompletion: { _ in
                networkActivityPublisher.send(false)
            }, receiveCancel: {
                networkActivityPublisher.send(false)
            })
            .tryMap { data, response -> Data in
//                tryMap 添加了对来自 github 的 API 响应的额外检查，以将来自 API 的不是有效用户实例的正确响应转换为管道失败条件。
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw APIFailureCondition.invalidServerResponse
                }
                return data
            }
            .decode(type: GithubAPIUser.self, decoder: JSONDecoder())
            .map {
                [$0]
            }
            .catch { err in
                // catch 运算符捕获此管道中的错误条件，并在失败时返回一个空列表，同时还将失败类型转换为 Never
                return Just([])
            }
            .eraseToAnyPublisher()
            return publisher
    }
}

