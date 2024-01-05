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
case topLeft
case topRight
case bottomLeft
case bottomRight
}

class Player: SKSpriteNode {
    /// 玩家当前方向
    private var currentDirection = Direction.stop
    
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
        case .topLeft:
            physicsBody?.velocity = CGVector(dx: -100, dy: 100)
        case .topRight:
            physicsBody?.velocity = CGVector(dx: 100, dy: 100)
        case .bottomLeft:
            physicsBody?.velocity = CGVector(dx: -100, dy: -100)
        case .bottomRight:
            physicsBody?.velocity = CGVector(dx: 100, dy: -100)
        case .stop:
            stop()
        }
        if direction != .stop {
            currentDirection = direction
        }
    }
    
    func stop() {
        print("stop player")
        physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func attack() {
        let projectile = SKSpriteNode(imageNamed: "knife")
        projectile.position = CGPoint(x: 0.0, y: 0.0)
        addChild(projectile)
        
        var throwDirection = CGVector(dx: 0, dy: 0)
        switch currentDirection {
        case .left:
            throwDirection = CGVector(dx: -300, dy: 0)
            projectile.zRotation = CGFloat.pi/2
        case .right, .stop:
            throwDirection = CGVector(dx: 300, dy: 0)
            projectile.zRotation = -CGFloat.pi/2
        case .up:
            throwDirection = CGVector(dx: 0, dy: 300)
            projectile.zRotation = 0
        case .down:
            throwDirection = CGVector(dx: 0, dy: -300)
            projectile.zRotation = -CGFloat.pi
        case .topLeft:
            throwDirection = CGVector(dx: -300, dy: 300)
            projectile.zRotation = CGFloat.pi/4
        case .topRight:
            throwDirection = CGVector(dx: 300, dy: 300)
            projectile.zRotation = -CGFloat.pi/4
        case .bottomLeft:
            throwDirection = CGVector(dx: -300, dy: -300)
            projectile.zRotation = 3 * CGFloat.pi/4
        case .bottomRight:
            throwDirection = CGVector(dx: 300, dy: -300)
            projectile.zRotation = 3 * -CGFloat.pi/4
        }
        let throwProjectile = SKAction.move(by: throwDirection, duration: 0.25)
        projectile.run(throwProjectile, completion: { projectile.removeFromParent() })
    }
}
