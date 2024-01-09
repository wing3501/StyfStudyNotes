//
//  GameScene+ViewUpdates.swift
//  ValsRevenge
//
//  Created by 申屠云飞 on 2024/1/9.
//

import SpriteKit

extension GameScene: GameViewControllerDelegate {
    func didChangeLayout() {
        let w = view?.bounds.size.width ?? 1024
        let h = view?.bounds.size.height ?? 1336
        if h > w {
            // 竖屏
            camera?.setScale(1.0)
        }else {
            camera?.setScale(1.25)
        }
    }
}
