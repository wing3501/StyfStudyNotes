//
//  RoundedCorners.swift
//
//
//  Created by styf on 2022/10/8.
//   How to create Rounded Corners View in SwiftUI 圆角方案汇总
//   https://sarunw.com/posts/swiftui-rounded-corners-view/
// ✅
// 1 cornerRadius modifier
// 2 clipShape modifier
// 3 background modifier

import SwiftUI

struct RoundedCorners: View {
    var body: some View {
        VStack {
            // ✅ cornerRadius
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .background(.pink)
                .foregroundColor(.white)
                .cornerRadius(8)
            
            // ✅ clipShape 修剪成指定形状
            usingClipShape
            // ✅ background
            usingBackground
            // ✅ background在iOS15的更新
            usingBackgroundIOS15
        }
    }
    
    var usingClipShape: some View {
        VStack {
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(.pink)
                .clipShape(

                    // 1
                    RoundedRectangle(
                        cornerRadius: 8
                    )
                )
            
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(.pink)
                .clipShape(

                    // 2
                    Capsule()
                )
            
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(.pink)
                .clipShape(

                    // 3
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous // ✅ 产生平滑圆角
                    )
                )
        }
    }
    
    var usingBackground: some View {
        VStack {
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 8)

                        .fill(.pink) // ⚠️ 颜色填充在这里
                )
            
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(
                    Capsule()

                        .fill(.pink)
                )
            
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(

                        cornerRadius: 20,
                        style: .continuous
                    )
                    .fill(.pink)
                )
        }
    }
    
    var usingBackgroundIOS15: some View {
        VStack {
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(
                    .pink,
                    in: RoundedRectangle(cornerRadius: 8)

                )
            
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(
                    .pink,
                    in: Capsule()

                )
            
            Label("Bookmark", systemImage: "bookmark.fill")
                .padding()
                .foregroundColor(.white)
                .background(
                    .pink,
                    in: RoundedRectangle(

                        cornerRadius: 20,
                        style: .continuous
                    )
                )
        }
    }
}

struct RoundedCorners_Previews: PreviewProvider {
    static var previews: some View {
        RoundedCorners()
    }
}
