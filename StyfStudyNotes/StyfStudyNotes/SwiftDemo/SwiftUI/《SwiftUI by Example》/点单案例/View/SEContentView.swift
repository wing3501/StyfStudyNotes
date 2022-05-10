//
//  SEContentView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/9.
//

import SwiftUI

struct SEContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: ItemDetail(item: item)) {
                                ItemRow(item: item)
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Menu")
            .listStyle(.grouped)
        }
//        .environmentObject(Order())
    }
}

struct SEContentView_Previews: PreviewProvider {
    //@StateObject属性包装器负责在应用程序的整个生命周期内保持对象的活动状态。
//    @StateObject var order = Order()
    
    static var previews: some View {
        SEContentView()
//            .environmentObject(order)
    }
}
