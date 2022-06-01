//
//  AnchorExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/5.
//

import SwiftUI
//我们可以把锚点想象为 UIKit 中 UIView 的 convert(_:from:) 的一个更加安全的 替代方法。
struct AnchorExample: View {
    
    let tabs: [Text] = [Text("World Clock"), Text("Alarm"), Text("Bedtime")]
    
    @State var selectedTabIndex = 0
    
    var body: some View {
        HStack {
            ForEach(tabs.indices) { tabIndex in
                Button {
                    selectedTabIndex = tabIndex
                } label: {
                    tabs[tabIndex]
                }
                .background(.random)
                .anchorPreference(key: BoundsKey.self, value: .bounds) { anchor in
                    selectedTabIndex == tabIndex ? anchor : nil
                }
            }
        }
        .overlayPreferenceValue(BoundsKey.self) { anchor in
//                    在前面，我们使用了 .onPreferenceChange 来读取 preference 值，但是 .onPreferenceChange 要求值必须满足 Equatable 协议。但不幸的是，Anchor 并没有满足 Equatable。作为替代，我们需要使用 .overlayPreference 或者 .backgroundPreference。
            
//            我们也不被 允许在 overlayPreferenceValue 或者 backgroundPreferenceValue 里改变状态。
            GeometryReader { proxy in
                Rectangle()
                    .fill(.blue)
                    .frame(width: proxy[anchor!].width, height: 2)
                    .offset(x: proxy[anchor!].minX)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomLeading)
                    .animation(.default, value: selectedTabIndex)
            }
        }
    }
}

struct BoundsKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = value ?? nextValue()
    }
}

struct AnchorExample_Previews: PreviewProvider {
    static var previews: some View {
        AnchorExample()
    }
}
