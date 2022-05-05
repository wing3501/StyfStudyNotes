//
//  CustomAlignment.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/5.
//

import SwiftUI

struct CustomAlignment: View {
    var body: some View {
//        HStack(alignment: .myCenter) {
//            Rectangle().fill(Color.blue).frame(width: 50, height: 50)
//            Rectangle().fill(Color.green).frame(width: 30, height: 30)
//        }
        
        
        HStack(alignment: .myCenter) {
            Rectangle().fill(Color.blue).frame(width: 50, height: 50)
            Rectangle().fill(Color.green).frame(width: 30, height: 30)
            Rectangle().fill(Color.red).frame(width: 40, height: 40)
                .alignmentGuide(.myCenter, computeValue: { dim in
                    //矩形的中心位置-20，作为对齐
                    return dim[.myCenter] - 20 })
        }.border(Color.black)
    }
}

enum MyCenterID: AlignmentID {
//    一旦 HStack 知道了每个子 view 的尺寸，它就可以使用 defaultValue(in:) 方法来计算每个 view 的中心位置了。
//    这个方法会为每个子 view 调用一次，而且它将获得每个子 view 的尺寸作 为 ViewDimensions 参数。
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        return context.height / 2
    }
}

extension VerticalAlignment {
    static let myCenter1: VerticalAlignment = VerticalAlignment(MyCenterID.self)
}


struct CustomAlignment_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignment()
    }
}
