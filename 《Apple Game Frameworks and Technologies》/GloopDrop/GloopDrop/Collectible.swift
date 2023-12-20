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
    
    private let playCollectSound = SKAction.playSoundFileNamed("collect.wav", waitForCompletion: false)// 通过将 waitForCompletion 参数设置为 false，您可以告诉 SpriteKit 忽略音频文件的长度，并认为该操作已立即完成。或者，您可以将此选项设置为 true，使操作的持续时间与音频播放的长度相同。
    private let playMissSound = SKAction.playSoundFileNamed("miss.wav", waitForCompletion: false)
    
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
        
        name = "co_\(collectibleType)"
        anchorPoint = CGPoint(x: 0.5, y: 1)
        zPosition = Layer.collectible.rawValue
        
        physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: 0, y: -size.height / 2))
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.collectible
        physicsBody?.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.foreground
        physicsBody?.collisionBitMask = PhysicsCategory.none
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
    
    func collected() {
        let removeFromParent = SKAction.removeFromParent()
        let actionGroup = SKAction.group([playCollectSound, removeFromParent])
        run(actionGroup)
    }
    
    func missed() {
        let move = SKAction.moveBy(x: 0, y: -size.height/1.5, duration: 0)
        let splatX = SKAction.scaleX(to: 1.5, duration: 0)
        let splatY = SKAction.scaleY(to: 0.5, duration: 0)
        
//        let removeFromParent = SKAction.removeFromParent()
        let actionGroup = SKAction.group([playMissSound, move, splatX, splatY])
        run(actionGroup)
    }
}
