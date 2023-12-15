//
//  Collectible.swift
//  GloopDrop
//
//  Created by 申屠云飞 on 2023/12/15.
//

import Foundation
import SpriteKit

enum CollectibleType: String {
case none
case gloop
}

class Collectible: SKSpriteNode {
    private var collectibleType: CollectibleType = .none
    
    init(collectibleType: CollectibleType) {
        var texture: SKTexture!
        self.collectibleType = collectibleType
            
        switch collectibleType {
        case .gloop:
            texture = SKTexture(imageNamed: "gloop")
        default:
            break
        }
        super.init(texture: texture, color: .clear, size: texture.size())
        
        name = "CO_\(collectibleType)"
        anchorPoint = CGPoint(x: 0.5, y: 1)
        zPosition = Layer.collectible.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drop(dropSpeed: TimeInterval, floorLevel: CGFloat) {
        let pos = CGPoint(x: position.x, y: floorLevel)
        
        // 添加两个缩放动作，使水滴稍微伸展
        let scaleX = SKAction.scale(to: 1.0, duration: 1.0)
        let scaleY = SKAction.scale(to: 1.3, duration: 1.0)
        let scale = SKAction.group([scaleX, scaleY])
        
        let appear = SKAction.fadeAlpha(to: 1.0, duration: 0.25)
        let moveAction = SKAction.move(to: pos, duration: dropSpeed)
        let actionSequence = SKAction.sequence([appear, scale, moveAction])
        // 先收缩，然后运行跌落动作
        self.scale(to: CGSize(width: 0.25, height: 1))
        self.run(actionSequence, withKey: "drop")
    }
}
