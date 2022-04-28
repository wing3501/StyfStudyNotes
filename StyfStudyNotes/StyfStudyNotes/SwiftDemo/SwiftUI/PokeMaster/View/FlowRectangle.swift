//
//  FlowRectangle.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/28.
//

import SwiftUI

//比如当前 View 可以使用的 height 或者 width 是多少，需不需要 考虑 iPhone X 系列的安全区域 (safe area) 等。SwiftUI 中，我们可以通过 GeometryReader 来读取 parent View 提供的这些信息
//GeometryProxy 中包括了 SwiftUI 中父 View 层级向当前 View 提议的布局信息

struct FlowRectangle: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .fill(.red)
                    .frame(height: 0.3 * proxy.size.height)
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .fill(.green)
                        .frame(width: 0.4 * proxy.size.width)
                    VStack(alignment: .center, spacing: 0) {
                        Rectangle()
                            .fill(.blue)
                            .frame(height: 0.4 * proxy.size.height)
                        Rectangle()
                            .fill(.yellow)
                            .frame(height: 0.3 * proxy.size.height)
                    }
//                    .frame(width: 0.6 * proxy.size.width)
                }
            }
        }
    }
}

