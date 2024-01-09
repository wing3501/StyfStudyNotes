//
//  SKScene+ViewProperties.swift
//  ValsRevenge
//
//  Created by 申屠云飞 on 2024/1/9.
//

import SpriteKit

extension SKScene {
    // 使用这四个计算属性来帮助定位视图的四个角（可见屏幕区域）
    var viewTop: CGFloat {
        convertPoint(fromView: CGPoint(x: 0, y: 0)).y
    }
    
    var viewBotton: CGFloat {
        guard let view else { return 0.0 }
        return convertPoint(fromView: CGPoint(x: 0, y: view.bounds.size.height)).y
    }
    
    var viewLeft: CGFloat {
        convertPoint(fromView: CGPoint(x: 0, y: 0)).x
    }
    
    var viewRight: CGFloat {
        guard let view else { return 0.0 }
        return convertPoint(fromView: CGPoint(x: view.bounds.size.width, y: 0)).x
    }
    
    var insets: UIEdgeInsets {
        UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
    }
    
}
