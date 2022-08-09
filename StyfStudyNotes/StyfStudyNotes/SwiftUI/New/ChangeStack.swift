//
//  ChangeStack.swift
//  UsingChart
//
//  Created by styf on 2022/8/9.
//  4种方式动态切换Stack布局
//  https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/

import SwiftUI

struct ChangeStack: View {
    var body: some View {
//        Example1()
//        Example2() //使用GeometryReader来实现，有一个非常明显的缺点：GeometryReader总是填充所有空间
//        Example3() //使用size classes
                     //使用AnyLayout
        Example5()   //使用ViewThatFits
    }
    
    struct Example1: View {
        var body: some View {
            VStack {
                Button("Login") {  }
                Button("Reset password") {  }
                Button("Create account") {  }
            }
            .buttonStyle(ActionButtonStyle())
        }
    }
    
    struct Example2: View {
        var body: some View {
            DynamicStack {
                Button("Login") {  }
                Button("Reset password") {  }
                Button("Create account") {  }
            }
            .buttonStyle(ActionButtonStyle())
        }
    }
    
    struct Example3: View {
        var body: some View {
            DynamicStack1 {
                Button("Login") {  }
                Button("Reset password") {  }
                Button("Create account") {  }
            }
            .buttonStyle(ActionButtonStyle())
        }
    }
    
    struct Example5: View {
        var body: some View {
            DynamicStack3 {
                Button("Login") {  }
                Button("Reset password") {  }
                Button("Create account") {  }
            }
            .buttonStyle(ActionButtonStyle())
        }
    }
}

struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fixedSize()
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

// 方案4：使用ViewThatFits

struct DynamicStack3<Content: View>: View {
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    @ViewBuilder var content: () -> Content

    var body: some View {
        ViewThatFits {
            HStack(// 请注意，在这种情况下，我们首先放置HStack是很重要的，因为VStack可能总是合适的，即使在我们希望布局水平的情况下
                alignment: verticalAlignment,
                spacing: spacing,
                content: content
            )

            VStack(//同样重要的是要指出，上述基于视图的技术将始终尝试使用我们的HStack，即使使用紧凑尺寸类渲染时也是如此，并且仅在HStack不适合时才会选择基于VStack的布局。
                alignment: horizontalAlignment,
                spacing: spacing,
                content: content
            )
        }
    }
}

// 方案3：使用AnyLayout 和方案2相比，保留了底部渲染
//struct DynamicStack2<Content: View>: View {
//    var horizontalAlignment = HorizontalAlignment.center
//    var verticalAlignment = VerticalAlignment.center
//    var spacing: CGFloat?
//    @ViewBuilder var content: () -> Content
//    @Environment(\.horizontalSizeClass) private var sizeClass
//
//    var body: some View {
//        currentLayout(content)
//    }
//}
//
//private extension DynamicStack2 {
//    var currentLayout: AnyLayout {
//        switch sizeClass {
//        case .regular, .none:
//            return horizontalLayout
//        case .compact:
//            return verticalLayout
//        @unknown default:
//            return verticalLayout
//        }
//    }
//
//    var horizontalLayout: AnyLayout {
//        AnyLayout(HStack(
//            alignment: verticalAlignment,
//            spacing: spacing
//        ))
//    }
//
//    var verticalLayout: AnyLayout {
//        AnyLayout(VStack(
//            alignment: horizontalAlignment,
//            spacing: spacing
//        ))
//    }
//}


// 方案2：使用size classes
struct DynamicStack1<Content: View>: View {
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    @ViewBuilder var content: () -> Content
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        switch sizeClass {
        case .regular:
            hStack
        case .compact, .none:
            vStack
        @unknown default:
            vStack
        }
    }
}

private extension DynamicStack1 {
    var hStack: some View {
        HStack(
            alignment: verticalAlignment,
            spacing: spacing,
            content: content
        )
    }

    var vStack: some View {
        VStack(
            alignment: horizontalAlignment,
            spacing: spacing,
            content: content
        )
    }
}

// 方案1： 使用GeometryReader来解决横竖屏动态切换HStack、VStack的问题
struct DynamicStack<Content: View>: View {
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    @ViewBuilder var content: () -> Content

    var body: some View {
        GeometryReader { proxy in
            Group {
                if proxy.size.width > proxy.size.height {
                    HStack(
                        alignment: verticalAlignment,
                        spacing: spacing,
                        content: content
                    )
                } else {
                    VStack(
                        alignment: horizontalAlignment,
                        spacing: spacing,
                        content: content
                    )
                }
            }
        }
    }
}

struct ChangeStack_Previews: PreviewProvider {
    static var previews: some View {
        ChangeStack()
    }
}
