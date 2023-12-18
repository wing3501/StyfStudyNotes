//
//  GameViewController.swift
//  GloopDrop
//
//  Created by 申屠云飞 on 2023/12/14.
//

import UIKit
import SpriteKit
import GameplayKit

// SKSpriteNode：可能是使用最广泛的类型，此节点绘制矩形纹理、图像或颜色。
// SKShapeNode：这种类型的节点与Core Graphics一起使用，以绘制自定义形状。
// SKLabelNode：当您需要文本时，这种类型的节点用于绘制文本标签。
// SKVideoNode：使用这种类型的节点，您可以显示视频内容。
// SKReferenceNode：虽然从技术上讲不被视为可视节点，但它是一个特殊的节点，您可以在其中创建可重用的内容。
// SKEffectNode：这种类型的节点用于缓存或应用核心图像滤镜以获得特殊效果。
// SKCropNode：当您需要遮罩像素时，可以使用这种类型的节点。

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
//            let scene = GameScene(size: view.bounds.size)
            let scene = GameScene(size: CGSize(width: 1336, height: 1024))
            scene.scaleMode = .aspectFill
            scene.backgroundColor = UIColor(red: 105/255, green: 157/255, blue: 181/255, alpha: 1.0)
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = false
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
