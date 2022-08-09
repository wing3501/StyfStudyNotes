//
//  SyncWidthHeight.swift
//  UsingChart
//
//  Created by styf on 2022/8/9.
//  https://www.swiftbysundell.com/questions/syncing-the-width-or-height-of-two-swiftui-views/
//  让两个视图一样宽

import SwiftUI

struct SyncWidthHeight: View {
    var body: some View {
//        Example1()
//        Example2()// 方案1：Infinite frames
//        Example3()// 方案2：GeometryReader
//        Example4()// 方案3：Using a grid
//        Example5()// 方案4：Using a preference key
        Example6()// 方案5：frame + fixedSize
    }
    
    // 方案5：frame + fixedSize
    struct Example6: View {
        
        var body: some View {
            VStack {
                Group {
                    Button("Log in") {
                        
                    }
                    Button("I forgot my password") {
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
            .fixedSize(horizontal: true, vertical: false)
        }
        
    }
    
    
    // 方案4：Using a preference key
    struct Example5: View {
        
        @State private var buttonMaxWidth: CGFloat?
        
        var body: some View {
            VStack {
                Group {
                    Button("Log in") {
                        
                    }
                    Button("I forgot my password") {
                        
                    }
                }
                .background(GeometryReader { geometry in
                    Color.clear.preference(
                        key: ButtonWidthPreferenceKey.self,
                        value: geometry.size.width
                    )
                })
                .frame(width: buttonMaxWidth)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
            .onPreferenceChange(ButtonWidthPreferenceKey.self) {
                buttonMaxWidth = $0
            }
        }
        
        struct ButtonWidthPreferenceKey: PreferenceKey {
            static let defaultValue: CGFloat = 0

            static func reduce(value: inout CGFloat,
                               nextValue: () -> CGFloat) {
                value = max(value, nextValue())
            }
        }
    }
    
    // 方案3：Using a grid
    struct Example4: View {
        var body: some View {
            VStack {
                LazyHGrid(rows: [buttonRow,buttonRow]) {
                    Group {
                        Button("Log in") {
                            
                        }
                        Button("I forgot my password") {
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
        }
        
        private var buttonRow: GridItem {
            GridItem(.flexible(minimum: 0, maximum: 80))
        }
    }
    
    // 方案2：GeometryReader
    struct Example3: View {
        var body: some View {
            GeometryReader { g in
                VStack {
                    Group {
                        Button("Log in") {
                            
                        }
                        Button("I forgot my password") {
                            
                        }
                    }
                    .frame(maxWidth: g.size.width * 0.6)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    // 方案1：Infinite frames
    struct Example2: View {
        var body: some View {
            VStack {
                Group {
                    Button("Log in") {
                        
                    }
                    Button("I forgot my password") {
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
    }
    
    struct Example1: View {
        var body: some View {
            VStack {
                Group {
                    Button("Log in") {
                        
                    }
                    Button("I forgot my password") {
                        
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
        }
    }
}

struct SyncWidthHeight_Previews: PreviewProvider {
    static var previews: some View {
        SyncWidthHeight()
    }
}
