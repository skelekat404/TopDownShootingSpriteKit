//
//  Lose.swift
//  SpriteDemo1
//
//  Created by Morgan Cividanes on 12/2/20.
//

import Foundation
import SpriteKit

class Lose: SKScene
{
    var message = "You Lose! Better luck next time"
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        createScene()
    }
    func createScene() {
            let loseNode = SKLabelNode(fontNamed: "Futura")
            loseNode.text = "You Lose! Better luck next time"
            loseNode.fontSize = 48
            loseNode.fontColor = SKColor.red
            loseNode.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(loseNode)
        }
    
    override func mouseUp(with event: NSEvent) {
        if let view = view {
            let myHello = Hello(size: size)
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            view.presentScene(myHello, transition: transition)
        }
        
        
    }
}
