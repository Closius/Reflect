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
    
    var eventMusicPlayer = AVAudioPlayer()
    let toastyMusicUrl = NSBundle.mainBundle().URLForResource("toasty", withExtension: "mp3")
    
    // Names of buttons
    let startGameButtonCategoryName     = "StartGameButton"
    let settingsButtonCategoryName      = "SettingsButton"
    let aboutButtonCategoryName         = "AboutButton"
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        self.name = "MainScene"
        
        //CREATE WELCOME LABEL
        var labelWelcome = SKLabelNode(fontNamed: "unifont")
        labelWelcome.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 130)
        labelWelcome.fontSize = 30
        labelWelcome.fontColor = SKColor.greenColor()
        labelWelcome.text = "Weclome to Reflect!"
        labelWelcome.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        labelWelcome.name = "WelcomeGame"
        self.addChild(labelWelcome)
        
        //CREATE START GAME BUTTON
        var w:CGFloat = 130
        var h:CGFloat = 40
        var startGameButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        startGameButton.name = startGameButtonCategoryName
        startGameButton.position = CGPointMake(self.frame.size.width / 2, labelWelcome.position.y - 130)
        startGameButton.text = "Start Game"
        startGameButton.fontSize = 20
        startGameButton.fontName = "unifont"
        startGameButton.fillColor = UIColor.greenColor()
        startGameButton.fontColor = UIColor.blackColor()
        // Touch events tracking implemented through closures.
        // Be careful: When you need to call "self"'s methods in property 'action' of the object of this class
        // you need capture "self"
        // [weak self] in
        // and unwrap it by optional binding
        // if let strongSelf = self { strongSelf.SOME METHOD... }
        startGameButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(GameScene(size: strongSelf.frame.size))
            } }
        startGameButton.createLabel()
        self.addChild(startGameButton)
        
        //CREATE SETTINGS BUTTON
        var settingsButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        settingsButton.name = settingsButtonCategoryName
        settingsButton.position = CGPointMake(self.frame.size.width / 2, startGameButton.position.y - 80)
        settingsButton.text = "Settings"
        settingsButton.fontSize = 20
        settingsButton.fontName = "unifont"
        settingsButton.fillColor = UIColor.greenColor()
        settingsButton.fontColor = UIColor.blackColor()
        settingsButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(SettingsMenu(size: strongSelf.frame.size))
            } }
        settingsButton.createLabel()
        self.addChild(settingsButton)
        
        //CREATE ABOUT BUTTON
        var aboutButton = AKButtonFromLabelNode(rect: CGRectMake(-w/2, -h/2, w, h))
        aboutButton.name = aboutButtonCategoryName
        aboutButton.position = CGPointMake(self.frame.size.width / 2, settingsButton.position.y - 80)
        aboutButton.text = "About"
        aboutButton.fontSize = 20
        aboutButton.fontName = "unifont"
        aboutButton.fillColor = UIColor.greenColor()
        aboutButton.fontColor = UIColor.blackColor()
        aboutButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(About(size: strongSelf.frame.size))
            } }
        aboutButton.createLabel()
        self.addChild(aboutButton)

    }
    
   
    
    override func willMoveFromView(view: SKView) {
        
    
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        
//        var touch: UITouch = touches.allObjects[0] as UITouch
//        var location: CGPoint = touch.locationInNode(self)
//    
//        if self.childNodeWithName(startGameButtonCategoryName)?.containsPoint(location) == true {
//            self.view?.presentScene(GameScene(size: CGSizeMake(self.frame.width, self.frame.height)))
//        }
//        
//        if self.childNodeWithName(settingsButtonCategoryName)?.containsPoint(location) == true {
//            self.view?.presentScene(SettingsMenu(size: CGSizeMake(self.frame.width, self.frame.height)))
//        }
//        
//        if self.childNodeWithName(aboutButtonCategoryName)?.containsPoint(location) == true {
//            println(aboutButtonCategoryName)
//        }
//        
//    }
 
    
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