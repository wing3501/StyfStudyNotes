//
//  MenuStyle.swift
//
//
//  Created by styf on 2022/8/26.
//

import SwiftUI

extension MenuStyle where Self == CustomMenu {
    static var customMenu: CustomMenu { .init() }
}

struct CustomMenu: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
      HStack {
        Spacer()
        // 1
        Menu(configuration)
        Spacer()
        Image(systemName: "chevron.up.chevron.down")
      }
      .padding()
      // 2
      .background(Color.mint)
      .cornerRadius(8)
      // 3
      .foregroundColor(.white)
    }
}
