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

        let skView = self.view as SKView
        
        if skView.scene == nil {
            //    skView.showsFPS = true
            //    skView.showsNodeCount = true
                skView.showsPhysics = true
            let mainScene = MainMenu(size: skView.bounds.size)
            mainScene.scaleMode = .AspectFill
            skView.presentScene(mainScene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
