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
    
    var gameSpeed:Int = 2
    var surprizeFreequence: Int = 10
    var cherrySize: Int = 50
    var gameMode: Bool = true
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        if userDef.integerForKey("Speed") == 0 {
            userDef.setInteger(gameSpeed, forKey: "Speed")
            userDef.setInteger(surprizeFreequence, forKey: "SurprizeFreequence")
            userDef.setInteger(cherrySize, forKey: "CherrySize")
            userDef.setBool(gameMode, forKey: "GameMode")
        } else {
            gameSpeed = userDef.integerForKey("Speed")
            surprizeFreequence = userDef.integerForKey("SurprizeFreequence")
            cherrySize = userDef.integerForKey("CherrySize")
            gameMode = userDef.boolForKey("GameMode")
        }

        //CREATE SETTINGS LABEL
        var gameOverLabel = SKLabelNode(fontNamed: "unifont")
        gameOverLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 100)
        gameOverLabel.fontSize = 30
        gameOverLabel.fontColor = SKColor.greenColor()
        gameOverLabel.text = "Settings"
        gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(gameOverLabel)
        
        //Create settings fields(buttons and labels)
        createSettingsButton(name: "Speed", text: "Speed", h_position: self.frame.size.height - 200, value: &gameSpeed)
        createSettingsButton(name: "SurprizeFreequence", text: "Surprize", h_position: self.frame.size.height - 300, value: &surprizeFreequence)
        createSettingsButton(name: "CherrySize", text: "Target Size", h_position: self.frame.size.height - 400, value: &cherrySize)
        
        //CREATE Back to main menu button
        var w:CGFloat = 60
        var h:CGFloat = 25
        var backButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        backButton.name = "BackButton"
        backButton.position = CGPointMake(w/2 + 10, self.frame.size.height - h/2 - 10)
        backButton.text = "Back"
        backButton.fontSize = 20
        backButton.fontName = "unifont"
        backButton.fontColor = UIColor.blackColor()
        backButton.action = { [weak self] in
            if let strongSelf = self {
                let userDef = NSUserDefaults.standardUserDefaults()
                userDef.setBool(strongSelf.gameMode, forKey: "GameMode")
                strongSelf.view?.presentScene(MainMenu(size: strongSelf.frame.size), transition: SKTransition.fadeWithDuration(0.3))
            } }
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
        testButton.fontColor = UIColor.blackColor()
        testButton.action = { [weak self] in
            if let strongSelf = self {
                if strongSelf.gameMode == true {
                    (testButton.childNodeWithName( testButton.name! + "_label") as SKLabelNode).text = "Test Mode"
                    strongSelf.gameMode = false
                } else {
                    (testButton.childNodeWithName( testButton.name! + "_label") as SKLabelNode).text = "Game Mode"
                    strongSelf.gameMode = true
                }
            } }
        testButton.createLabel()
        self.addChild(testButton)
    }
    
    func createSettingsButton( #name: String, text: String, h_position: CGFloat, inout value: Int) {
                                                                              // inout - parameter in function by reference
        var fontName = "unifont"
        var font_value_Size:CGFloat = 30
        var font_Value:UIFont = UIFont(name: "unifont", size: font_value_Size)!
       
        let plus_CategoryName                 = name + "_Plus_CategoryName"
        let minus_CategoryName                = name + "_Minus_CategoryName"
        let value_CategoryName                = name + "_Value_CategoryName"
        
        //CREATE VALUE
        var set_ValueLabel = SKLabelNode(fontNamed: fontName)
        set_ValueLabel.position = CGPointMake(self.frame.size.width / 2, h_position - font_Value.capHeight/2)
        set_ValueLabel.fontSize = font_value_Size
        set_ValueLabel.fontColor = SKColor.greenColor()
        set_ValueLabel.text = String(value)
        set_ValueLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        set_ValueLabel.name = value_CategoryName
        self.addChild(set_ValueLabel)

        //PLUS BUTTON
        var w:CGFloat = 40
        var h:CGFloat = 40
        var set_PlusButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        set_PlusButton.name = plus_CategoryName
        set_PlusButton.position = CGPointMake(self.frame.size.width - (self.frame.size.width / 5), h_position)
        set_PlusButton.text = "+"
        set_PlusButton.fontSize = 30
        set_PlusButton.fontName = "unifont"
        set_PlusButton.fontColor = UIColor.blackColor()
        set_PlusButton.action = {
                                     ++value
                                     set_ValueLabel.text = String(value)
                                     let userDef = NSUserDefaults.standardUserDefaults()
                                     userDef.setInteger(value, forKey: name)
                                     userDef.synchronize()
                                }
        set_PlusButton.createLabel()
        self.addChild(set_PlusButton)
        
        //MINUS BUTTON
        var set_MinusButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        set_MinusButton.name = minus_CategoryName
        set_MinusButton.position = CGPointMake(self.frame.size.width / 5, h_position)
        set_MinusButton.text = "-"
        set_MinusButton.fontSize = 30
        set_MinusButton.fontName = "unifont"
        set_MinusButton.fontColor = UIColor.blackColor()
        set_MinusButton.action = {
                                     --value
                                     if value < 1 { value = 1 }
                                     set_ValueLabel.text = String(value)
                                     let userDef = NSUserDefaults.standardUserDefaults()
                                     userDef.setInteger(value, forKey: name)
                                     userDef.synchronize()
                                 }
        set_MinusButton.createLabel()
        self.addChild(set_MinusButton)
        
        //CREATE LABEL
        var setLabel = SKLabelNode(fontNamed: "unifont")
        setLabel.position = CGPointMake(self.frame.size.width / 2, h_position + h/2)
        setLabel.fontSize = 20
        setLabel.fontColor = SKColor.greenColor()
        setLabel.text = text
        setLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(setLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
