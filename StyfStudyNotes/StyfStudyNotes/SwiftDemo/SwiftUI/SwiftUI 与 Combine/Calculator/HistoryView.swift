//
//  HistoryView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/21.
//

import Foundation
import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var model: CalculatorModel
    
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            Button("关闭") {
                mode.wrappedValue.dismiss()
            }
            if model.totalCount == 0 {
                Text("没有履历")
            }else {
                HStack {
                    Text("履历").font(.headline)
                    Text("\(model.historyDetail)").lineLimit(nil)
                }
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                Slider(value: $model.slidingIndex, in: 0...Float(model.totalCount), step: 1)
            }
        }.padding()
    }
}
