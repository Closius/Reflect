//
//  About.swift
//  Reflect
//
//  Created by Admin on 15/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import UIKit
import SpriteKit

class About: SKScene {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        
        // CREATE HITLER
        let aboutImage = SKSpriteNode(imageNamed: "forAbout")
        aboutImage.size = CGSize(width: 200, height: 200)
        // aboutImage.anchorPoint = CGPointMake(0, 0)
        aboutImage.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.addChild(aboutImage)

        
        // CREATE Reflect LABEL
        let aboutLabel1 = SKLabelNode(fontNamed: "unifont")
        aboutLabel1.position = CGPoint(x: self.frame.size.width / 2, y: 100)
        aboutLabel1.fontSize = 30
        aboutLabel1.fontColor = SKColor.green
        aboutLabel1.text = "Reflect"
        aboutLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(aboutLabel1)
        
        // CREATE v LABEL
        let aboutLabel2 = SKLabelNode(fontNamed: "unifont")
        aboutLabel2.position = CGPoint(x: self.frame.size.width / 2, y: 80)
        aboutLabel2.fontSize = 20
        aboutLabel2.fontColor = SKColor.green
        aboutLabel2.text = "v 1.0"
        aboutLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(aboutLabel2)
        
        // CREATE developed by LABEL
        let aboutLabel3 = SKLabelNode(fontNamed: "unifont")
        aboutLabel3.position = CGPoint(x: self.frame.size.width / 2, y: 60)
        aboutLabel3.fontSize = 20
        aboutLabel3.fontColor = SKColor.green
        aboutLabel3.text = "developed by Closius"
        aboutLabel3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(aboutLabel3)
        
        // CREATE mail LABEL
        let aboutLabel4 = SKLabelNode(fontNamed: "unifont")
        aboutLabel4.position = CGPoint(x: self.frame.size.width / 2, y: 40)
        aboutLabel4.fontSize = 20
        aboutLabel4.fontColor = SKColor.green
        aboutLabel4.text = "ant.kavalerov@gmail.com"
        aboutLabel4.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(aboutLabel4)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view?.presentScene(MainMenu(size: CGSize(width: self.frame.width, height: self.frame.height)), transition: SKTransition.fade(withDuration: 0.3))
    }
}
