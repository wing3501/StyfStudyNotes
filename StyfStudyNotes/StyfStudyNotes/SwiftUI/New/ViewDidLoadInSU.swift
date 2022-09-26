//
//  ViewDidLoadInSU.swift
//  TestAnim
//
//  Created by styf on 2022/9/26.
//  viewDidLoad() in SwiftUI
//  https://sarunw.com/posts/swiftui-viewdidload/

import SwiftUI

struct ViewDidLoadInSU: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SpyView: View {
    // ✅ 1 用一个状态+onAppear来模拟viewDidLoad的效果
    @State private var viewDidLoad = false
    
    var body: some View {
        Text("Spy")
            // 2
            .onAppear {
                print("onAppear")
                if viewDidLoad == false {
                    // 3
                    viewDidLoad = true
                    // 4
                    // Perform any viewDidLoad logic here.
                    print("viewDidLoad")
                }
            }
    }
}

// ✅ 封装
struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}

struct ViewDidLoadInSU_Previews: PreviewProvider {
    static var previews: some View {
        ViewDidLoadInSU()
    }
}
