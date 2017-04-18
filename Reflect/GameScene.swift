//
//  GameScene.swift
//  Reflect
//
//  Created by Admin on 12/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let usedfDef = UserDefaults.standard
    
    var eventMusicPlayer = AVAudioPlayer()
    let toastyMusicUrl = Bundle.main.url(forResource: "toasty", withExtension: "wav")!
    
    let ballCategoryName = "Ball"
    let radiusBall: CGFloat = 10
    let paddleCategoryName = "Paddle"
    let rectPaddle: CGRect = CGRect(x: -100/2, y: -20/2, width: 100, height: 20)
    let borderCategoryName = "Border"
    let cherryCategoryName = "Cherry"
    let hitlerCtegoryName = "Hitler"
    var cherrySize: CGFloat = 50
    
    var speedVector:CGFloat = 2
    
    var gameHaveBeenStarted = false
    
    var score = 0
    var borderTouch = 3
    var scoreCherry = 0
    var hitlerAppear = 0
    var hitlerAppearCount = 10
    var loose = false
    
    let ballCategory:   UInt32 = 0x1 << 0
    let borderCategory: UInt32 = 0x1 << 1
    let paddleCategory: UInt32 = 0x1 << 2
    let cherryCategory: UInt32 = 0x1 << 3
    
    let hearts = [SKSpriteNode(imageNamed: "heart"), SKSpriteNode(imageNamed: "heart"), SKSpriteNode(imageNamed: "heart")]
    
    
    var gameMode = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
     
        if usedfDef.integer(forKey: "Speed") == 0 {
            
            usedfDef.set(Int(speedVector), forKey: "Speed")
            usedfDef.set(hitlerAppearCount, forKey: "SurprizeFreequence")
            usedfDef.set(Int(cherrySize), forKey: "CherrySize")
            usedfDef.set(gameMode, forKey: "GameMode")
            
        } else {
            
            speedVector = CGFloat(usedfDef.integer(forKey: "Speed"))
            hitlerAppearCount = usedfDef.integer(forKey: "SurprizeFreequence")
            cherrySize = CGFloat(usedfDef.integer(forKey: "CherrySize"))
            gameMode = usedfDef.bool(forKey: "GameMode")
        }
        
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = SKColor.black
        self.physicsWorld.gravity = CGVector(dx: 0,dy: 0)
        
        
        if gameMode == false {
            
            // CREATE Back to main menu button
        
            let backButton = AKButtonFromLabelNode(rect: CGRect(x: -60/2, y: -25/2, width: 60, height: 25))
            backButton.name = "BackButton"
            backButton.position = CGPoint(x: 60/2 + 10, y: self.frame.size.height - 25/2 - 10)
            backButton.text = "Back"
            backButton.fontSize = 20
            backButton.fontName = "unifont"
            backButton.fontColor = UIColor.black
        
            backButton.action = { [weak self] in
            
                if let strongSelf = self {
                
                    let userDef = UserDefaults.standard
                    userDef.set(strongSelf.gameMode, forKey: "GameMode")
                    strongSelf.view?.presentScene(MainMenu(size: strongSelf.frame.size), transition: SKTransition.fade(withDuration: 0.3))
                }
            }
            
            backButton.createLabel()
            self.addChild(backButton)
            
        }


        // CREATE Lives
        hearts[0].size = CGSize(width: 25, height: 25)
        hearts[0].anchorPoint = CGPoint(x: 0, y: 0)
        hearts[0].position = CGPoint(x: self.frame.width - 35,y: self.frame.height - 35)
        self.addChild(hearts[0])

        hearts[1].size = CGSize(width: 25, height: 25)
        hearts[1].anchorPoint = CGPoint(x: 0, y: 0)
        hearts[1].position = CGPoint(x: self.frame.width - 35 - 30,y: self.frame.height - 35)
        self.addChild(hearts[1])
        
        hearts[2].size = CGSize(width: 25, height: 25)
        hearts[2].anchorPoint = CGPoint(x: 0, y: 0)
        hearts[2].position = CGPoint(x: self.frame.width - 35 - 30 - 30,y: self.frame.height - 35)
        self.addChild(hearts[2])
        
        
        // CREATE BALL
        let ourBall = SKShapeNode(circleOfRadius: radiusBall)
        ourBall.name = ballCategoryName
        ourBall.fillColor = UIColor.green
        ourBall.strokeColor = UIColor.green
        ourBall.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        ourBall.physicsBody = SKPhysicsBody(circleOfRadius: radiusBall)
        ourBall.physicsBody?.isDynamic = true
        ourBall.physicsBody?.restitution = 1
        ourBall.physicsBody?.linearDamping = 0
        ourBall.physicsBody?.friction = 0
        self.addChild(ourBall)
        
        // CREATE PADDLE
        let paddle = SKShapeNode(rect: rectPaddle)
        paddle.name = paddleCategoryName
        paddle.fillColor = UIColor.green
        paddle.strokeColor = UIColor.green
        paddle.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 6)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.frame.size)
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.restitution = 1
        paddle.physicsBody?.linearDamping = 0
        paddle.physicsBody?.friction = 0
        self.addChild(paddle)
        
        // CREATE BORDER
        let areaWorld = CGRect(x: self.frame.origin.x + 1, y: self.frame.origin.y + 1, width: self.frame.size.width - 2, height: self.frame.size.height - 50)
        let border = SKShapeNode(rect: areaWorld)
        border.name = borderCategoryName
        border.strokeColor = UIColor.green
        border.position = CGPoint(x: self.frame.origin.x, y: self.frame.origin.x)
        border.physicsBody = SKPhysicsBody(edgeLoopFrom: areaWorld)
        border.physicsBody?.restitution = 1
        border.physicsBody?.linearDamping = 0
        border.physicsBody?.friction = 0
        self.addChild(border)
        
        // CREATE LABEL
        let labelGame = SKLabelNode(fontNamed: "unifont")
        labelGame.position = CGPoint(x: (self.frame.size.width / 2) - 50, y: self.frame.size.height - 35)
        labelGame.fontSize = 20
        labelGame.fontColor = SKColor.green
        labelGame.text = "Score: \(score) Bulbasaur: \(scoreCherry)" //"Score: 0 Bulbasaur: 0 Border: 3"
        labelGame.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        labelGame.name = "LabelGame"
        self.addChild(labelGame)
        
        // CREATE CHERRY
        let cherryBody = SKSpriteNode(imageNamed: "bulbasaur")
        cherryBody.position = CGPoint(
            x: CGFloat(randRange(20, upper: Int(self.frame.size.width - 20))),
            y: CGFloat(randRange(20, upper: Int(self.frame.size.height - 70)))
        )
        cherryBody.size = CGSize(width: cherrySize, height: cherrySize)
        cherryBody.name = cherryCategoryName
        cherryBody.physicsBody = SKPhysicsBody(circleOfRadius: cherrySize / 2)
        cherryBody.physicsBody?.isDynamic = false
        cherryBody.physicsBody?.restitution = 1
        cherryBody.physicsBody?.linearDamping = 0
        cherryBody.physicsBody?.friction = 0
        self.addChild(cherryBody)
        
        // CREATE HITLER
        let hitler = SKSpriteNode(imageNamed: "ash")
        hitler.name = hitlerCtegoryName
        hitler.size = CGSize(width: 130, height: 150)
        hitler.anchorPoint = CGPoint(x: 0, y: 0)
        hitler.position = CGPoint(x: self.frame.width, y: -150)
        self.addChild(hitler)
        
        border.physicsBody?.categoryBitMask = borderCategory
        ourBall.physicsBody?.categoryBitMask = ballCategory
        paddle.physicsBody?.categoryBitMask = paddleCategory
        cherryBody.physicsBody?.categoryBitMask = cherryCategory
        
        ourBall.physicsBody?.contactTestBitMask = borderCategory
        paddle.physicsBody?.contactTestBitMask = ballCategory
        cherryBody.physicsBody?.contactTestBitMask = ballCategory
    }
    
    override func didMove(to view: SKView) {
        
        eventMusicPlayer = try! AVAudioPlayer(contentsOf: toastyMusicUrl)
        eventMusicPlayer.numberOfLoops = 0
        eventMusicPlayer.prepareToPlay()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            
        } else {
            
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == borderCategory {
            
            print("You loose!")
            
            usedfDef.set(Int(score), forKey: "LastScore")
            usedfDef.set(Int(scoreCherry), forKey: "LastScoreCherry")
            usedfDef.synchronize()
            
            loose = true
            
            if gameMode == true {
                borderTouch -= 1
                self.removeChildren(in: [hearts[borderTouch]])
            }
            
            (self.childNode(withName: "LabelGame") as! SKLabelNode).text = "Score: \(score) Bulbasaur: \(scoreCherry)"
            
            if gameMode == true && borderTouch == 0 {
                
                self.view?.presentScene(GameOver(size: CGSize(width: self.frame.size.width, height: self.frame.size.height)))
            }
        }
        
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == paddleCategory {
            
            print("+1!")
            score += 1
            (self.childNode(withName: "LabelGame") as! SKLabelNode).text = "Score: \(score) Bulbasaur: \(scoreCherry)"
        }
        
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == cherryCategory {
            
            print("+Plus1!" + String(scoreCherry))
            scoreCherry += 1
            
            (self.childNode(withName: "LabelGame") as! SKLabelNode).text = "Score: \(score) Bulbasaur: \(scoreCherry)"
            self.childNode(withName: cherryCategoryName)?.zPosition = 20
            
            let action1 = SKAction.scale(by: 0.1, duration: 0.3)
            let action2 = SKAction.move(to: CGPoint(x: CGFloat(randRange(20, upper: Int(self.frame.size.width - 20))),
                                                    y: CGFloat(randRange(20, upper: Int(self.frame.size.height - 70)))),
                                        duration: 0.0001)
            
            let action3 = SKAction.scale(by: 10, duration: 0.3)
            self.childNode(withName: cherryCategoryName)?.run(SKAction.sequence([action1, action2, action3]))
            self.childNode(withName: cherryCategoryName)?.zPosition = 0
            hitlerAppear += 1
        }
        
        if hitlerAppear == hitlerAppearCount {
            
            eventMusicPlayer = try! AVAudioPlayer(contentsOf: toastyMusicUrl)
            eventMusicPlayer.numberOfLoops = 0
            eventMusicPlayer.prepareToPlay()
            eventMusicPlayer.play()
            
            let action1 = SKAction.move(to: CGPoint(x: self.frame.width - 100, y: 0), duration: 0.3)
            let action3 = SKAction.move(to: CGPoint(x: self.frame.width, y: -150), duration: 0.3)
            let action2 = SKAction.wait(forDuration: 0.5)
            let sequen = SKAction.sequence([action1, action2, action3])
            self.childNode(withName: hitlerCtegoryName)?.run(sequen)
            
            hitlerAppear = 0
        }
    }
    
    func randRange (_ lower: Int , upper: Int) -> Int {
     
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        self.childNode(withName: paddleCategoryName)?.position = touchLocation
        
        let dx = self.childNode(withName: paddleCategoryName)!.position.x - self.childNode(withName: ballCategoryName)!.position.x
        let dy = self.childNode(withName: paddleCategoryName)!.position.y - self.childNode(withName: ballCategoryName)!.position.y
        
        self.childNode(withName: paddleCategoryName)?.zRotation = -atan(dx/dy)
        
        if gameHaveBeenStarted == false {
            
            gameHaveBeenStarted = true
            self.childNode(withName: ballCategoryName)?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: speedVector))
        }
    }
    
    /*
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        if usedfDef.boolForKey("GameMode") == false {
            self.view?.presentScene(MainMenu(size: CGSizeMake(self.frame.size.width, self.frame.size.height)))
        }
    }
    */
}
