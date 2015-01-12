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
        
        self.backgroundColor = SKColor.grayColor()
        self.name = "MainScene"
        
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
        
        var w:CGFloat = 100
        var h:CGFloat = 40
        var startGameButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        startGameButton.name = "Button1"
        startGameButton.position = CGPointMake(120, 100)
        startGameButton.text = "MyButton"
        startGameButton.fontSize = 20
        startGameButton.fontName = "unifont"
        startGameButton.fillColor = UIColor.magentaColor()
        startGameButton.fontColor = UIColor.blackColor()
        startGameButton.createLabel()
        
        startGameButton.physicsBody = SKPhysicsBody(rectangleOfSize: startGameButton.frame.size)
        startGameButton.physicsBody?.dynamic = false
        
        self.addChild(startGameButton)
 
    }
    
    
 


    
    override func didMoveToView(view: SKView) {
        eventMusicPlayer = AVAudioPlayer(contentsOfURL: toastyMusicUrl, error: nil)
        eventMusicPlayer.numberOfLoops = 0
        eventMusicPlayer.prepareToPlay()
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}