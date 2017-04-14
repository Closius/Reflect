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
    let toastyMusicUrl = Bundle.main.url(forResource: "game", withExtension: "mp3")
    
    // Names of buttons
    let startGameButtonCategoryName     = "StartGameButton"
    let settingsButtonCategoryName      = "SettingsButton"
    let aboutButtonCategoryName         = "AboutButton"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        self.name = "MainScene"
        
        // CREATE WELCOME LABEL
        let labelWelcome = SKLabelNode(fontNamed: "unifont")
        labelWelcome.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 130)
        labelWelcome.fontSize = 30
        labelWelcome.fontColor = SKColor.green
        labelWelcome.text = "Weclome to Reflect!"
        labelWelcome.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        labelWelcome.name = "WelcomeGame"
        self.addChild(labelWelcome)
        
        //CREATE START GAME BUTTON
        let w: CGFloat = 130
        let h: CGFloat = 40
        let startGameButton = AKButtonFromLabelNode(rect: CGRect(x: -w/2, y: -h/2, width: w, height: h))
        startGameButton.name = startGameButtonCategoryName
        startGameButton.position = CGPoint(x: self.frame.size.width / 2, y: labelWelcome.position.y - 130)
        startGameButton.text = "Start Game"
        startGameButton.fontSize = 20
        startGameButton.fontName = "unifont"
        startGameButton.fontColor = UIColor.black
        
        // Touch events tracking implemented through closures.
        // Be careful: When you need to call "self"'s methods in property 'action' of the object of this class
        // you need capture "self"
        // [weak self] in
        // and unwrap it by optional binding
        // if let strongSelf = self { strongSelf.SOME METHOD... }
        startGameButton.action = { [weak self] in
        
            if let strongSelf = self {
                strongSelf.view?.presentScene(GameScene(size: strongSelf.frame.size), transition: SKTransition.fade(withDuration: 0.3))
            }
        }
        
        startGameButton.createLabel()
        self.addChild(startGameButton)
        
        // CREATE SETTINGS BUTTON
        let settingsButton = AKButtonFromLabelNode(rect: CGRect(x: -w/2, y: -h/2, width: w, height: h))
        settingsButton.name = settingsButtonCategoryName
        settingsButton.position = CGPoint(x: self.frame.size.width / 2, y: startGameButton.position.y - 80)
        settingsButton.text = "Settings"
        settingsButton.fontSize = 20
        settingsButton.fontName = "unifont"
        settingsButton.fontColor = UIColor.black
        settingsButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(SettingsMenu(size: strongSelf.frame.size), transition: SKTransition.fade(withDuration: 0.3))
            } }
        settingsButton.createLabel()
        self.addChild(settingsButton)
        
        // CREATE ABOUT BUTTON
        let aboutButton = AKButtonFromLabelNode(rect: CGRect(x: -w/2, y: -h/2, width: w, height: h))
        aboutButton.name = aboutButtonCategoryName
        aboutButton.position = CGPoint(x: self.frame.size.width / 2, y: settingsButton.position.y - 80)
        aboutButton.text = "About"
        aboutButton.fontSize = 20
        aboutButton.fontName = "unifont"
        aboutButton.fontColor = UIColor.black
        
        aboutButton.action = { [weak self] in
            if let strongSelf = self {
                strongSelf.view?.presentScene(About(size: strongSelf.frame.size), transition: SKTransition.fade(withDuration: 0.3))
            }
        }
        
        aboutButton.createLabel()
        self.addChild(aboutButton)
    }
    
    /*
    override func didMoveToView(view: SKView) {
        eventMusicPlayer = AVAudioPlayer(contentsOfURL: toastyMusicUrl, error: nil)
        eventMusicPlayer.numberOfLoops = -1
        eventMusicPlayer.prepareToPlay()
        eventMusicPlayer.play()
    }
    */
    
    func randRange (_ lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}
