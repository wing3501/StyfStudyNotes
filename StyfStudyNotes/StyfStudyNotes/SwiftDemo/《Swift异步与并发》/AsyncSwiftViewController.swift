//
//  AsyncSwiftViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/20.
//

import UIKit
import Photos

protocol WorkDelegate {
    func workDidDone(values: [String])
    func workDidFailed(error: Error)
}

class AsyncSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    //--------------------------
    //异步只读属性
    class File {
        var size: Int {
            get async throws {
//                if corrupted {
//                    throw FileError.corrupted
//                }
                try await heavyOperation()
            }
        }
        func heavyOperation() async throws -> Int {
            return 1
        }
    }
    
    //下标读取
//    class File {
//        subscript(_ attribute: AttributeKey) -> Attribute {
//            //比如 await file[.readonly] == true
//            get async {
//                let attributes = await loadAttributes()
//                return attributes[attribute]
//            }
//        }
//    }
    
    //--------------------------
//异步函数也遵守同样的规则:当一个 Swift 中的 async 函数被标记为 @objc 时，它在 Objective-C 中会由一个带有 completionHandler 的回调闭包版本表示
    func requestAuthorization() {
        Task {
            let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        }
    }
    
    
    //--------------------------
    //封装代理为异步函数
//    class Worker: WorkDelegate {
//        var continuation: CheckedContinuation<[String], Error>?
//
//        func doWork() async throws -> [String] {
//            try await withCheckedThrowingContinuation({ continuation in
//                self.continuation = continuation
//                performWork(delegate: self)
//            })
//        }
//        func workDidDone(values: [String]) {
//            continuation?.resume(returning: values)
//            continuation = nil //但是作为 continuation 来说，不论成败，它只 支持一次 resume 调用。在上面的代码中，我们通过 resume 调用后将 self.continuation 置为 nil 来避免重复调用。
//        }
//        func workDidFailed(error: Error) {
//            continuation?.resume(throwing: error)
//            continuation = nil
//        }
//    }
    
    //--------------------------
//    withUnsafeContinuation
//    withCheckedContinuation
//    withCheckedThrowingContinuation
//    withUnsafeThrowingContinuation 包装
//    Unsafe 和 Checked 版本的区别在于是否对 continuation 的调用状况进行运行时的检查。
    func load(completion: @escaping ([String]?, Error?) -> Void) {
        completion([], nil)
    }
    //包装后
    func load() async throws -> [String] {
        try await withUnsafeThrowingContinuation { continuation in
            //调用原来的函数
            load { values, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let values = values {
                    continuation.resume(returning: values)
                }else {
                    assertionFailure("Both parameters are nil")
                }
            }
        }
    }


    //--------------------------
//    @completionHandlerAsync  使用
//    我们可以为原本的回调版本添加 @completionHandlerAsync 注解，告诉编 译器存当前函数存在一个异步版本。这样，当使用者在其他异步函数中调用了这个回调版本时， 编译器将提醒使用者可以迁移到更合适的异步版本
    
//    @completionHandlerAsync(
//      "calculate(input:)",
//      completionHandlerIndex: 1
//    )
//    func calculate(input: Int, completion: @escaping (Int) -> Void) {
//      completion(input + 100)
//    }
//
//    @completionHandlerAsync("calculate(input:)")
//    func calculate(input: Int, completion: @escaping (Int) -> Void) {
//      completion(input + 100)
//    }
//
//    func calculate(input: Int) async -> Int {
//        return input + 100
//    }
}
