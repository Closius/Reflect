//
//  AKButtonFromLabelNode.swift
//  Reflect
//
//  Created by Admin on 12/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

import SpriteKit

class AKButtonFromLabelNode: SKShapeNode, SKSceneDelegate {
       
    var fontName: String?
    var fontSize: CGFloat?
    var fontColor: UIColor?
    var text: String?
    var action: (() -> Void)?
 
    func createLabel() {
        
        if (fontName == nil) {
            fontName = "System"
            println("Warning: Property 'fontName' of object AKButtonFromLabelNode is not difened. Default values have been set: fontName = System.")
        }
        if (fontSize == nil) {
            fontSize = 5
            println("Warning: Property 'fontSize' of object AKButtonFromLabelNode is not difened. Default values have been set: fontSize = 5.")
        }
        if (fontColor == nil) {
            fontColor = UIColor.greenColor()
            println("Warning: Property 'fontColor' of object AKButtonFromLabelNode is not difened. Default values have been set: fontColor = UIColor.greenColor().")
        }
        if (text == nil) {
            text = "Button"
            println("Warning: Property 'text' of object AKButtonFromLabelNode is not difened. Default values have been set: text = Button.")
        }
        
        // CREATE TEXT
        var defaultButton = SKLabelNode(fontNamed: fontName!)
        var font:UIFont = UIFont(name: fontName!, size: fontSize!)!
        defaultButton.position = CGPointMake(0, -font.capHeight/2)
        defaultButton.fontSize = fontSize!
        defaultButton.fontColor = fontColor!
        defaultButton.text = text!
        defaultButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        defaultButton.name =  super.name! + "_label"
        super.addChild(defaultButton)
    }
    
    override init() {
        super.init()
        
        super.strokeColor = super.fillColor
        self.userInteractionEnabled = true   // Recive touch events!!!!!
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    
        
      //  println(super.name)
        action!()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
