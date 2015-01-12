//
//  AKButtonFromLabelNode.swift
//  Reflect
//
//  Created by Admin on 12/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import SpriteKit

class AKButtonFromLabelNode: SKNode {
   
 //   var defaultButton: SKShapeNode
 //   var activeButton: SKShapeNode

    var text: String?
    var nameButton: String?
    var backgroundBox: CGRect?
    var textColor: SKColor?
    var backgroundColor: SKColor?
    var srtokeColor: SKColor?
    var positionButton: CGPoint?
    

//    var defaultButton: SKSpriteNode
//    05.var activeButton: SKSpriteNode
//    06.var action: () -> Void
//    07.
//    08.init(defaultButtonImage: String, activeButtonImage: String, buttonAction: () -> Void) {
//        09.defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
//        10.activeButton = SKSpriteNode(imageNamed: activeButtonImage)
//        11.activeButton.hidden = true
//        12.action = buttonAction
//        13.
//        14.super.init()
//        15.
//            16.userInteractionEnabled = true
//        17.addChild(defaultButton)
//        18.addChild(activeButton)

    override init(){
        
//        var startGameButton = SKLabelNode(fontNamed: "unifont")
//        startGameButton.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 200)
//        startGameButton.fontSize = 25
//        startGameButton.fontColor = SKColor.greenColor()
//        startGameButton.color = SKColor.grayColor()
//        startGameButton.calculateAccumulatedFrame()
//        
//        startGameButton.text = "START GAME"
//        startGameButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
//        startGameButton.name = "StartGame"
//        self.addChild(startGameButton)
       super.init()
        // CREATE BACKGROUND
        var defaultButton = SKShapeNode(rect: backgroundBox!)
        defaultButton.name = nameButton! + "_background"
        defaultButton.fillColor = backgroundColor!
        defaultButton.strokeColor = (srtokeColor != nil) ? srtokeColor! : backgroundColor!
        defaultButton.position = positionButton!
        defaultButton.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(defaultButton.frame.width, defaultButton.frame.height))
        defaultButton.physicsBody?.dynamic = false
        addChild(defaultButton)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
