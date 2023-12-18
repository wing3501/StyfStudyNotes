//
//  Player.swift
//  GloopDrop
//
//  Created by 申屠云飞 on 2023/12/14.
//

import Foundation
import SpriteKit

enum PlayerAnimationType: String {
case walk
}

class Player: SKSpriteNode {
    private var walkTextures: [SKTexture]?
    
    init() {
        let texture = SKTexture(imageNamed: "blob-walk_0")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        walkTextures = loadTextures(atlas: "blob", prefix: "blob-walk_", startsAt: 0, stopsAt: 2)
        
        name = "player"
        setScale(1)
        anchorPoint = CGPoint(x: 0.5, y: 0) //中下
        zPosition = Layer.player.rawValue
        
        //设置玩家物理
        physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: 0, y: size.height / 2.0)) // 因为节点的 anchorPoint 属性设置为 CGPoint（x： 0.5， y： 0.0），而物理实体的中心点是 （0.5,0.5），因此您需要一个偏移量。换句话说，如果你不调整这个中心点，你的物理体就不会与你的精灵节点对齐。
        physicsBody?.affectedByGravity = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.collectible
        physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置约束固定在场景上
    /// - Parameter floor: 地板
    func setupConstraints(floor: CGFloat) {
        let range = SKRange(lowerLimit: floor, upperLimit: floor)
        let lockToPlatform = SKConstraint.positionY(range)
        
        constraints = [lockToPlatform]
    }
    
    func walk() {
        guard let walkTextures else {
            preconditionFailure("找不到纹理")
        }
        startAnimation(textures: walkTextures, speed: 0.25, name: PlayerAnimationType.walk.rawValue, count: 0, resize: true, restore: true)
    }
    
    func moveToPosition(pos: CGPoint, direction: String, speed: TimeInterval) {
        switch direction {
        case "L":
            xScale = -abs(xScale)
        default:
            xScale = abs(xScale)
        }
        let moveAction = SKAction.move(to: pos, duration: speed)
        run(moveAction)
    }
}
