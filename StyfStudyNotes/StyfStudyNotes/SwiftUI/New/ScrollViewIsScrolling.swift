//
//  ScrollViewIsScrolling.swift
//
//
//  Created by styf on 2022/9/13.
//  如何判断 ScrollView、List 是否正在滚动中  https://www.fatbobman.com/posts/how_to_judge_ScrollView_is_scrolling/

import SwiftUI
import Combine

struct ScrollViewIsScrolling: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        // 方案1：开两个定时器，分别添加到runloop的default\track mode下 。 页面上有多个scrollview时，无法区分
        // 方案2：scrollview元素上抛位置信息，0.15后不上抛了，说明是停止了。  需要给子元素添加修饰器
    }
}


