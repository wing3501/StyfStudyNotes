//
//  UsingContentTransition.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/4.
//  内容转场动画  https://swiftwithmajid.com/2022/08/02/content-transition-in-swiftui/

import SwiftUI

struct UsingContentTransition: View {
    @State private var flag = false
    @State private var number = "99"
    
    var body: some View {
        example4
    }
    
    var example1: some View { //iOS16以前无动画
        VStack {
            Text(verbatim: "1000")
                .font(.system(size: 60))
                .fontWeight(flag ? .black : .light)
                .foregroundColor(flag ? .yellow : .red)
        }
        .onTapGesture {
            withAnimation(.default.speed(0.5)) {
                flag.toggle()
            }
        }
    }
    
    var example2: some View {
        VStack {
            Text(verbatim: "1000")
                .font(.system(size: 60))
                .fontWeight(flag ? .black : .light)
                .foregroundColor(flag ? .yellow : .red)
        }
        .contentTransition(.interpolate)
        .onTapGesture {
            withAnimation(.default.speed(0.5)) {
                flag.toggle()
            }
        }
    }
    
//    var example3: some View { //只针对数字的
//        Text(verbatim: number)
//            .font(.system(size: 60))
//            .contentTransition(.numericText())
//            .onTapGesture {
//                withAnimation(.default.speed(0.5)) {
//                    number = "98"
//                }
//            }
//    }
    
    var example4: some View {
        VStack {
            Text(verbatim: "3000")
                .font(.system(size: 60))
                .fontWeight(flag ? .black : .light)
                .foregroundColor(flag ? .yellow : .red)
        }
        .environment(\.contentTransitionAddsDrawingGroup, true)//GPU加速渲染
        .contentTransition(.interpolate)
        .onTapGesture {
            withAnimation(.default.speed(0.5)) {
                flag.toggle()
            }
        }
    }
}

struct UsingContentTransition_Previews: PreviewProvider {
    static var previews: some View {
        UsingContentTransition()
    }
}
