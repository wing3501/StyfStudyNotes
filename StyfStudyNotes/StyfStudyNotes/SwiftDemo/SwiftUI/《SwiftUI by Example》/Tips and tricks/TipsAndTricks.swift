//
//  TipsAndTricks.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/20.
//

import SwiftUI

struct TipsAndTricks: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .iOS { $0.padding(10) }
            
            Button("点击") {
                print("打印一下")
            }
        }
        
    }
}
//------------------------------------
//平台控制
extension View {
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func tvOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(tvOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func watchOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(watchOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}
//------------------------------------
struct TipsAndTricks_Previews: PreviewProvider {
    static var previews: some View {
        TipsAndTricks()
    }
}
