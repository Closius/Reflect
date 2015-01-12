//
//  MainMenu.swift
//  Reflect
//
//  Created by Admin on 12/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import SpriteKit
import AVFoundation

class MainMenu: SKScene {
    
    let userDef = NSUserDefaults.standardUserDefaults()
    
    var eventMusicPlayer = AVAudioPlayer()
    let toastyMusicUrl = NSBundle.mainBundle().URLForResource("toasty", withExtension: "mp3")
    
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        //CREATE WELCOME LABEL
        var labelWelcome = SKLabelNode(fontNamed: "unifont")
        labelWelcome.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 150)
        labelWelcome.fontSize = 30
        labelWelcome.fontColor = SKColor.greenColor()
        labelWelcome.text = "Weclome to Reflect!"
        labelWelcome.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        labelWelcome.name = "WelcomeGame"
        self.addChild(labelWelcome)
        
        //CREATE START GAME BUTTON
        var startGameButton = SKLabelNode(fontNamed: "unifont")
        startGameButton.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 200)
        startGameButton.fontSize = 25
        startGameButton.fontColor = SKColor.greenColor()
        startGameButton.color = SKColor.grayColor()
        startGameButton.calculateAccumulatedFrame()
 
        startGameButton.text = "START GAME"
        startGameButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        startGameButton.name = "StartGame"
        self.addChild(startGameButton)
        
  /*      // CREATE PADDLE
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
   */
     }
    

    
    override func didMoveToView(view: SKView) {
        eventMusicPlayer = AVAudioPlayer(contentsOfURL: toastyMusicUrl, error: nil)
        eventMusicPlayer.numberOfLoops = 0
        eventMusicPlayer.prepareToPlay()
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}