//
//  AKButtonFromLabelNode.swift
//  Reflect
//
//  Created by Admin on 12/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import SpriteKit

class AKButtonFromLabelNode: SKShapeNode {
       
    var fontName: String?
    var fontSize: CGFloat?
    var fontColor: UIColor?
    var text: String?
 
    func createLabel() {
        
        if (fontName == nil) || (fontSize == nil) || (fontColor == nil) || (text == nil) {
            fontName = "System"
            fontSize = 5
            fontColor = UIColor.greenColor()
            text = "Button"
            println("Warning: One of properties of object AKButtonFromLabelNode is not difened. Default values have been set (fontName = System, fontSize = 5, fontColor = green, text = Button).")
        }
        
        // CREATE TEXT
        var defaultButton = SKLabelNode(fontNamed: fontName!)
        var font:UIFont = UIFont(name: fontName!, size: fontSize!)!
        defaultButton.position = CGPointMake(0, -font.capHeight/2)
        defaultButton.fontSize = fontSize!
        defaultButton.fontColor = fontColor!
        defaultButton.text = text!
        defaultButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        defaultButton.name =  "_label"
        super.addChild(defaultButton)
        println(super.name)
    }
    
    override init() {
        super.init()
        
        super.strokeColor = super.fillColor
   //     super.physicsBody = SKPhysicsBody(rectangleOfSize: super.frame.size)
    //    super.physicsBody?.dynamic = false
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    
        let touch: AnyObject! = touches.anyObject()
        let touchLocation = touch.locationInNode(childNodeWithName(super.name!))
        
        println("bagaga")
        println(touchLocation.x)
        println(touchLocation.y)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
