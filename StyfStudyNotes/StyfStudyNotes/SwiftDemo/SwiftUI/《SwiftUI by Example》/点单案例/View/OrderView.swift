//
//  OrderView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/9.
//

import SwiftUI

struct OrderView : View {
    @EnvironmentObject var order: Order

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                    // 滑动删除列表项功能
                    //  1. 这个闭包接受一个IndexSet参数
                    .onDelete(perform: deleteItems(at:))
                }

                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("Place Order")
                    }
                }
                // 不可用
                .disabled(order.items.isEmpty)
            }
            .navigationTitle("Order")
            .listStyle(.insetGrouped)
            .toolbar {
                //2.给导航栏添加一个编辑按钮
                //3.没了，剩下的工作，SwiftUI都做好了
                EditButton()
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().environmentObject(Order())
    }
}
