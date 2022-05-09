//
//  SwiftUIByExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/6.
//

import SwiftUI

struct SwiftUIByExample: View {
    
    var body: some View {
        TabView {
            SEContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            OrderView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
        .environmentObject(Order())
    }
}

struct SwiftUIByExample_Previews: PreviewProvider {
    //@StateObject属性包装器负责在应用程序的整个生命周期内保持对象的活动状态。
//    @StateObject var order = Order()
    
    static var previews: some View {
        SwiftUIByExample()
            .previewDevice("iPhone 13")
//            .environmentObject(order)
    }
}
