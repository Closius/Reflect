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
    let toastyMusicUrl = NSBundle.mainBundle().URLForResource("game", withExtension: "mp3")
    
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
        startGameButton.fontColor = UIColor.blackColor()
        // Touch events tracking implemented through closures.
        // Be careful: When you need to call "self"'s methods in property 'action' of the object of this class
        // you need capture "self"
        // [weak self] in
        // and unwrap it by optional binding
        // if let strongSelf = self { strongSelf.SOME METHOD... }
        startGameButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(GameScene(size: strongSelf.frame.size), transition: SKTransition.fadeWithDuration(0.3))
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
        settingsButton.fontColor = UIColor.blackColor()
        settingsButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(SettingsMenu(size: strongSelf.frame.size), transition: SKTransition.fadeWithDuration(0.3))
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
        aboutButton.fontColor = UIColor.blackColor()
        aboutButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(About(size: strongSelf.frame.size), transition: SKTransition.fadeWithDuration(0.3))
            } }
        aboutButton.createLabel()
        self.addChild(aboutButton)

    }
    
//    override func didMoveToView(view: SKView) {
//        eventMusicPlayer = AVAudioPlayer(contentsOfURL: toastyMusicUrl, error: nil)
//        eventMusicPlayer.numberOfLoops = -1
//        eventMusicPlayer.prepareToPlay()
//        eventMusicPlayer.play()
//    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}