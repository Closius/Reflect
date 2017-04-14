//
//  GameOver.swift
//  Reflect
//
//  Created by Admin on 13/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameOver: SKScene {
    
    let userDef = UserDefaults.standard
    
    var eventMusicPlayer = AVAudioPlayer()
    let toastyMusicUrl = Bundle.main.url(forResource: "forgoth", withExtension: "mp3")!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        
        // CREATE WELCOME LABEL
        let gameOverLabel = SKLabelNode(fontNamed: "unifont")
        gameOverLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 130)
        gameOverLabel.fontSize = 30
        gameOverLabel.fontColor = SKColor.green
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(gameOverLabel)
        
        // CREATE score LABEL
        let scoreLabel = SKLabelNode(fontNamed: "unifont")
        scoreLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 200)
        scoreLabel.fontSize = 22
        scoreLabel.fontColor = SKColor.green
        scoreLabel.text = "Your score: " + String(userDef.integer(forKey: "LastScore"))
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(scoreLabel)
        
        // CREATE cherry LABEL
        let cherryScoreLabel = SKLabelNode(fontNamed: "unifont")
        cherryScoreLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 225)
        cherryScoreLabel.fontSize = 22
        cherryScoreLabel.fontColor = SKColor.green
        cherryScoreLabel.text = "Bulbasaurus catched: " + String(userDef.integer(forKey: "LastScoreCherry"))
        cherryScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(cherryScoreLabel)
        
        // CREATE Immortal
        let aboutImage = SKSpriteNode(imageNamed: "immortal")
        aboutImage.size = CGSize(width: self.frame.width, height: self.frame.width)
        aboutImage.anchorPoint = CGPoint(x: 0, y: 0)
        aboutImage.position = CGPoint(x: 0,y: 0)//self.frame.width / 2, self.frame.height / 2)
        self.addChild(aboutImage)
        
        let act = SKAction.move(to: CGPoint(x: aboutImage.position.x + 2, y: aboutImage.position.y + 2), duration: 0.05)
        let act2 = SKAction.move(to: CGPoint(x: aboutImage.position.x - 4, y: aboutImage.position.y), duration: 0.05)
        let act3 = SKAction.move(to: CGPoint(x: aboutImage.position.x + 2, y: aboutImage.position.y - 2), duration: 0.05)
        
        
        aboutImage.run(SKAction.repeatForever(SKAction.sequence([act, act2, act3])))
    }
    
    override func didMove(to view: SKView) {
        
        eventMusicPlayer = try! AVAudioPlayer(contentsOf: toastyMusicUrl)
        eventMusicPlayer.numberOfLoops = -1
        eventMusicPlayer.prepareToPlay()
        eventMusicPlayer.play()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
         self.view?.presentScene(MainMenu(size: CGSize(width: self.frame.width, height: self.frame.height)), transition: SKTransition.fade(withDuration: 0.3))
    }
}
