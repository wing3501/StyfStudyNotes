//
//  CalculatorModel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/21.
//

import Foundation
import Combine

//ObservableObject 协议要求实现类型是 class，它只有一个需要实现的属性:objectWillChange。
//在数据将要发生改变时，这个属性用来向外进行 “广播”， 它的订阅者 (一般是 View 相关的逻辑) 在收到通知后，对 View 进行刷新。

//创建 ObservableObject 后，实际在 View 里使用时，我们需要将它声明为 @ObservedObject。
//这也是一个属性包装，它负责通过订阅 objectWillChange 这个 “广播”，将具体管理数据的 ObservableObject 和当前的 View 关联起来。

class CalculatorModel: ObservableObject {
//    let objectWillChange = PassthroughSubject<Void, Never>()
//    var brain: CalculatorBrain = .left("0") {
//        willSet { objectWillChange.send() }
//    }
    //使用@Published 自动生成
    @Published var brain: CalculatorBrain = .left("0")
    //实现回溯
    @Published var history: [CalculatorButtonItem] = []
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }
    
    var historyDetail: String {
        history.map{ $0.description }.joined()
    }
    
    var temporaryKept: [CalculatorButtonItem] = []
    
    var totalCount: Int {
        history.count + temporaryKept.count
    }
    
    var slidingIndex: Float = 0 {
        didSet {
            //维护 `history` 和 `temporaryKept`
            keepHistory(upTo: Int(slidingIndex))
        }
    }
    
    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index")
        
        let total = history + temporaryKept
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        
        brain = history.reduce(CalculatorBrain.left("0"), { partialResult, item in
            partialResult.apply(item: item)
        })
    }
}
