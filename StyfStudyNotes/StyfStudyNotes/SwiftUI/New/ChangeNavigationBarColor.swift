//
//  ChangeNavigationBarColor.swift
//  修改导航栏颜色、导航栏上文字颜色
//  https://sarunw.com/posts/swiftui-navigation-bar-color/
//  Created by styf on 2022/8/25.
//

import SwiftUI

struct ChangeNavigationBarColor: View {
    var body: some View {
        NavigationStack {
            List {
                Button("点击改变") {
                    
                }
            }
            .navigationTitle("修改导航栏颜色")
            
            // 强制指定导航栏文字颜色为浅色、深色
            .toolbarColorScheme(.dark, for: .navigationBar)
            
            // 1.ShapeStyle 显示的样式
            // 2.toolbarplacement 放置样式的位置
            .toolbarBackground(.pink, for: .navigationBar)// 设置navigationBar将样式应用到导航栏
            // 强制让导航栏显示颜色，否则上拉才显示
            .toolbarBackground(.visible, for: .navigationBar)// 对toolbarColorScheme也有效
            
            
        }
    }
}

struct ChangeNavigationBarColor_Previews: PreviewProvider {
    static var previews: some View {
        ChangeNavigationBarColor()
    }
}
