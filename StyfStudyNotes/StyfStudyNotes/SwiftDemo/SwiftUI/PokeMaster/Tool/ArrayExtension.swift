//
//  ArrayExtension.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/26.
//

import Foundation
import Combine

extension Array where Element: Publisher {
    var zipAll: AnyPublisher<[Element.Output], Element.Failure> {
        let initial = Just([Element.Output]()) //初始化一个空数组
            .setFailureType(to: Element.Failure.self)
            .eraseToAnyPublisher()
        return reduce(initial) { partialResult, publisher in
            partialResult.zip(publisher) { array, output in
                array + [output] //组合一个
            }
            .eraseToAnyPublisher()
        }
    }
}
