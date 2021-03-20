//
//  Hello.swift
//  SpriteDemo1
//
//  Created by Morgan Cividanes on 11/17/20.
//

import Cocoa
import SpriteKit

class Hello: SKScene
{

    override func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black
        
        let titleNode = SKLabelNode(fontNamed: "Futura")
        titleNode.text = "TOP-DOWN SHOOTER"
        titleNode.fontSize = 58;
        titleNode.position = CGPoint(x: frame.midX, y: frame.midY + 150);
        titleNode.fontColor = SKColor.white
        addChild(titleNode)
        
        let nameNode = SKLabelNode(fontNamed: "Futura")
        nameNode.text = "By: Morgan Cividanes"
        nameNode.fontSize = 45;
        nameNode.position = CGPoint(x: frame.midX, y: frame.midY + 100);
        nameNode.fontColor = SKColor.white
        addChild(nameNode)
        
        let buttonNode = SKLabelNode(fontNamed: "Futura")
        buttonNode.text = "Click anywhere to start"
        buttonNode.fontSize = 48;
        buttonNode.position = CGPoint(x: frame.midX, y: frame.midY);
        buttonNode.fontColor = SKColor.green
        addChild(buttonNode)
        
        let controlsNode = SKLabelNode(fontNamed: "Futura")
        controlsNode.text = "CONTROLS: A to move left and D to move right, click to shoot. "
        controlsNode.fontSize = 30;
        controlsNode.position = CGPoint(x: frame.midX, y: frame.midY - 100);
        controlsNode.fontColor = SKColor.white
        addChild(controlsNode)
        
        let goalNode = SKLabelNode(fontNamed: "Futura")
        goalNode.text = "GOAL: 50 points to win, good luck!"
        goalNode.fontSize = 30;
        goalNode.position = CGPoint(x: frame.midX, y: frame.midY - 140);
        goalNode.fontColor = SKColor.white
        addChild(goalNode)
        
        let noteNode = SKLabelNode(fontNamed: "Futura")
        noteNode.text = "**NOTE: collisions are not working, use 'L' for loss screen and 'W' for win screen"
        noteNode.fontSize = 27;
        noteNode.position = CGPoint(x: frame.midX, y: frame.midY - 170);
        noteNode.fontColor = SKColor.red
        addChild(noteNode)
    }
    
    
    override func mouseUp(with event: NSEvent) {
        guard let view = view else { return }
        let myGame = Game(size: size)
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        view.presentScene(myGame, transition: transition)
        
    }
}
