//
//  UseUnevenRoundedRectangle.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/18.
//  iOS 17 引入 UnevenRoundedRectangle 新視圖 讓你輕鬆設定特定的圓角
// https://www.appcoda.com.tw/swiftui-unevenroundedrectangle/

import SwiftUI

struct UseUnevenRoundedRectangle: View {
    var body: some View {
        
        ScrollView {
            VStack(content: {
                // ✅ 基本使用
                BaseUse()
                // ✅ 带动画
                AnimatedCornerView()
                // ✅ 創建獨特的形狀
                SpecialCornerView()
            })
        }
        
    }
    
    struct SpecialCornerView: View {
        @State private var animate = false
        
        var body: some View {
            VStack(content: {
                ZStack {
                    ForEach(0..<18, id: \.self) { index in
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20.0, bottomLeading: 5.0, bottomTrailing: 20.0, topTrailing: 10.0), style: .continuous)
                            .foregroundStyle(.indigo)
                            .frame(width: 300, height: 30)
                            .opacity(animate ? 0.6 : 1.0)
                            .rotationEffect(.degrees(Double(10 * index)))
                            .animation(.easeInOut.delay(Double(index) * 0.02), value: animate)
                    }
                }
                .overlay {
                    Image(systemName: "briefcase")
                        .foregroundStyle(.white)
                        .font(.system(size: 100))
                }
                .onTapGesture {
                    animate.toggle()
                }
            })
            .frame(height: 300)
            
        }
    }
    
    struct AnimatedCornerView: View {
        
        @State private var animate = false
        
        var body: some View {

            UnevenRoundedRectangle(cornerRadii: .init(
                                        topLeading: animate ? 10.0 : 80.0,
                                        bottomLeading: animate ? 80.0 : 10.0,
                                        bottomTrailing: animate ? 80.0 : 10.0,
                                        topTrailing: animate ? 10.0 : 80.0))
                .foregroundStyle(.indigo)
                .frame(height: 200)
                .padding()
                .onTapGesture {
                    withAnimation {
                        animate.toggle()
                    }
                }

        }
    }
    
    struct BaseUse: View {
        var body: some View {
            Button(action: {
                
            }) {
                Text("Register")
                    .font(.title)
            }
            .tint(.white)
            .frame(width: 300, height: 100)
            .background {
                UnevenRoundedRectangle(cornerRadii: .init(
                                                                    topLeading: 50.0,
                                                                    bottomLeading: 10.0,
                                                                    bottomTrailing: 50.0,
                                                                    topTrailing: 30.0),
                                                                    style: .continuous)
                    .foregroundStyle(.indigo)
            }
        }
    }
}

#Preview {
    UseUnevenRoundedRectangle()
}
