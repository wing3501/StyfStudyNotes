//
//  Player.swift
//  ValsRevenge
//
//  Created by 申屠云飞 on 2023/12/21.
//

import SpriteKit

enum Direction: String {
case stop
case left
case right
case up
case down
}

class Player: SKSpriteNode {
    func move(_ direction: Direction) {
        print("move player: \(direction.rawValue)")
        // 使用物理引擎移动
        switch direction {
        case .up:
            physicsBody?.velocity = CGVector(dx: 0, dy: 100)
//            physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
//            physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
        case .down:
            physicsBody?.velocity = CGVector(dx: 0, dy: -100)
        case .left:
            physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        case .right:
            physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        case .stop:
            stop()
        }
    }
    
    func stop() {
        print("stop player")
        physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
}
