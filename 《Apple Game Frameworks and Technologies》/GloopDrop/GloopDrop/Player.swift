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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func walk() {
        guard let walkTextures else {
            preconditionFailure("找不到纹理")
        }
        startAnimation(textures: walkTextures, speed: 0.25, name: PlayerAnimationType.walk.rawValue, count: 0, resize: true, restore: true)
    }
}
