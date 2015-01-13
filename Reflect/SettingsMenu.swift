//
//  SettingsMenu.swift
//  Reflect
//
//  Created by Admin on 13/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import UIKit
import SpriteKit

class SettingsMenu: SKScene {
   
    let userDef = NSUserDefaults.standardUserDefaults()
    
    // Names of buttons
    // Indexes: (Plus, Minus, Value)
    let speed_array_CategoryName:NSArray?
    let surprizeFreequence_array_CategoryName:NSArray?
    let cherrySize_array_CategoryName:NSArray?
    
    var gameSpeed:Int = 2
    var surprizeFreequence: Int = 10
    var cherrySize: Int = 50
    var gameMode: Bool = true
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        if userDef.integerForKey("GameSpeed") != 0 {
            gameSpeed = userDef.integerForKey("GameSpeed")
            surprizeFreequence = userDef.integerForKey("SurprizeFreequence")
            cherrySize = userDef.integerForKey("CherrySize")
            gameMode = userDef.boolForKey("GameMode")
        }
        
        //CREATE WELCOME LABEL
        var gameOverLabel = SKLabelNode(fontNamed: "unifont")
        gameOverLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 100)
        gameOverLabel.fontSize = 30
        gameOverLabel.fontColor = SKColor.greenColor()
        gameOverLabel.text = "Settings"
        gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(gameOverLabel)
        
        //Create settings fields(buttons and labels)
        speed_array_CategoryName = createSettingsButton(name: "speed", text: "Speed", h_position: self.frame.size.height - 200, value: gameSpeed)
        surprizeFreequence_array_CategoryName = createSettingsButton(name: "surprizeFreequence", text: "Surprize", h_position: self.frame.size.height - 300, value: surprizeFreequence)
        cherrySize_array_CategoryName = createSettingsButton(name: "cherrySize", text: "Target Size", h_position: self.frame.size.height - 400, value: cherrySize)
        
        //CREATE Back to main menu button
        var w:CGFloat = 60
        var h:CGFloat = 25
        var backButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        backButton.name = "BackButton"
        backButton.position = CGPointMake(w/2 + 10, self.frame.size.height - h/2 - 10)
        backButton.text = "Back"
        backButton.fontSize = 20
        backButton.fontName = "unifont"
        backButton.fillColor = UIColor.greenColor()
        backButton.fontColor = UIColor.blackColor()
        backButton.createLabel()
        self.addChild(backButton)
        
        //CREATE test button
        w = 100
        h = 30
        var testButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        testButton.name = "TestButton"
        testButton.position = CGPointMake(self.frame.size.width / 2, 80)
        gameMode == true ? (testButton.text = "Game Mode") : (testButton.text = "Test Mode")
        testButton.fontSize = 20
        testButton.fontName = "unifont"
        testButton.fillColor = UIColor.greenColor()
        testButton.fontColor = UIColor.blackColor()
        testButton.createLabel()
        self.addChild(testButton)
        
        
        
    }
    
    func createSettingsButton( #name: String, text: String, h_position: CGFloat, value: Int) -> NSArray {
        
        var fontName = "unifont"
        var font_value_Size:CGFloat = 30
        var font_Value:UIFont = UIFont(name: "unifont", size: font_value_Size)!
        
        let plus_CategoryName                 = name + "_Plus_CategoryName"
        let minus_CategoryName                = name + "_Minus_CategoryName"
        let value_CategoryName                = name + "_Value_CategoryName"
        
        //PLUS BUTTON
        var w:CGFloat = 40
        var h:CGFloat = 40
        var speed_PlusButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        speed_PlusButton.name = plus_CategoryName
        speed_PlusButton.position = CGPointMake(self.frame.size.width - (self.frame.size.width / 5), h_position)
        speed_PlusButton.text = "+"
        speed_PlusButton.fontSize = 30
        speed_PlusButton.fontName = "unifont"
        speed_PlusButton.fillColor = UIColor.greenColor()
        speed_PlusButton.fontColor = UIColor.blackColor()
        speed_PlusButton.createLabel()
        self.addChild(speed_PlusButton)
        
        //CREATE LABEL
        var speedLabel = SKLabelNode(fontNamed: "unifont")
        speedLabel.position = CGPointMake(self.frame.size.width / 2, h_position + h/2)
        speedLabel.fontSize = 20
        speedLabel.fontColor = SKColor.greenColor()
        speedLabel.text = text
        speedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(speedLabel)
        
        //CREATE VALUE
        var speed_ValueLabel = SKLabelNode(fontNamed: fontName)
        speed_ValueLabel.position = CGPointMake(self.frame.size.width / 2, h_position - font_Value.capHeight/2)
        speed_ValueLabel.fontSize = font_value_Size
        speed_ValueLabel.fontColor = SKColor.greenColor()
        speed_ValueLabel.text = String(value)
        speed_ValueLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        speed_ValueLabel.name = value_CategoryName
        self.addChild(speed_ValueLabel)
        
        //MINUS BUTTON
        var speed_MinusButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        speed_MinusButton.name = minus_CategoryName
        speed_MinusButton.position = CGPointMake(self.frame.size.width / 5, h_position)
        speed_MinusButton.text = "-"
        speed_MinusButton.fontSize = 30
        speed_MinusButton.fontName = "unifont"
        speed_MinusButton.fillColor = UIColor.greenColor()
        speed_MinusButton.fontColor = UIColor.blackColor()
        speed_MinusButton.createLabel()
        self.addChild(speed_MinusButton)
        
        return [plus_CategoryName, minus_CategoryName, value_CategoryName]

    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var touch: UITouch = touches.allObjects[0] as UITouch
        var location: CGPoint = touch.locationInNode(self)
    // Back to main menu
        if self.childNodeWithName("BackButton")?.containsPoint(location) == true {
            self.view?.presentScene(MainMenu(size: CGSizeMake(self.frame.width, self.frame.height)))
            
            userDef.setInteger(gameSpeed, forKey: "GameSpeed")
            userDef.setInteger(surprizeFreequence, forKey: "SurprizeFreequence")
            userDef.setInteger(cherrySize, forKey: "CherrySize")
            userDef.setBool(gameMode, forKey: "GameMode")
            userDef.synchronize()
        }
        
    // Test/Game mode button
        if self.childNodeWithName("TestButton")?.containsPoint(location) == true {
            if gameMode == true {
                (self.childNodeWithName("TestButton")! as SKLabelNode).text = "Game Mode"
                println(gameMode)
                gameMode = false
            } else {
                (self.childNodeWithName("TestButton")! as SKLabelNode).text = "Test Mode"
                println(gameMode)
                gameMode = true
            }
        }
        
    // Plus and Minus and values
    //-------------------------------------
        if self.childNodeWithName(speed_array_CategoryName!.objectAtIndex(0) as NSString)!.containsPoint(location) == true {
            ++gameSpeed
            (self.childNodeWithName(speed_array_CategoryName!.objectAtIndex(2) as NSString)! as SKLabelNode).text = String(gameSpeed)
        }
        if self.childNodeWithName(speed_array_CategoryName!.objectAtIndex(1) as NSString)!.containsPoint(location) == true {
            --gameSpeed
            if gameSpeed <= 0 { gameSpeed = 1 }
            (self.childNodeWithName(speed_array_CategoryName!.objectAtIndex(2) as NSString)! as SKLabelNode).text = String(gameSpeed)
        }
    //-------------------------------------
        if self.childNodeWithName(surprizeFreequence_array_CategoryName!.objectAtIndex(0) as NSString)!.containsPoint(location) == true {
            ++surprizeFreequence
            (self.childNodeWithName(surprizeFreequence_array_CategoryName!.objectAtIndex(2) as NSString)! as SKLabelNode).text = String(surprizeFreequence)
        }
        if self.childNodeWithName(surprizeFreequence_array_CategoryName!.objectAtIndex(1) as NSString)!.containsPoint(location) == true {
            --surprizeFreequence
            if surprizeFreequence <= 1 { surprizeFreequence = 1 }
            (self.childNodeWithName(surprizeFreequence_array_CategoryName!.objectAtIndex(2) as NSString)! as SKLabelNode).text = String(surprizeFreequence)
        }
    //-------------------------------------
        if self.childNodeWithName(cherrySize_array_CategoryName!.objectAtIndex(0) as NSString)!.containsPoint(location) == true {
            ++cherrySize
            (self.childNodeWithName(cherrySize_array_CategoryName!.objectAtIndex(2) as NSString)! as SKLabelNode).text = String(cherrySize)
        }
        if self.childNodeWithName(cherrySize_array_CategoryName!.objectAtIndex(1) as NSString)!.containsPoint(location) == true {
            --cherrySize
            if cherrySize <= 0 { cherrySize = 0 }
            (self.childNodeWithName(cherrySize_array_CategoryName!.objectAtIndex(2) as NSString)! as SKLabelNode).text = String(cherrySize)
        }
    //-------------------------------------

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
