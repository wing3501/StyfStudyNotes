//
//  GridView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/8.
//

import SwiftUI

struct GridView: View {
    
    var gridData: [Event]
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 250, maximum: 250),spacing: 20)]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns,spacing: 15) {
                ForEach(gridData) {
                    EventView(event: $0)
                        .frame(height: 350,alignment: .topLeading)
                    
                        // ✅ 解决：加了shadow后，内部的元素都有了阴影
                        .background() // 不加参数，会使用默认背景色
                        .clipped() // 除了防止内容溢出，还有一个作用是不让阴影作用于内部的view
                    
                        .border(.secondary,width: 1)
                        .padding(.bottom, 5) //防止阴影被切割
                        .shadow(color: .primary.opacity(0.3), radius: 3, x: 3, y: 3)
                }
            }
        }
        .padding(.vertical)
    }
}

