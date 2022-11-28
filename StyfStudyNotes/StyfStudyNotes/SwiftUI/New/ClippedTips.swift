//
//  ClippedTips.swift
//
//
//  Created by styf on 2022/11/28.
//  clipped() doesn’t affect hit testing
//  https://oleb.net/2022/clipped-hit-testing/
//  ✅ clipped()不影响命中测试，裁掉的内容依然响应点击

import SwiftUI

struct ClippedTips: View {
    
    @State var buttonTapCount = 0
    @State var rectTapCount = 0
    
    var body: some View {
        VStack {
          Button("You can't tap me!") {// 按钮的点击事件，都被Rectangle的裁剪部分获取
            buttonTapCount += 1
          }
          .buttonStyle(.borderedProminent)

          Rectangle()
            .fill(.orange.gradient)
            .frame(width: 300, height: 300)
            .frame(width: 100, height: 100)
            .contentShape(Rectangle()) // ✅ 修复按钮点击事件被窃取的问题。contentShape定义了view的命中测试范围
            .clipped()
            .onTapGesture {
              rectTapCount += 1
            }
        }
        .onChange(of: buttonTapCount) { newValue in
            print("buttonTapCount:\(buttonTapCount)")
        }
        .onChange(of: rectTapCount) { newValue in
            print("rectTapCount:\(rectTapCount)")
        }
    }
}

struct ClippedTips_Previews: PreviewProvider {
    static var previews: some View {
        ClippedTips()
    }
}
