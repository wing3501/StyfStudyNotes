//
//  OpaqueReturnTypes.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/21.
//  Combining opaque return types with primary associated types
// https://www.swiftbysundell.com/articles/opaque-return-types-primary-associated-types/
// 结合使用不透明返回类型和关联类型

// 以前的Combine ⚠️
//func loadUser(withID id: User.ID) -> AnyPublisher<User, Error> {
//    urlSession
//        .dataTaskPublisher(for: urlForLoadingUser(withID: id))
//        .map(\.data)
//        .decode(type: User.self, decoder: decoder)
//        .eraseToAnyPublisher()
//}
// 使用some进行类型擦除 ⚠️ 调用方无法了解发布者发布的值类型
//func loadUser(withID id: User.ID) -> some Publisher

// swift5.7之后
//protocol Publisher<Output, Failure> {
//    associatedtype Output
//    associatedtype Failure: Error
//    ...
//}
// 使用some+关联类型 ✅ 缺点是必须返回同样的类型
//func loadUser(withID id: User.ID) -> some Publisher<User, Error>
// ✅ 一个使用案例
//protocol Loadable<Value> {
//    associatedtype Value
//
//    func load() async throws -> Value
//}
//
//struct NetworkLoadable<Value: Decodable>: Loadable {
//    var url: URL
//
//    func load() async throws -> Value {
//        // Load the value over the network
//        ...
//    }
//}
//
//struct DatabaseLoadable<Value: Identifiable>: Loadable {
//    var id: Value.ID
//
//    func load() async throws -> Value {
//        // Load the value from the app's local database
//        ...
//    }
//}
// ✅ 使用any+关联类型解决返回不同类型的问题
//func loadableForArticle(withID id: Article.ID) -> any Loadable<Article> {
//    if useLocalData {
//        return DatabaseLoadable(id: id)
//    }
//
//    let url = urlForLoadingArticle(withID: id)
//    return NetworkLoadable(url: url)
//}

import SwiftUI

struct OpaqueReturnTypes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OpaqueReturnTypes_Previews: PreviewProvider {
    static var previews: some View {
        OpaqueReturnTypes()
    }
}
