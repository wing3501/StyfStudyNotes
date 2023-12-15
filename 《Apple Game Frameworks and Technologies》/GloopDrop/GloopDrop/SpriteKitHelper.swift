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
}

