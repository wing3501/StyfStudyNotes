//
//  ReactiveFormModel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/15.
//

import UIKit
import Combine

class ReactiveFormModel: ObservableObject {
    @Published var firstEntry: String = "" {
        didSet {
            firstEntryPublisher.send(self.firstEntry)
        }
    }
    private let firstEntryPublisher = CurrentValueSubject<String, Never>("")

    @Published var secondEntry: String = "" {
        didSet {
            secondEntryPublisher.send(self.secondEntry)
        }
    }
    private let secondEntryPublisher = CurrentValueSubject<String, Never>("")

    @Published var validationMessages = [String]()
    private var cancellableSet: Set<AnyCancellable> = []

    var submitAllowed: AnyPublisher<Bool, Never>
    
    @Published var test = true

    init() {
//        combineLatest 用于合并来自 firstEntry 或 secondEntry 的更新，以便从任一来源来触发更新
        let validationPipeline = Publishers.CombineLatest(firstEntryPublisher, secondEntryPublisher)
            .map { (arg) -> [String] in
                var diagMsgs = [String]()
                let (value, value_repeat) = arg
                if !(value_repeat == value) {
                    diagMsgs.append("Values for fields must match.")
                }
                if (value.count < 5 || value_repeat.count < 5) {
                    diagMsgs.append("Please enter values of at least 5 characters.")
                }
                return diagMsgs
            }

        submitAllowed = validationPipeline
            .map { stringArray in
                return stringArray.count < 1 //没有错误信息的时候
            }
            .eraseToAnyPublisher()

        let _ = validationPipeline
            .assign(to: \.validationMessages, on: self)
            .store(in: &cancellableSet)
    }
}
