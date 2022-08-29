//
//  ButtonStyle.swift
//  
//
//  Created by styf on 2022/8/26.
//

import SwiftUI

extension ButtonStyle where Self == GradientStyle {
    static var gradient: GradientStyle { .init() }
}


struct GradientStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    private let colors: [Color]
    
    init(colors: [Color] = [.mint.opacity(0.6), .mint, .mint.opacity(0.6), .mint]) {
        self.colors = colors
    }
    
    // 1
    private var enabledBackground: some View {
      LinearGradient(
        colors: colors,
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    }

    // 2
    private var disabledBackground: some View {
      LinearGradient(
        colors: [.gray],
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    }

    // 3
    private var pressedBackground: some View {
      LinearGradient(
        colors: colors,
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
      .opacity(0.4)
    }
    
    func makeBody(configuration: Configuration) -> some View {
      // 1
      HStack {
          // 2
          configuration.label
      }
      .font(.body.bold())
      // 3
      .foregroundColor(isEnabled ? .white : .black)
      .padding()
      .frame(height: 44)
      // 4
      .background(backgroundView(configuration: configuration))
      .cornerRadius(10)
    }

    
    @ViewBuilder private func backgroundView(configuration: Configuration) -> some View {
        if !isEnabled { // 1 可以通过环境变量isEnabled知道按钮是否可用
            disabledBackground
        } else if configuration.isPressed { // 2 configuration包含role、label、isPressed
            pressedBackground
        } else {
            enabledBackground
        }
    }

}

