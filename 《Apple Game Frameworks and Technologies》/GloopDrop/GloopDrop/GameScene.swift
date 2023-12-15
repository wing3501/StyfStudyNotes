//
//  GameScene.swift
//  GloopDrop
//
//  Created by 申屠云飞 on 2023/12/14.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = Player()
    
    let playerSpeed: CGFloat = 1.5
    
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
        player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
        player.setupConstraints(floor: foreground.frame.maxY)
        addChild(player)
        player.walk()
        
        spawnMultipleGloops()
    }
    
    func spawnGloop() {
        let collectible = Collectible(collectibleType: .gloop)
        
        // 随机位置
        let margin = collectible.size.width * 2
        let dropRange = SKRange(lowerLimit: frame.minX + margin, upperLimit: frame.maxX - margin)
        let randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
        
        collectible.position = CGPoint(x: randomX, y: player.position.y * 2.5)
        addChild(collectible)
        collectible.drop(dropSpeed: TimeInterval(1.0), floorLevel: player.frame.minY)
    }
    
    func spawnMultipleGloops() {
        let wait = SKAction.wait(forDuration: TimeInterval(1.0))
        let spawn = SKAction.run { [unowned self] in
            self.spawnGloop()
        }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeat(sequence, count: 10)
        run(repeatAction, withKey: "gloop")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchDown(atPoint: t.location(in: self))
        }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        // 根据当前位置和点击位置计算速度
        let distance = hypot(pos.x - player.position.x, pos.y - player.position.y)
        let calculatedSpeed = TimeInterval(distance / playerSpeed) / 255
        if pos.x < player.position.x {
            player.moveToPosition(pos: pos, direction: "L", speed: calculatedSpeed)
        }else {
            player.moveToPosition(pos: pos, direction: "R", speed: calculatedSpeed)
        }
    }
    
}
