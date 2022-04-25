//
//  Utils.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/24.
//

import Foundation
import SwiftUI
import Combine

public enum SampleError: Error {
    case sampleError
}

public func check<P: Publisher>(_ title: String, publisher: () -> P) -> AnyCancellable {
    print("----- \(title) -----")
    defer { print("") }
    return publisher()
        .print()
        .sink { _ in
            
        } receiveValue: { _ in
            
        }
}

public func delay(_ second:Double,_ block: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(second * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
}
