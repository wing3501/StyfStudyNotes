//
//  TriangleArrow.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/28.
//

import Foundation
import SwiftUI

struct TriangleArrow: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)//绘制起点设定在 rect 的零点 (左上)
            
            path.addArc(center: CGPoint(x: -rect.width / 5, y: rect.height / 2),
                        radius: rect.width / 2,
                        startAngle: .degrees(-45),
                        endAngle: .degrees(45),
                        clockwise: false)
            
            
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
//            最后一段线段不需要手动添加，可以直接使用 closeSubpath 让绘制回到原 点，从而得到闭合曲线。
            path.closeSubpath()
        }
    }
}
