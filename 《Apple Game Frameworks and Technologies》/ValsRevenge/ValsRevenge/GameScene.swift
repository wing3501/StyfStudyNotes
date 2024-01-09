//
//  GameScene.swift
//  ValsRevenge
//
//  Created by 申屠云飞 on 2023/12/20.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var player: Player?
    
    let margin = 20.0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        
    }
    
    override func didMove(to view: SKView) {
        player = childNode(withName: "player") as? Player
        player?.move(.stop)
        
        setupCamera()
    }
    
    func setupCamera() {
        guard let player else { return }
        let distance = SKRange(constantValue: 0)
        let playerConstaint = SKConstraint.distance(distance, to: player)
        // 使用约束来保持相机节点牢固地连接到玩家
        camera?.constraints = [playerConstaint]
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode {
            if touchedNode.name?.starts(with: "controller_") == true {
                let direction = touchedNode.name?.replacingOccurrences(of: "controller_", with: "")
                player?.move(Direction(rawValue: direction ?? "stop")!)
            }else if touchedNode.name == "button_attack" {
                player?.attack()
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode {
            if touchedNode.name?.starts(with: "controller_") == true {
                let direction = touchedNode.name?.replacingOccurrences(of: "controller_", with: "")
                player?.move(Direction(rawValue: direction ?? "stop")!)
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode {
            if touchedNode.name?.starts(with: "controller_") == true {
                player?.stop()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    /// 每当场景完成处理动画所需的所有步骤后需要更新节点或逻辑时，didFinishUpdate（） 方法就会派上用场
    override func didFinishUpdate() {
        updateControllerLocation()
    }
    
    func updateControllerLocation() {
        let controller = childNode(withName: "//controller")
        controller?.position = CGPoint(x: viewLeft + margin + insets.left, y: viewBotton + margin + insets.bottom)
        let attackButton = childNode(withName: "//attackButton")
        attackButton?.position = CGPoint(x: viewRight - margin - insets.right, y: viewBotton + margin + insets.bottom)
    }
}
