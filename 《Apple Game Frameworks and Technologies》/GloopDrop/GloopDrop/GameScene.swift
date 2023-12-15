//
//  GameScene.swift
//  GloopDrop
//
//  Created by 申屠云飞 on 2023/12/14.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        // 设置背景
        let background = SKSpriteNode(imageNamed: "background_1")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.background.rawValue
        addChild(background)
        
        // 设置前景
        let foreground = SKSpriteNode(imageNamed: "foreground_1")
        foreground.position = CGPoint(x: 0, y: 0)
        foreground.anchorPoint = CGPoint(x: 0, y: 0)
        foreground.zPosition = Layer.foreground.rawValue
        addChild(foreground)
        
        // 设置玩家
        let player = Player()
        player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
        addChild(player)
        player.walk()
        
    }
}
