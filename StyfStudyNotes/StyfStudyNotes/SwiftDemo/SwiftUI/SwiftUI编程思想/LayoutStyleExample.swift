//
//  LayoutStyleExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/5.
//

import SwiftUI

struct LayoutStyleExample: View {
    var body: some View {
        VStack {
            Circle()
                .fill(.blue)
                .frame(width: 75, height: 75, alignment: .center)
                .overlay(content: {
                    Circle()
                        .strokeBorder(.white)
                        .padding(3)
                })
                .overlay {
                    Text("Hello")
                        .foregroundColor(.white)
                }
            
            Text("Hello")
            .circle(foreground: .white, background: .gray)
            
            CircleWrapper {
                Text("Hello")
            }
            
            Text("Hello").modifier(CircleModifier())

            Button("Hello") {
                
            }
            .buttonStyle(CircleStyle())
            
//            buttonStyle 的另一个优点是，我们可以一次性地为多个按钮添加样式。buttonStyle 修饰器是
//            定义在 View 上的，它会更改环境。
            HStack {
                Button("One", action: {})
                Button("Two", action: {})
                Button("Three", action: {})
            }.buttonStyle(CircleStyle())
        }
    }
}

extension View {
    func circle(foreground: Color = .white, background: Color = .blue) -> some View {
        Circle()
            .fill(background)
            .overlay(
                Circle()
                    .strokeBorder(foreground)
                    .padding(3))
            .overlay(
                self.foregroundColor(foreground))
            .frame(width: 75, height: 75)
    }
}

struct CircleWrapper<Content: View>: View {
    var foreground, background: Color
    var content: Content
    init(foreground: Color = .white, background: Color = .blue,
         @ViewBuilder content: () -> Content) {
        self.foreground = foreground
        self.background = background
        self.content = content()
    }
    
    var body: some View {
        Circle()
        .fill(background)
        .overlay(
            Circle()
                .strokeBorder(foreground)
                .padding(3))
        .overlay(content.foregroundColor(foreground))
        .frame(width: 75, height: 75)
    }
}

//还有第三种选项:我们可以创建一个 ViewModifier。这通常用在将其他 view 进行包装，或者是改变一个 view 的布局方式的时候
struct CircleModifier: ViewModifier {
    var foreground = Color.white
    var background = Color.blue
    func body(content: Content) -> some View {
        Circle()
        .fill(background)
        .overlay(Circle().strokeBorder(foreground).padding(3))
        .overlay(content.foregroundColor(foreground))
        .frame(width: 75, height: 75)
    }
}

//按钮样式
struct CircleStyle: ButtonStyle {
    var foreground = Color.white
    var background = Color.blue
    func makeBody(configuration: Configuration) -> some View {
        Circle()
        .fill(background.opacity(configuration.isPressed ? 0.8 : 1))
        .overlay(Circle().strokeBorder(foreground).padding(3))
        .overlay(configuration.label.foregroundColor(foreground))
        .frame(width: 75, height: 75)
    }
}

struct LayoutStyleExample_Previews: PreviewProvider {
    static var previews: some View {
        LayoutStyleExample()
    }
}
