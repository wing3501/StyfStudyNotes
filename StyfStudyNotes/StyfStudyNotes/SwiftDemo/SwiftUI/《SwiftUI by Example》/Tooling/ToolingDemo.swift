//
//  ToolingDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/19.
//

import SwiftUI

struct ToolingDemo: View {
    @StateObject private var evilObject = EvilStateObject()
    var body: some View {
        VStack {
            Text("Hello, World!")
                .background(.random)//使用颜色来调试
            let _ = Self._printChanges()//用它来确定是什么更改导致视图重新加载自身  仅供调试
            Text("What could possibly go wrong?")
        }
    }
}

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}


class EvilStateObject: ObservableObject {
    var timer: Timer?

    init() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in
            if Int.random(in: 1...5) == 1 {
                self.objectWillChange.send()
            }
        }
    }
}

struct ToolingDemo_Previews: PreviewProvider {
    static var previews: some View {
        
        ToolingDemo()
        //预览多种动态尺寸
//            .environment(\.sizeCategory, .extraSmall)
//            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        //预览暗黑模式
//            .preferredColorScheme(.dark)
//        ForEach(ColorScheme.allCases, id: \.self) {
//            ToolingDemo().preferredColorScheme($0)
//            }
//        ForEach(ColorScheme.allCases, id: \.self, content: ToolingDemo().preferredColorScheme)
        //预览不同的设备
//            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
//            .previewDisplayName("iPhone 12")
        //预览导航
//        NavigationView {
//            ToolingDemo()
//            }
        //预览横竖屏
//            .previewInterfaceOrientation(.landscapeLeft)
    }
}
