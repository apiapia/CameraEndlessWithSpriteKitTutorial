//
//  GameScene.swift
//  CameraEndless
//
//  Created by www.iFIERO.com on 2018/6/24.
//  Copyright © 2018 iFiero. All rights reserved.
//

import SpriteKit
import GameplayKit

public let CAMERA_MOVE_XPOS:CGFloat   = 12  /// 相机X-Axis移动的尺寸;
public let SCENE_NUMBERS:CGFloat = 2.0      /// 有几个场景scene

class GameScene: SKScene {
    
    private var player = PlayerClass()  /// 初始化自定义节点
    private var mainCamera:SKCameraNode!
    private var ground:SKSpriteNode! /// 地板
    private var bg:SKSpriteNode!    /// 背景
    private var cloud:SKSpriteNode! /// 云 cloud
    
    override func didMove(to view: SKView) {
        
        initUI()     /// 初始化Scene里的各个精灵节点
        initCamera() /// 初始化相机节点;
    }
    
    func initUI(){
        /// player名称为GameScene.sks 上自行命名的名称
        player = childNode(withName: "player") as! PlayerClass
        //MARK:- Emitter juice 加入果酱
        let trailNode = SKNode()
        trailNode.zPosition = 1
        self.addChild(trailNode)
        let emitter = SKEmitterNode(fileNamed: "Trail")!
        emitter.targetNode = trailNode
        player.addChild(emitter)
        
        
        player.initPlayer()   /// 拍打翅膀
        player.startWobbing() /// 开始Wobbing
        ground = childNode(withName: "ground") as! SKSpriteNode
        bg     = childNode(withName: "bg") as! SKSpriteNode
        cloud  = childNode(withName: "cloud") as! SKSpriteNode
    }
    
    func initCamera(){
        mainCamera = childNode(withName: "mainCamera") as! SKCameraNode
    }
    
    /// 移动节点
    func moveSprites(camera:SKCameraNode){
        /// 查找所有命名为ground的精灵节点
        enumerateChildNodes(withName: "//ground") { (node, _ ) in
            /// 如果当前的节点 + scene.size.with <  则移动节点
            if node.position.x + self.size.width < camera.position.x {
                node.position.x += self.size.width * SCENE_NUMBERS /// 更新节点的位置
            }
        }
        /// 查找bg
        enumerateChildNodes(withName: "//bg") { (node, _) in
            if node.position.x + self.size.width < camera.position.x {
                node.position.x += self.size.width * SCENE_NUMBERS
            }
        }
        ///查找所有云
        enumerateChildNodes(withName: "cloud") { (node, _) in
            if node.position.x + self.size.width < camera.position.x {
                node.position.x += self.size.width * SCENE_NUMBERS 
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        mainCamera.position.x += CAMERA_MOVE_XPOS /// 向前移动;
        player.position.x += CAMERA_MOVE_XPOS     /// player向右移动的速度和camera的速度一致
        moveSprites(camera: mainCamera)           /// 传入相机节点
    }
}
