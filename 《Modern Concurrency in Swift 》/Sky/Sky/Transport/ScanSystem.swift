//
//  ScanSystem.swift
//  Sky (iOS)
//
//  Created by styf on 2022/10/13.
//

import Foundation
actor ScanSystem {
  let name: String
  let service: ScanTransport?
  init(name: String, service: ScanTransport? = nil) {
    self.name = name
    self.service = service
  }
  
  private(set) var count = 0
  
  func commit() {
    count += 1
  }
  
  func run(_ task: ScanTask) async throws -> String {
    defer { count -= 1 }
    return try await task.run()
  }
}
