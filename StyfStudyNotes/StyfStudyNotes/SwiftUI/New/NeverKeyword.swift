//
//  NeverKeyword.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/10/8.
//  Never keyword in Swift: return type explained with code examples
//  https://www.avanderlee.com/swift/never-keyword/ never关键词使用

import SwiftUI
import Combine

struct NeverKeyword: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    // 使用案例1
//    func toggleDebugMode() -> Bool {
//        guard !UserDefaults.standard.isDebugModeEnabled else { return false }
//        enableDebugMode()
//    }
//
//    func enableDebugMode() -> Never { // ✅ 这里需要返回Never，否则编译器认为没有返回值而在调用方编译报错
//        UserDefaults.standard.isDebugModeEnabled = true
//        exit(0)
//    }
    
    // 使用案例2
    struct ContentCache<Content: StringProtocol> {
        /// Publishes new content items once added to the cache.
        public var contentPublisher: AnyPublisher<Content, Never> {
            contentPassthrough.eraseToAnyPublisher()
        }

        private var contentPassthrough = PassthroughSubject<Content, Never>()

        func add(_ content: Content) {
            contentPassthrough.send(content)
        }
    }
    
    let cache = ContentCache<String>()
    func test() {
        let cancellable = cache.contentPublisher.sink { completion in
            switch completion {

        // Not required by the compiler since it knows there's not going to be a failure.
        //    case .failure: // ✅ 这里不需要处理failure.。Never遵循Error协议，可以作为一个error类型
        //        break
                
            case .finished:
                print("No more content expected")
            }
        } receiveValue: { newContent in
//            print("New content published: \(newContent.title)")
        }
    }
    
    // 使用案例3
    func test2() {
        // ✅ 有些协议强制我们使用result枚举，但是我们确定不会有错误路径，可以使用Never
        let result: Result<String, Never> = .success("Example of Never usage")
        switch result {

            /// Once again, not required by the compiler since it knows there's not going to be a failure.
            /// case .failure:
            ///    break

            case .success(let string):
                print(string)
        }
    }
    
}

struct NeverKeyword_Previews: PreviewProvider {
    static var previews: some View {
        NeverKeyword()
    }
}
