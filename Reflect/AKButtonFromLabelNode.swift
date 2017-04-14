//
//  AKButtonFromLabelNode.swift
//  Reflect
//
//  Created by Admin on 12/01/15.
//  Copyright (c) 2015 Mamka Admina. All rights reserved.
//

// Touch events tracking implemented through closures.
// Be careful: When you need to call "self"'s methods in property 'action' of the object of this class
// you need capture "self"
// [weak self] in
// and unwrap it by optional binding
// if let strongSelf = self { strongSelf.SOME METHOD... }
//
// Example:
// settingsButton.action = { [weak self] in
// if let strongSelf = self {
//     strongSelf.view?.presentScene(SettingsMenu(size: strongSelf.frame.size))
// } }


import SpriteKit

class AKButtonFromLabelNode: SKShapeNode {
       
    var fontName: String!
    var fontSize: CGFloat!
    var fontColor: UIColor!
    var text: String!
    var action: (() -> Void)?
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        super.fillColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.7)
        super.strokeColor = UIColor.green
        self.isUserInteractionEnabled = true
    }
    
    func createLabel() {
        
        if (fontName == nil) {
            
            fontName = "System"
            print("Warning: Property 'fontName' of object AKButtonFromLabelNode is not difened. Default values have been set: fontName = System.")
        }
        
        if (fontSize == nil) {
           
            fontSize = 5
            print("Warning: Property 'fontSize' of object AKButtonFromLabelNode is not difened. Default values have been set: fontSize = 5.")
        }
        
        if (fontColor == nil) {
            
            fontColor = UIColor.green
            print("Warning: Property 'fontColor' of object AKButtonFromLabelNode is not difened. Default values have been set: fontColor = UIColor.greenColor().")
        }
        
        if (text == nil) {
            
            text = "Button"
            print("Warning: Property 'text' of object AKButtonFromLabelNode is not difened. Default values have been set: text = Button.")
        }
        
        // Create text
        let defaultButton = SKLabelNode(fontNamed: fontName)
        let font = UIFont(name: fontName, size: fontSize)!
        defaultButton.position = CGPoint(x: 0, y: -font.capHeight/2)
        defaultButton.fontSize = fontSize
        defaultButton.fontColor = fontColor
        defaultButton.text = text
        defaultButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        defaultButton.name =  self.name! + "_label"
        self.addChild(defaultButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        let action = SKAction.scale(by: 1.5, duration: 0.1)
        self.fillColor = UIColor.green
        self.run(action)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.parent!)

        let skAction = SKAction.scale(by: 1/1.5, duration: 0.1)
        self.run(skAction)
        
        if self.contains(location) {
           
            action?()
        }
        
        self.fillColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.7)
    }
}
