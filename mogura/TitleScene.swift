//
//  TitleScene.swift
//  mogura
//
//  Created by 上田 志雄 on 2016/01/16.
//  Copyright Yukio Denevienne Ueda.
//

import SpriteKit

class TitleScene : SKScene {
    var button: SKSpriteNode?
    
    // シーンが表示された時に呼ばれる
    override func didMoveToView(view: SKView) {
        
        //　背景画像のスプライトを配置する
        let background = SKSpriteNode(imageNamed: "bg_title")
        background.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        addChild(background)
        
        //　もう一度遊ぶボタンの表示
        let button = SKSpriteNode(imageNamed: "start")
        button.position = CGPoint(x: self.size.width * 0.5, y: 200)
        addChild(button)
        self.button = button
    }
    
    //　タッチイベント
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            // タッチされた場所の座標を取得
            let location = touch.locationInNode(self)
            
            //　タッチされたノードを得る
            let touchNode = self.nodeAtPoint(location)
            
            if touchNode == button {
                let gameScene = GameScene(size: size)
                let skView = view as SKView!
                gameScene.scaleMode = SKSceneScaleMode.AspectFit
                skView.presentScene(gameScene)
            }
        }
    }

}
