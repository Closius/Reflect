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
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        
        
        
        //CREATE HITLER
        var aboutImage = SKSpriteNode(imageNamed: "forAbout")
        aboutImage.size = CGSizeMake(200, 200)
        //  aboutImage.anchorPoint = CGPointMake(0, 0)
        aboutImage.position = CGPointMake(self.frame.width / 2, self.frame.height / 2)
        self.addChild(aboutImage)

        
        //CREATE Reflect LABEL
        var aboutLabel1 = SKLabelNode(fontNamed: "unifont")
        aboutLabel1.position = CGPointMake(self.frame.size.width / 2, 100)
        aboutLabel1.fontSize = 30
        aboutLabel1.fontColor = SKColor.greenColor()
        aboutLabel1.text = "Reflect"
        aboutLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(aboutLabel1)
        
        //CREATE v LABEL
        var aboutLabel2 = SKLabelNode(fontNamed: "unifont")
        aboutLabel2.position = CGPointMake(self.frame.size.width / 2, 80)
        aboutLabel2.fontSize = 20
        aboutLabel2.fontColor = SKColor.greenColor()
        aboutLabel2.text = "v 1.0"
        aboutLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(aboutLabel2)
        
        //CREATE developed by LABEL
        var aboutLabel3 = SKLabelNode(fontNamed: "unifont")
        aboutLabel3.position = CGPointMake(self.frame.size.width / 2, 60)
        aboutLabel3.fontSize = 20
        aboutLabel3.fontColor = SKColor.greenColor()
        aboutLabel3.text = "developed by Closius"
        aboutLabel3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(aboutLabel3)
        
        //CREATE mail LABEL
        var aboutLabel4 = SKLabelNode(fontNamed: "unifont")
        aboutLabel4.position = CGPointMake(self.frame.size.width / 2, 40)
        aboutLabel4.fontSize = 20
        aboutLabel4.fontColor = SKColor.greenColor()
        aboutLabel4.text = "ant.kavalerov@gmail.com"
        aboutLabel4.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(aboutLabel4)


    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view?.presentScene(MainMenu(size: CGSizeMake(self.frame.width, self.frame.height)))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
}
