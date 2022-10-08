//
//  ChangeFontWidth.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/10/8.
//  https://sarunw.com/posts/swiftui-font-width/ iOS16新API改变字宽
// ✅
// Compressed
// Condensed
// Expanded

import SwiftUI

struct ChangeFontWidth: View {
    var body: some View {
        VStack {
            Text("Alphabet")
//                .font(
//                    .largeTitle.width(.expanded)
//
//                )
            Text("The quick brown fox jumps over the lazy dog")
//                .font(
//                    .body.width(.compressed)
//
//                )
        }
        // ✅ 批量设置
//        .fontWidth(.expanded)
    }
}

struct ChangeFontWidth_Previews: PreviewProvider {
    static var previews: some View {
        ChangeFontWidth()
    }
}
