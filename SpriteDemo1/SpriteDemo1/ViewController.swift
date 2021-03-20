//
//  ViewController.swift
//  SpriteDemo1
//
//  Created by Loren Olson on 10/26/20.
//

import Cocoa
import SpriteKit


class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: view.frame.width, height: view.frame.height)
        let myScene = Hello(size: size)
        
        
        if let myView = view as? SKView {
            myView.presentScene(myScene)
        }
    }




}

