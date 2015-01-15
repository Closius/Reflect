//
//  GameOver.swift
//  Reflect
//
//  Created by Admin on 13/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import UIKit
import SpriteKit

class GameOver: SKScene {
    
    let userDef = NSUserDefaults.standardUserDefaults()
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        //CREATE WELCOME LABEL
        var gameOverLabel = SKLabelNode(fontNamed: "unifont")
        gameOverLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 130)
        gameOverLabel.fontSize = 30
        gameOverLabel.fontColor = SKColor.greenColor()
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(gameOverLabel)
        
        //CREATE score LABEL
        var scoreLabel = SKLabelNode(fontNamed: "unifont")
        scoreLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 200)
        scoreLabel.fontSize = 22
        scoreLabel.fontColor = SKColor.greenColor()
        scoreLabel.text = "Your score: " + String(userDef.integerForKey("LastScore"))
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(scoreLabel)
        
        //CREATE cherry LABEL
        var cherryScoreLabel = SKLabelNode(fontNamed: "unifont")
        cherryScoreLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 225)
        cherryScoreLabel.fontSize = 22
        cherryScoreLabel.fontColor = SKColor.greenColor()
        cherryScoreLabel.text = "Bulbasaurus catched: " + String(userDef.integerForKey("LastScoreCherry"))
        cherryScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(cherryScoreLabel)
    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
         self.view?.presentScene(MainMenu(size: CGSizeMake(self.frame.width, self.frame.height)))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
}
