//
//  TestStoreView.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/14.
//

import SwiftUI

struct TestStoreView: View {
    @State var store = Store(state: TestState(), reducer: TestReducer(), middlewares: [TestMiddleware(index: 0),
                                                                                       TestMiddleware(index: 1),
                                                                                       TestMiddleware(index: 2),
                                                                                       TestMiddleware(index: 3),
                                                                                       TestMiddleware(index: 4),
                                                                                       TestMiddleware(index: 5),
                                                                                       TestMiddleware(index: 6),
                                                                                       TestMiddleware(index: 7),
                                                                                       TestMiddleware(index: 8),
                                                                                       TestMiddleware(index: 9),
                                                                                      ])
    
    var body: some View {
        Text(store.msg)
            .task {
                await store.send(.start)
            }
    }
}

