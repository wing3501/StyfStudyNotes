//
//  OrderFoodAPP.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/10.
//

import SwiftUI

struct OrderFoodAPP: View {
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

struct OrderFoodAPP_Previews: PreviewProvider {
    //@StateObject属性包装器负责在应用程序的整个生命周期内保持对象的活动状态。
//    @StateObject var order = Order()
    
    static var previews: some View {
        OrderFoodAPP().previewDevice("iPhone 13")
        //            .environmentObject(order)
    }
}
