//
//  PlayerClass.swift
//  CameraEndless
//
//  Created by www.iFIERO.com on 2018/6/24.
//  Copyright © 2018 iFiero. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerClass:SKSpriteNode {
    
    private var playerTextureAtlas = SKTextureAtlas()
    private var playerTextures = [SKTexture]()
    // MARK:-玩家
    func initPlayer() {
        playerTextureAtlas = SKTextureAtlas(named: "penguin")
        for i in 1...playerTextureAtlas.textureNames.count {
            let imageName = "penguin0\(i)"
            playerTextures.append(SKTexture(imageNamed: imageName))
        }
        /// wobbing Player玩家
        let playerAnimation = SKAction.animate(with: playerTextures, timePerFrame: TimeInterval(0.1))
        let repeatAction = SKAction.repeatForever(playerAnimation)
        self.run(repeatAction, withKey: "flap") /// 排打翅膀
        
    }
    
    func startWobbing(){
        let moveUp   = SKAction.moveBy(x: 0, y: 50, duration: 0.5)
        moveUp.timingMode = .easeInEaseOut
        let moveDown = moveUp.reversed()
        let sequence = SKAction.sequence([moveUp,moveDown])
        let repeatWobble = SKAction.repeatForever(sequence)
        self.run(repeatWobble, withKey: "wobbing") /// 上下浮动
    }
}
