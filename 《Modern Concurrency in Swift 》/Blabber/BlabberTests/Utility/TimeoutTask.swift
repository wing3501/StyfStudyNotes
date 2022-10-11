//
//  TimeoutTask.swift
//  BlabberTests
//
//  Created by styf on 2022/10/11.
//

import Foundation

class TimeoutTask<Success> {//Success是task的返回类型，如果没有返回值，Success就是Void
  let nanoseconds: UInt64
  let operation: @Sendable () async throws -> Success
  
  private var continuation: CheckedContinuation<Success, Error>?
  
  var value: Success {
    get async throws {
      try await withCheckedThrowingContinuation { continuation in
        self.continuation = continuation
        
        // ⚠️极端情况下，这里仍然有可能两个task都正在使用continuation而导致崩溃
        
        // 超时报错
        Task {
          try await Task.sleep(nanoseconds: nanoseconds)
          self.continuation?.resume(throwing: TimeoutError())
          self.continuation = nil
        }
        // 真正执行任务
        Task {
          let result = try await operation()
          self.continuation?.resume(returning: result)
          self.continuation = nil
        }
      }
    }
  }
  
  init(
    seconds: TimeInterval,
    operation: @escaping @Sendable () async throws -> Success
  ){
    self.nanoseconds = UInt64(seconds * 1_000_000_000)
    self.operation = operation
  }
  
  
  func cancel() {
    continuation?.resume(throwing: CancellationError())
    continuation = nil
  }
}

extension TimeoutTask {
  struct TimeoutError: LocalizedError {
    var errorDescription: String? {
      return "The operation timed out."
    }
  }
}
