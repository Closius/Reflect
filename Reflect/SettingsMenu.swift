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
   
    let userDef = UserDefaults.standard
    
    var gameSpeed = 2
    var surprizeFreequence = 10
    var cherrySize = 50
    var gameMode = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        
        if userDef.integer(forKey: "Speed") == 0 {
            
            userDef.set(gameSpeed, forKey: "Speed")
            userDef.set(surprizeFreequence, forKey: "SurprizeFreequence")
            userDef.set(cherrySize, forKey: "CherrySize")
            userDef.set(gameMode, forKey: "GameMode")
            
        } else {
            
            gameSpeed = userDef.integer(forKey: "Speed")
            surprizeFreequence = userDef.integer(forKey: "SurprizeFreequence")
            cherrySize = userDef.integer(forKey: "CherrySize")
            gameMode = userDef.bool(forKey: "GameMode")
        }

        // CREATE SETTINGS LABEL
        let gameOverLabel = SKLabelNode(fontNamed: "unifont")
        gameOverLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 100)
        gameOverLabel.fontSize = 30
        gameOverLabel.fontColor = SKColor.green
        gameOverLabel.text = "Settings"
        gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(gameOverLabel)
        
        // Create settings fields(buttons and labels)
        createSettingsButton(name: "Speed", text: "Speed", h_position: self.frame.size.height - 200, value: gameSpeed)
        createSettingsButton(name: "SurprizeFreequence", text: "Surprize", h_position: self.frame.size.height - 300, value: surprizeFreequence)
        createSettingsButton(name: "CherrySize", text: "Target Size", h_position: self.frame.size.height - 400, value: cherrySize)
        
        // CREATE Back to main menu button
        var w: CGFloat = 60
        var h: CGFloat = 25
        
        let backButton = AKButtonFromLabelNode(rect: CGRect(x: -w/2, y: -h/2, width: w, height: h))
        backButton.name = "BackButton"
        backButton.position = CGPoint(x: w/2 + 10, y: self.frame.size.height - h/2 - 10)
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
        
        // CREATE test button
        w = 100
        h = 30
        
        let testButton = AKButtonFromLabelNode(rect: CGRect(x: -w/2, y: -h/2, width: w, height: h))
        testButton.name = "TestButton"
        testButton.position = CGPoint(x: self.frame.size.width / 2, y: 80)
        gameMode == true ? (testButton.text = "Game Mode") : (testButton.text = "Test Mode")
        
        testButton.fontSize = 20
        testButton.fontName = "unifont"
        testButton.fontColor = UIColor.black
        
        testButton.action = { [weak self] in
           
            if let strongSelf = self {
            
                if strongSelf.gameMode == true {
                    
                    (testButton.childNode( withName: testButton.name! + "_label") as! SKLabelNode).text = "Test Mode"
                    strongSelf.gameMode = false
                    
                } else {
                    
                    (testButton.childNode( withName: testButton.name! + "_label") as! SKLabelNode).text = "Game Mode"
                    strongSelf.gameMode = true
                }
            }
        }
        
        testButton.createLabel()
        self.addChild(testButton)
    }
    
    func createSettingsButton(name: String, text: String, h_position: CGFloat, value: Int) {
        
        var value = value
        
        let fontName = "unifont"
        let font_value_Size: CGFloat = 30
        let font_Value = UIFont(name: fontName, size: font_value_Size)!
       
        let plus_CategoryName                 = name + "_Plus_CategoryName"
        let minus_CategoryName                = name + "_Minus_CategoryName"
        let value_CategoryName                = name + "_Value_CategoryName"
        
        // CREATE VALUE
        let set_ValueLabel = SKLabelNode(fontNamed: fontName)
        set_ValueLabel.position = CGPoint(x: self.frame.size.width / 2, y: h_position - font_Value.capHeight/2)
        set_ValueLabel.fontSize = font_value_Size
        set_ValueLabel.fontColor = SKColor.green
        set_ValueLabel.text = String(value)
        set_ValueLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        set_ValueLabel.name = value_CategoryName
        self.addChild(set_ValueLabel)

        // PLUS BUTTON
        let w: CGFloat = 40
        let h: CGFloat = 40
        let set_PlusButton = AKButtonFromLabelNode(rect: CGRect(x: -w/2, y: -h/2, width: w, height: h))
        set_PlusButton.name = plus_CategoryName
        set_PlusButton.position = CGPoint(x: self.frame.size.width - (self.frame.size.width / 5), y: h_position)
        set_PlusButton.text = "+"
        set_PlusButton.fontSize = 30
        set_PlusButton.fontName = "unifont"
        set_PlusButton.fontColor = UIColor.black
        
        set_PlusButton.action = {
                                     value += 1
                                     set_ValueLabel.text = String(value)
                                     let userDef = UserDefaults.standard
                                     userDef.set(value, forKey: name)
                                     userDef.synchronize()
                                }
        
        set_PlusButton.createLabel()
        self.addChild(set_PlusButton)
        
        // MINUS BUTTON
        let set_MinusButton = AKButtonFromLabelNode(rect: CGRect(x: -w/2, y: -h/2, width: w, height: h))
        set_MinusButton.name = minus_CategoryName
        set_MinusButton.position = CGPoint(x: self.frame.size.width / 5, y: h_position)
        set_MinusButton.text = "-"
        set_MinusButton.fontSize = 30
        set_MinusButton.fontName = "unifont"
        set_MinusButton.fontColor = UIColor.black
        
        set_MinusButton.action = {
                                     value -= 1
                                     if value < 1 { value = 1 }
                                     set_ValueLabel.text = String(value)
                                     let userDef = UserDefaults.standard
                                     userDef.set(value, forKey: name)
                                     userDef.synchronize()
                                 }
        
        set_MinusButton.createLabel()
        self.addChild(set_MinusButton)
        
        // CREATE LABEL
        let setLabel = SKLabelNode(fontNamed: "unifont")
        setLabel.position = CGPoint(x: self.frame.size.width / 2, y: h_position + h/2)
        setLabel.fontSize = 20
        setLabel.fontColor = SKColor.green
        setLabel.text = text
        setLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(setLabel)
    }
}
