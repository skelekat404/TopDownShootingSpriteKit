//
//  Goodbye.swift
//  SpriteDemo1
//
//  Created by Morgan Cividanes on 11/17/20.
//

import Foundation
import SpriteKit

class Goodbye: SKScene
{
    var message = "You win!"
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        createScene()
    }
    func createScene() {
            let wonNode = SKLabelNode(fontNamed: "Futura")
            wonNode.text = "You win!"
            wonNode.fontSize = 48
            wonNode.fontColor = SKColor.green
            wonNode.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(wonNode)
        }
    
    override func mouseUp(with event: NSEvent) {
        if let view = view {
            let myHello = Hello(size: size)
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            view.presentScene(myHello, transition: transition)
        }
        
        
    }
}
