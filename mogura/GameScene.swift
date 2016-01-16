//
//  GameScene.swift
//  mogura
//
//  Created by 上田 志雄 on 2016/01/10.
//  Copyright Yukio Denevienne Ueda
//

import SpriteKit
import Foundation

class GameScene: SKScene {
    
    // モグラスプライトの配置
    var moguras: [SKSpriteNode] = []
    
    // モグラの初期座標の配列
    let moguraPosition = [CGPoint(x: 100, y: 165), CGPoint(x: 275,y: 165), CGPoint(x: 100,y: 15), CGPoint(x: 275, y: 15)]
    
    // スコア表示用
    var score = 0
    var scoreLabel: SKLabelNode?
    
    // カウンタ表示用
    var timeCount = 30
    var countLabel: SKLabelNode?
    var timer = NSTimer()
    
    // 効果音用
    var seAction: SKAction?
    
    // 乱数用
    var maxvalue: Double = 5.0
  
    // シーンが表示された時に呼ばれる
    override func didMoveToView(view: SKView) {
        
        // 背景画像のスプライトを配置する
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width * 0.5, y:self.size.height * 0.5)
        addChild(background)
        
        // 穴画像のスプライトを配置する
        let hole1 = SKSpriteNode(imageNamed: "hole")
        hole1.position = CGPoint(x: 100, y: 200)
        addChild(hole1)
        
        moguras.append(SKSpriteNode(imageNamed: "torupa"))
        moguras[0].position = moguraPosition[0]
        
        addChild(moguras[0])
        
        let hide1 = SKSpriteNode(imageNamed: "bg_hide")
        hide1.position = CGPoint(x: 100, y:176)
        hide1.userInteractionEnabled = false;
        addChild(hide1)
        
        let hole2 = SKSpriteNode(imageNamed: "hole")
        hole2.position = CGPoint(x: 275, y: 200)
        addChild(hole2)
        
        moguras.append(SKSpriteNode(imageNamed: "torupa"))
        moguras[1].position = moguraPosition[1]
        addChild(moguras[1])
        
        let hide2 = SKSpriteNode(imageNamed: "bg_hide")
        hide2.position = CGPoint(x: 275, y: 176)
        hide2.userInteractionEnabled = false;
        addChild(hide2)
        
        let hole3 = SKSpriteNode(imageNamed: "hole")
        hole3.position = CGPoint(x: 100, y: 50)
        addChild(hole3)
        
        moguras.append(SKSpriteNode(imageNamed: "torupa"))
        moguras[2].position = moguraPosition[2]
        addChild(moguras[2])
        
        let hide3 = SKSpriteNode(imageNamed: "bg_hide")
        hide3.position = CGPoint(x:100, y:26)
        hide3.userInteractionEnabled = false;
        addChild(hide3)
        
        let hole4 = SKSpriteNode(imageNamed: "hole")
        hole4.position = CGPoint(x: 275, y: 50)
        addChild(hole4)
        
        moguras.append(SKSpriteNode(imageNamed: "torupa"))
        moguras[3].position = moguraPosition[3]
        addChild(moguras[3])
        
        let hide4 = SKSpriteNode(imageNamed: "bg_hide")
        hide4.position = CGPoint(x: 275, y: 26)
        hide4.userInteractionEnabled = false;
        addChild(hide4)
        
        // スコアーとカウンタを表示する
        let scoreLabel = SKLabelNode (fontNamed: "ArialRoundMYBold")
        scoreLabel.fontSize = 32
        scoreLabel.fontColor = UIColor.brownColor()
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        scoreLabel.position = CGPoint(x: 10, y: 610)
        addChild(scoreLabel)
        self.scoreLabel = scoreLabel
        
        let countLabel = SKLabelNode(fontNamed: "ArialRoundMyBold")
        countLabel.fontSize = 32
        countLabel.fontColor = UIColor.brownColor()
        countLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        countLabel.position = CGPoint(x: 10, y: 570)
        addChild(countLabel)
        self.countLabel = countLabel
        
        // 効果音
        let seAction = SKAction.playSoundFileNamed("se.mp3", waitForCompletion: false)
        self.seAction = seAction
        
        reset()
    }

    // モグラを上下させるアクションを設定する
    // 乱数 ret で速度調整
    func moguraAction(sprite: SKSpriteNode) {
        
        // 乱数用
        let ret: Double = CreateRandomInt.minMaxDesignation(min: 1, max: maxvalue) / 10
        
        // 0.5秒 〜 2.5秒　待機する
        let action1 = SKAction.waitForDuration(0.5, withRange: 2.0)
        
        // 現在の座標から ret 秒かけて y 方向へ 100 移動させる
        let action2 = SKAction.moveByX(0, y: 100, duration: ret)
        
        // 0秒 〜 ret 秒　待機する
        let action3 = SKAction.waitForDuration(ret, withRange: 1.0)
        
        // 現在の座標から ret 秒かけて y 方向へ -100 移動させる
        let action4 = SKAction.moveByX(0, y: -100, duration: ret)
        
        // action1〜4 を連続的に実行する
        let actionSequence = SKAction.sequence([action1, action2, action3, action4])
        
        // actionSequence を繰り返し実行する
        let actionRepeat = SKAction.repeatActionForever(actionSequence)
        
        sprite.runAction(actionRepeat)
    }

    // タッチイベント
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            // タッチされた場所の座標を取得する
            let location = touch.locationInNode(self)
            
            // タッチされたノードを得る
            let touchNode = self.nodeAtPoint(location)
            
            for mog in moguras {
                if touchNode == mog {
                    touchedMogura(mog)
                }
            }
            
        }
    }

    // モグラを叩いた時に呼ばれる
    func touchedMogura(sprite: SKSpriteNode) {
        
        // スコアを加算する
        score++
        scoreLabel?.text = "SCORE: \(score)"
        
        // 叩かれたモグラのアクションを止めて非表示にする
        sprite.removeAllActions()
        sprite.hidden = true
        
        // 書いてしながら飛ばされる
        let hitMogura = SKSpriteNode(imageNamed: "hit_torupa")
        hitMogura.position = sprite.position
        
        let action1 = SKAction.rotateByAngle(CGFloat(M_PI) * 2, duration: 1)
        let action2 = SKAction.moveByX(0, y: 200, duration: 1)
        let action3 = SKAction.fadeOutWithDuration(1)
        let action4 = SKAction.removeFromParent()
        let action123 = SKAction.group([action1, action2, action3])
        let sequence = SKAction.sequence([action123, action4])
        
        addChild(hitMogura)
        
        // 効果音を鳴らす
        runAction(seAction!)
        
        hitMogura.runAction(sequence, completion: {
            [unowned self] in
            
            // モグラの座標を初期値に戻して上下のアニメーションを再開させる
            if let index = self.moguras.indexOf(sprite) {
                sprite.position = self.moguraPosition[index]
            }
            sprite.hidden = false
            self.moguraAction(sprite)
            })
        }
        
        // リセットを行う
        func reset() {
            
            // スコアと残り時間をリセット
            score = 0
            timeCount = 30
            
            scoreLabel?.text = "SCORE: \(score)"
            countLabel?.text = "TIME: \(timeCount)"
            
            // タイマーを開始
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerUpdate", userInfo: nil, repeats: true)
            
            for index in 0...3 {
                moguras[index].position = moguraPosition[index]
                moguraAction(moguras[index])
            }
            
            let start = SKSpriteNode(imageNamed: "start")
            start.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
            
            // スタートを表示する
            let action1 = SKAction.waitForDuration(1.0)
            let action2 = SKAction.fadeOutWithDuration(1.0)
            let action3 = SKAction.removeFromParent()
            let sequence = SKAction.sequence([action1, action2, action3])
            
            addChild(start)
            start.runAction(sequence)
        }
        
        // タイマーが発火した時に呼ばれる
        func timerUpdate() {
            timeCount--
            
            if timeCount >= 0 {
                countLabel?.text = "TIME: \(timeCount)"
            } else {
                
                // タイマーを停止する
                timer.invalidate()
                
                let gameOverLabel = SKSpriteNode(imageNamed: "gameover")
                gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: 480)
                
                addChild(gameOverLabel)
                
                let action1 = SKAction.waitForDuration(1)
                let action2 = SKAction.fadeOutWithDuration(0.5)
                let action3 = SKAction.removeFromParent()
                let sequence = SKAction.sequence([action1, action2, action3])
                
                gameOverLabel.runAction(sequence, completion: {
                    [unowned self] in
                    
                    //ゲームオーバー画面に遷移する
                    let gameOverScene = GameOverScene(size: self.size)
                    gameOverScene.score = self.score
                    let skView = self.view as SKView!
                    gameOverScene.scaleMode = SKSceneScaleMode.AspectFit
                    skView.presentScene(gameOverScene)
                    })
            }
        }
        
}

