//
//  GameScene.swift
//  GloopDrop
//
//  Created by 申屠云飞 on 2023/12/14.
//

import SpriteKit
import GameplayKit
import AVFoundation

//1. 调用 update（_：） 方法。此方法每帧调用一次，是用于执行游戏逻辑的主要方法。
//2. SKScene对动作进行评估。此时，您的场景将处理它需要处理的所有操作。
//3. 调用 didEvaluateActions（） 方法。在处理完帧的所有操作后，将调用此方法。
//4. SKScene模拟物理。此时，您的场景将处理具有附加物理实体的节点上的所有物理场。
//5. 调用 didSimulatePhysics（） 方法。此方法在处理完帧的所有物理场后调用。
//6. SKScene 应用约束。此时，场景将处理需要处理的所有约束。
//7. 调用 didApplyConstraints（） 方法。在处理完帧的所有约束后，将调用此方法。
//8. 调用 didFinishUpdate（） 方法。处理完所有内容后，将调用此方法。
//9. SKView终于渲染了场景。

class GameScene: SKScene {
    
    let player = Player()
    
    let playerSpeed: CGFloat = 1.5
    
    var level = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var numberOfDrops: Int = 10
    
    var dropsExpected = 10
    var dropsCollected = 0
    
    var dropSpeed: CGFloat = 1.0
    var minDropSpeed: CGFloat = 0.12
    var maxDropSpeed: CGFloat = 1.0
    
    var movingPlayer = false
    var lastPositon: CGPoint?
    
    var scoreLabel = SKLabelNode()
    var levelLabel = SKLabelNode()
    
    let musicAudioNode = SKAudioNode(fileNamed: "music.mp3")
    
    var gameInProgress = false
    
    override func didMove(to view: SKView) {
        
        audioEngine.mainMixerNode.outputVolume = 0
        // 设置音乐
        musicAudioNode.autoplayLooped = true
        musicAudioNode.isPositional = false //用于根据侦听器节点更改音频
        addChild(musicAudioNode)
        musicAudioNode.run(SKAction.changeVolume(to: 0, duration: 0))
        run(SKAction.wait(forDuration: 1)) {[unowned self] in
            audioEngine.mainMixerNode.outputVolume = 1
            musicAudioNode.run(SKAction.changeVolume(to: 0.75, duration: 2.0))
        }
        
        // 设置代理
        physicsWorld.contactDelegate = self
        
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
        
        foreground.physicsBody = SKPhysicsBody(edgeLoopFrom: foreground.frame)
        foreground.physicsBody?.affectedByGravity = false
        foreground.physicsBody?.categoryBitMask = PhysicsCategory.foreground
        foreground.physicsBody?.contactTestBitMask = PhysicsCategory.collectible
        foreground.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        addChild(foreground)
        
        setupLabels()
        
        // 设置玩家
        player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
        player.setupConstraints(floor: foreground.frame.maxY)
        addChild(player)
//        player.walk()
        
//        spawnMultipleGloops()
        
        showMessage("Tap to start game")
    }
    
//    override func update(_ currentTime: TimeInterval) {
//        checkForRemainingDrops()
//    }
    
    func setupLabels() {
        scoreLabel.name = "score"
        scoreLabel.fontName = "Nosifer"
        scoreLabel.fontColor = .yellow
        scoreLabel.fontSize = 35.0
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.zPosition = Layer.ui.rawValue
        scoreLabel.position = CGPoint(x: frame.maxX - 50, y: viewTop() - 100)
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
     
        levelLabel.name = "level"
        levelLabel.fontName = "Nosifer"
        levelLabel.fontColor = .yellow
        levelLabel.fontSize = 35.0
        levelLabel.horizontalAlignmentMode = .left
        levelLabel.verticalAlignmentMode = .center
        levelLabel.zPosition = Layer.ui.rawValue
        levelLabel.position = CGPoint(x: frame.minX + 50, y: viewTop() - 100)
        levelLabel.text = "Level: \(level)"
        addChild(levelLabel)
    }
    
    func showMessage(_ message: String) {
        let messageLabel = SKLabelNode()
        messageLabel.name = "message"
        messageLabel.position = CGPoint(x: frame.midX, y: player.frame.maxY + 100)
        messageLabel.zPosition = Layer.ui.rawValue
        
        messageLabel.numberOfLines = 2
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: SKColor(red: 251.0/255.0, green: 155.0/255.0, blue: 24.0/255.0, alpha: 1.0),
            .backgroundColor: UIColor.clear,
            .font: UIFont(name: "Nosifer", size: 45.0)!,
            .paragraphStyle: paragraph
        ]
        
        messageLabel.attributedText = NSAttributedString(string: message, attributes: attributes)
        
        messageLabel.run(SKAction.fadeIn(withDuration: 0.25))
        addChild(messageLabel)
    }
    
    func hideMessage() {
        if let messageLabel = childNode(withName: "//message") as? SKLabelNode {
            messageLabel.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.25),SKAction.removeFromParent()]))
        }
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
    
    func checkForRemainingDrops() {
        if dropsCollected == dropsExpected {
            nextLevel()
        }
    }
    
    func nextLevel() {
        showMessage("Get Ready!")
        let wait = SKAction.wait(forDuration: 2.25)
        run(wait) {[unowned self] in 
            self.level += 1
            self.spawnMultipleGloops()
        }
    }
    
    func gameOver() {
        showMessage("Game Over\nTap to try again")
        
        gameInProgress = false
        
        player.die()
        
        removeAction(forKey: "gloop")
        
        enumerateChildNodes(withName: "co_*") { node, stop in
            print("------\(String(describing: node.name))")
            node.removeAction(forKey: "drop")
            node.physicsBody = nil
        }
        
        resetPlayerPosition()
        popRemainingDrops()
    }
    
    func resetPlayerPosition() {
        let resetPoint = CGPoint(x: frame.midX, y: player.position.y)
        let distance = hypot(resetPoint.x - player.position.x, 0)
        let calculatedSpeed = TimeInterval(distance / (playerSpeed * 2)) / 255
        if frame.midX < player.position.x {
            player.moveToPosition(pos: resetPoint, direction: "L", speed: calculatedSpeed)
        }else {
            player.moveToPosition(pos: resetPoint, direction: "R", speed: calculatedSpeed)
        }
    }
    
    func popRemainingDrops() {
        var i = 0
        enumerateChildNodes(withName: "co_*") { node, stop in
            let initiaWait = SKAction.wait(forDuration: 1.0)
            let wait = SKAction.wait(forDuration: TimeInterval(0.15 * CGFloat(i)))
            
            let removeFromParent = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([initiaWait, wait, removeFromParent])
            node.run(actionSequence)
            
            i += 1
        }
    }
    
    func spawnMultipleGloops() {
        player.walk()
        
        if gameInProgress == false {
            score = 0
            level = 1
        }
        
        switch level {
        case 1, 2, 3, 4, 5:
            numberOfDrops = level * 10
        case 6:
            numberOfDrops = 75
        case 7:
            numberOfDrops = 100
        case 8:
            numberOfDrops = 150
        default:
            numberOfDrops = 150
        }
        
        dropsCollected = 0
        dropsExpected = numberOfDrops
        
        // 下落速度
        dropSpeed = 1 / (CGFloat(level) + (CGFloat(level) / CGFloat(numberOfDrops)))
        if dropSpeed < minDropSpeed {
            dropSpeed = minDropSpeed
        }else if dropSpeed > maxDropSpeed {
            dropSpeed = maxDropSpeed
        }
        
        let wait = SKAction.wait(forDuration: TimeInterval(dropSpeed))
        let spawn = SKAction.run { [unowned self] in
            self.spawnGloop()
        }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeat(sequence, count: numberOfDrops)
        run(repeatAction, withKey: "gloop")
        
        gameInProgress = true
        
        hideMessage()
    }
    
    func touchDown(atPoint pos: CGPoint) {
        if gameInProgress == false {
            spawnMultipleGloops()
            return
        }
        
        let touchedNode = atPoint(pos)
        if touchedNode.name == "player" {
            movingPlayer = true
        }
//        // 根据当前位置和点击位置计算速度
//        let distance = hypot(pos.x - player.position.x, pos.y - player.position.y)
//        let calculatedSpeed = TimeInterval(distance / playerSpeed) / 255
//        if pos.x < player.position.x {
//            player.moveToPosition(pos: pos, direction: "L", speed: calculatedSpeed)
//        }else {
//            player.moveToPosition(pos: pos, direction: "R", speed: calculatedSpeed)
//        }
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        if movingPlayer {
            let newPos = CGPoint(x: pos.x, y: player.position.y)
            player.position = newPos
            
            let recordedPosition = lastPositon ?? player.position
            if recordedPosition.x > newPos.x {
                player.xScale = -abs(xScale)
            }else {
                player.xScale = abs(xScale)
            }
            
            lastPositon = newPos
        }
    }
    
    func touchUp(atPoint pos: CGPoint) {
        movingPlayer = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchMoved(toPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchUp(atPoint: t.location(in: self))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchUp(atPoint: t.location(in: self))
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.player | PhysicsCategory.collectible {
            // 玩家碰撞收集品
            let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectible ? contact.bodyA.node : contact.bodyB.node
            if let sprite = body as? Collectible {
                sprite.collected()
                dropsCollected += 1
                score += level
                checkForRemainingDrops()
            }
        }
        if collision == PhysicsCategory.foreground | PhysicsCategory.collectible {
            // 地面碰撞收集品
            let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectible ? contact.bodyA.node : contact.bodyB.node
            if let sprite = body as? Collectible {
                sprite.missed()
                gameOver()
            }
        }
    }
}
