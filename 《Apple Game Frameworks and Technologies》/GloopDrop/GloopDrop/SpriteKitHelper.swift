//
//  SpriteKitHelper.swift
//  GloopDrop
//
//  Created by 申屠云飞 on 2023/12/14.
//

import Foundation
import SpriteKit

enum Layer: CGFloat {
    case background
    case foreground
    case player
    case collectible
    case ui
}

enum PhysicsCategory {
    static let none: UInt32 = 0
    static let player: UInt32 = 0b1
    static let collectible: UInt32 = 0b10
    static let foreground: UInt32 = 0b100
}

extension SKSpriteNode {
    
    func loadTextures(atlas: String, prefix: String, startsAt: Int, stopsAt: Int) -> [SKTexture] {
        var textureArray: [SKTexture] = []
        let textureAtlas = SKTextureAtlas(named: atlas)
        for i in startsAt...stopsAt {
            let textureName = "\(prefix)\(i)"
            let temp = textureAtlas.textureNamed(textureName)
            textureArray.append(temp)
        }
        return textureArray
    }
    
    func startAnimation(textures: [SKTexture], speed: Double, name: String, count: Int, resize: Bool, restore: Bool) {
        if action(forKey: name) == nil {
            // timePerFrame 是显示每个纹理的时间量（以秒为单位）
            // resize 和 restore 指示操作应如何处理节点的大小和最终纹理。当 resize = true 时，精灵的大小与图像大小匹配。当 restore = true 时，将在操作完成时恢复原始纹理。
            let animation = SKAction.animate(with: textures, timePerFrame: speed, resize: resize, restore: restore)
            if count == 0 {
                let repeatAction = SKAction.repeatForever(animation)
                run(repeatAction, withKey: name)
            }else if count == 1 {
                run(animation, withKey: name)
            }else {
                let repeatAction = SKAction.repeat(animation, count: count)
                run(repeatAction, withKey: name)
            }
        }
    }
    
    func endlessScroll(speed: TimeInterval) {
        let moveAction = SKAction.moveBy(x: -self.size.width, y: 0, duration: speed)
        let resetAction = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        
        let sequenceAction = SKAction.sequence([moveAction, resetAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        run(repeatAction)
    }
}

extension SKScene {
    //将视图的坐标转换为场景坐标
    
    func viewTop() -> CGFloat {
        convertPoint(fromView: .zero).y
    }
    
    func viewBottom() -> CGFloat {
        guard let view else { return 0 }
        return convertPoint(fromView: CGPoint(x: 0, y: view.bounds.height)).y
    }
}

extension SKNode {
//    func setupScrollingView(imageNamed name: String, layer: Layer, blocks: Int, speed: TimeInterval) {
//        for i in 0..<blocks {
//            let spriteNode = SKSpriteNode(imageNamed: name)
//            spriteNode.anchorPoint = .zero
//            spriteNode.position = CGPointMake(CGFloat(i) * spriteNode.size.width, 0)
//            spriteNode.zPosition = layer.rawValue
//            spriteNode.name = name
//            
//            spriteNode.endlessScroll(speed: speed)
//            addChild(spriteNode)
//        }
//    }
    // 更新粒子版本
    func setupScrollingView(imageNamed name: String, layer: Layer,emitterNamed: String?, blocks: Int, speed: TimeInterval) {
        for i in 0..<blocks {
            let spriteNode = SKSpriteNode(imageNamed: name)
            spriteNode.anchorPoint = .zero
            spriteNode.position = CGPointMake(CGFloat(i) * spriteNode.size.width, 0)
            spriteNode.zPosition = layer.rawValue
            spriteNode.name = name
            
            if let emitterNamed,
                let partcles = SKEmitterNode(fileNamed: emitterNamed) {
                partcles.name = "particles"
                spriteNode.addChild(partcles)
            }
            
            spriteNode.endlessScroll(speed: speed)
            addChild(spriteNode)
        }
    }
}
