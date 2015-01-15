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
    
    let usedfDef = NSUserDefaults.standardUserDefaults()
    
    var eventMusicPlayer = AVAudioPlayer()
    let toastyMusicUrl = NSBundle.mainBundle().URLForResource("toasty", withExtension: "mp3")
    
    let ballCategoryName = "Ball"
    let radiusBall:CGFloat = 10
    let paddleCategoryName = "Paddle"
    let rectPaddle:CGRect = CGRectMake(-100/2, -20/2, 100, 20)
    let borderCategoryName = "Border"
    let cherryCategoryName = "Cherry"
    let hitlerCtegoryName = "Hitler"
    let cherrySize:CGFloat = 50
    
    var speedVector:CGFloat = 2
    
    var gameHaveBeenStarted = false
    
    var score = 0
    var scoreCherry = 0
    var hitlerAppear = 0
    var hitlerAppearCount = 10
    var loose = false
    
    let ballCategory:UInt32 = 0x1 << 0
    let borderCategory:UInt32 = 0x1 << 1
    let paddleCategory:UInt32 = 0x1 << 2
    let cherryCategory:UInt32 = 0x1 << 3
    
    let gameMode = true
    
    override init(size: CGSize){
        super.init(size: size)
     
        if usedfDef.integerForKey("Speed") == 0 {
            usedfDef.setInteger(Int(speedVector), forKey: "Speed")
            usedfDef.setInteger(hitlerAppearCount, forKey: "SurprizeFreequence")
            usedfDef.setInteger(Int(cherrySize), forKey: "CherrySize")
            usedfDef.setBool(gameMode, forKey: "GameMode")
        } else {
            speedVector = CGFloat(usedfDef.integerForKey("Speed"))
            hitlerAppearCount = usedfDef.integerForKey("SurprizeFreequence")
            cherrySize = CGFloat(usedfDef.integerForKey("CherrySize"))
            gameMode = usedfDef.boolForKey("GameMode")
        }
        
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = SKColor.blackColor()
        self.physicsWorld.gravity = CGVector(dx: 0,dy: 0)
        
        // CREATE BALL
        let ourBall = SKShapeNode(circleOfRadius: radiusBall)
        ourBall.name = ballCategoryName
        ourBall.fillColor = UIColor.greenColor()
        ourBall.strokeColor = UIColor.greenColor()
        ourBall.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        ourBall.physicsBody = SKPhysicsBody(circleOfRadius: radiusBall)
        ourBall.physicsBody?.dynamic = true
        ourBall.physicsBody?.restitution = 1
        ourBall.physicsBody?.linearDamping = 0
        ourBall.physicsBody?.friction = 0
        self.addChild(ourBall)
        
        // CREATE PADDLE
        let paddle = SKShapeNode(rect: rectPaddle)
        paddle.name = paddleCategoryName
        paddle.fillColor = UIColor.greenColor()
        paddle.strokeColor = UIColor.greenColor()
        paddle.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 6)
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: paddle.frame.size)
        paddle.physicsBody?.dynamic = false
        paddle.physicsBody?.restitution = 1
        paddle.physicsBody?.linearDamping = 0
        paddle.physicsBody?.friction = 0
        self.addChild(paddle)
        
        //CREATE BORDER
        let areaWorld = CGRectMake(self.frame.origin.x + 1, self.frame.origin.y + 1, self.frame.size.width - 2, self.frame.size.height - 50)
        let border = SKShapeNode(rect: areaWorld)
        border.name = borderCategoryName
        border.strokeColor = UIColor.greenColor()
        border.position = CGPointMake(self.frame.origin.x, self.frame.origin.x)
        border.physicsBody = SKPhysicsBody(edgeLoopFromRect: areaWorld)
        border.physicsBody?.restitution = 1
        border.physicsBody?.linearDamping = 0
        border.physicsBody?.friction = 0
        self.addChild(border)
        
        //CREATE LABEL
        var labelGame = SKLabelNode(fontNamed: "unifont")
        labelGame.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 35)
        labelGame.fontSize = 20
        labelGame.fontColor = SKColor.greenColor()
        labelGame.text = "Score: 0 Bulbasaur: 0"
        labelGame.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        labelGame.name = "LabelGame"
        self.addChild(labelGame)
        
        //CREATE CHERRY
        var cherryBody = SKSpriteNode(imageNamed: "bulbasaur")
        cherryBody.position = CGPointMake(
            CGFloat(randRange(20, upper: Int(self.frame.size.width - 20))),
            CGFloat(randRange(20, upper: Int(self.frame.size.height - 70)))
        )
        cherryBody.size = CGSizeMake(cherrySize, cherrySize)
        cherryBody.name = cherryCategoryName
        cherryBody.physicsBody = SKPhysicsBody(circleOfRadius: cherrySize / 2)
        cherryBody.physicsBody?.dynamic = false
        cherryBody.physicsBody?.restitution = 1
        cherryBody.physicsBody?.linearDamping = 0
        cherryBody.physicsBody?.friction = 0
        self.addChild(cherryBody)
        
        //CREATE HITLER
        var hitler = SKSpriteNode(imageNamed: "ash")
        hitler.name = hitlerCtegoryName
        hitler.size = CGSizeMake(130, 150)
        hitler.anchorPoint = CGPointMake(0, 0)
        hitler.position = CGPointMake(self.frame.width, -150)
        self.addChild(hitler)
        
        border.physicsBody?.categoryBitMask = borderCategory
        ourBall.physicsBody?.categoryBitMask = ballCategory
        paddle.physicsBody?.categoryBitMask = paddleCategory
        cherryBody.physicsBody?.categoryBitMask = cherryCategory
        
        ourBall.physicsBody?.contactTestBitMask = borderCategory
        paddle.physicsBody?.contactTestBitMask = ballCategory
        cherryBody.physicsBody?.contactTestBitMask = ballCategory
    }
    
    override func didMoveToView(view: SKView) {
        eventMusicPlayer = AVAudioPlayer(contentsOfURL: toastyMusicUrl, error: nil)
        eventMusicPlayer.numberOfLoops = 0
        eventMusicPlayer.prepareToPlay()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
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
            println("You loose!")
            loose = true
            
            usedfDef.setInteger(Int(score), forKey: "LastScore")
            usedfDef.setInteger(Int(scoreCherry), forKey: "LastScoreCherry")
            usedfDef.synchronize()
            
            score = 0
            (self.childNodeWithName("LabelGame") as SKLabelNode).text = "Score: " + String(score) + " Bulbasaur: " + String(scoreCherry)
            
            if gameMode == true {
                self.view?.presentScene(GameOver(size: CGSizeMake(self.frame.size.width, self.frame.size.height)))
            }
        }
        
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == paddleCategory {
            println("+1!")
            score += 1
            (self.childNodeWithName("LabelGame") as SKLabelNode).text = "Score: " + String(score) + " Bulbasaur: " + String(scoreCherry)
        }
        
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == cherryCategory {
            println("+Plus1!" + String(scoreCherry))
            scoreCherry += 1
            (self.childNodeWithName("LabelGame") as SKLabelNode).text = "Score: " + String(score) + " Bulbasaur: " + String(scoreCherry)
            (self.childNodeWithName(cherryCategoryName) as SKSpriteNode).zPosition = 20
            let action = SKAction.moveTo(CGPointMake(
                CGFloat(randRange(20, upper: Int(self.frame.size.width - 20))),
                CGFloat(randRange(20, upper: Int(self.frame.size.height - 70)))
                ), duration: 0.0001)
            (self.childNodeWithName(cherryCategoryName) as SKSpriteNode).runAction(action)
            (self.childNodeWithName(cherryCategoryName) as SKSpriteNode).zPosition = 0
            hitlerAppear += 1
            
        }
        
        if hitlerAppear == hitlerAppearCount {
            
            eventMusicPlayer = AVAudioPlayer(contentsOfURL: toastyMusicUrl, error: nil)
            eventMusicPlayer.numberOfLoops = 0
            eventMusicPlayer.prepareToPlay()
            eventMusicPlayer.play()
            
            let action1 = SKAction.moveTo(CGPointMake(self.frame.width - 100, 0), duration: 0.3)
            let action3 = SKAction.moveTo(CGPointMake(self.frame.width, -150), duration: 0.3)
            let action2 = SKAction.waitForDuration(0.5)
            let sequen = SKAction.sequence([action1, action2, action3])
            (self.childNodeWithName(hitlerCtegoryName) as SKSpriteNode).runAction(sequen)
            
            hitlerAppear = 0
        }
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        
        self.childNodeWithName(paddleCategoryName)?.position = touchLocation
        
        var dx = (self.childNodeWithName(paddleCategoryName)?.position.x)! - (self.childNodeWithName(ballCategoryName)?.position.x)!
        var dy = (self.childNodeWithName(paddleCategoryName)?.position.y)! - (self.childNodeWithName(ballCategoryName)?.position.y)!
        self.childNodeWithName(paddleCategoryName)?.zRotation = -atan(dx/dy)
        
        
        if gameHaveBeenStarted == false {
            gameHaveBeenStarted = true
            self.childNodeWithName(ballCategoryName)?.physicsBody?.applyImpulse(CGVectorMake(0, speedVector))
        }
    }
    
//    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        
//        if usedfDef.boolForKey("GameMode") == false {
//            self.view?.presentScene(MainMenu(size: CGSizeMake(self.frame.size.width, self.frame.size.height)))
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}