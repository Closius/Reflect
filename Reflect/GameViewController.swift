//
//  GameViewController.swift
//  Reflect
//
//  Created by Admin on 12/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as! SKView
        
        if skView.scene == nil {
            
            // skView.showsFPS = true
            // skView.showsNodeCount = true
            // skView.showsPhysics = true
            
            let mainScene = MainMenu(size: skView.bounds.size)
            mainScene.scaleMode = .aspectFill
            skView.presentScene(mainScene)
        }
    }

    override var shouldAutorotate : Bool {
       
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular {
            
            return .all
            
        } else {
            
            return .allButUpsideDown
        }
    }

    override var prefersStatusBarHidden : Bool {
       
        return true
    }
}
