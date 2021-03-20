//
//  Game.swift
//  SpriteDemo1
//
//  Created by Morgan Cividanes on 11/30/2020.
//

import Cocoa
import SpriteKit

//SOURCE: https://developer.apple.com/library/archive/documentation/General/Conceptual/GameplayKit_Guide/RandomSources.html
import GameKit

//TO DO WHEN YOU WAKE UP -----
//ADD RIGHT AND LEFT WALLS ----
//ADD WIN / LOSS -----
//ADD COLLISIONS WITH ENEMY + PLAYER ??!?!?!?
//BIGGER SPRITES PLEASE -----
//FIX UP MAIN MENU ------
//ADD CONTROLS MENU? OR JUST ADD THE TEXT TO MAIN MENU -----
//COMMENTATION
//MAYBE A TIMER/CLOCK????
//ADD FINAL SCORE + TIME? AT WIN/LOSS MENU

class Game: SKScene, SKPhysicsContactDelegate
{
    //declaring player
    var player:SKSpriteNode!
    //declaring enemy
    var enemy:SKSpriteNode!
    //declaring score label
    var scoreLabel: SKLabelNode!
    //declaring lives label
    var livesLabel: SKLabelNode!
    //declaring player & enemy & bullet texture for physicsbody
    var playerTexture = SKTexture(imageNamed: "player")
    var enemyTexture = SKTexture(imageNamed: "enemy")
    var bulletTexture = SKTexture(imageNamed: "bullet")
//    let playerCategory:UInt32 = 0x1 << 0
//    let enemyCategory:UInt32 = 0x1 << 1
//    let bulletCategory:UInt32 = 0x1 << 0

    //lives variable which begins at 5
    var lives: Int = 5
    {
        didSet
        {
            //lives variable display
            livesLabel.text = "Lives: \(lives)"
        }
    }
    
    //score variable which begins at 0
    var score:Int = 0
    {
        //lives variable display
        //this will allow the label to update as well
        didSet
        {
            scoreLabel.text = "Score: \(score)"
        }
    }
    //declaring a timer for enemy generation
    var gameTime:Timer!
    
    override func didMove(to view: SKView)
    {
        //********* INITIALIZING PLAYER ******
        //initializing the player node
        player = SKSpriteNode(imageNamed: "player")
        player.name = "Player"
        //setting player to bottom middle of the sceen for top down game
        player.position = CGPoint(x: frame.midX, y: player.size.height / 2 + 20)
        //setting physicsbody = to the size of the node
        let body = SKPhysicsBody(texture: playerTexture, size: player.size)
        body.isDynamic = true
        player.physicsBody = body
        addChild(player)
//        player.physicsBody?.contactTestBitMask = enemyCategory
//        player.physicsBody?.collisionBitMask = 0
//        player.physicsBody?.usesPreciseCollisionDetection = true
        //player.size = CGSize + 60
        //***********************************
        
        
        //i dont want gravity pulling down since its a top down game
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        //*******************************
        
        //********* INITIALIZING SCORE *****
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: frame.midX - 100, y: frame.maxY - 40)
        scoreLabel.fontName = "ArialRoundedMTBold"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.white
        score = 0
        self.addChild(scoreLabel)
        //*******************************
        
        //********* INITIALIZING LIVES ******
        livesLabel = SKLabelNode(text: "Lives: 5")
        livesLabel.position = CGPoint(x: frame.midX + 100, y: frame.maxY - 40)
        livesLabel.fontName = "ArialRoundedMTBold"
        livesLabel.fontSize = 40
        livesLabel.fontColor = SKColor.white
        lives = 5
        self.addChild(livesLabel)
        //*******************************
        
        //********* INITIALIZING ENEMY TIMER, OR HOW LONG UNTIL EACH ENEMY SPAWNS
        gameTime = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(spawnEnemy), userInfo: nil, repeats: true)
        //*******************************
        
        //IT WILL CALL ANYTHING INITIALLY MADE IN THIS METHOD
        createScene()
        
        physicsWorld.contactDelegate = self
    }
    
    //THIS FUNCTION WILL SPAWN THE ENEMIES AT RANDOM LOCATIONS AT THE TOP OF THE VIEWPORT
    @objc func spawnEnemy()
    {
        //print("enemy")
        //CREATING THE ENEMY NODE WITH ENEMY IMAGE
        let enemy = SKSpriteNode(imageNamed: "enemy")
        //I imported GameKit in order to use its random function
        let randomEnemyPos = GKRandomDistribution(lowestValue: 0, highestValue: 900)
        //SETTING THE POSITION  FROM RANDOMENEMYPOS TO POS
        let pos = CGFloat(randomEnemyPos.nextInt())
        
        //SETTING ENEMY POSITION AT THE RANDOM VARIABLE
        enemy.position = CGPoint(x: pos, y: frame.maxY)
        //SETTING THE VARIABLE NAME
        enemy.name = "Enemy"
        //setting physicsbody = to the size of the node
        enemy.physicsBody = SKPhysicsBody(texture: enemyTexture, size: player.size)
        enemy.physicsBody?.isDynamic = true
        self.addChild(enemy)
//        enemy.physicsBody?.categoryBitMask = enemyCategory
//        enemy.physicsBody?.contactTestBitMask = bulletCategory
//        enemy.physicsBody?.collisionBitMask = 0

        //setting the time interval to 6
        let interval:TimeInterval = 7
        
        //creating an action array
        var actionArray = [SKAction]()
        
        //SOURCE: https://developer.apple.com/documentation/spritekit/skaction
        //making it so the move downwards
        actionArray.append(SKAction.move(to: CGPoint(x: pos, y: -enemy.size.height), duration: interval))
        //removing the action
        actionArray.append(SKAction.removeFromParent())
        //running it
        //SOURCE: https://www.hackingwithswift.com/example-code/games/how-to-run-skactions-in-a-sequence
        enemy.run(SKAction.sequence(actionArray))
        //actionArray.append(SKAction.move(to: CGPoint(x: pos, y: -enemy.size.height), ))
    }

    //FUNCTION FOR WHEN THE MOUSE IS CLICKED
    override func mouseDown(with event: NSEvent)
    {
        shoot()
    }
    //THIS WILL SHOOT A BULLET
    func shoot()
    {
        
        //THIS WILL PLAY THE SHOOTING AUDIO
        self.run(SKAction.playSoundFileNamed("9_mm_gunshot-mike-koenig-123.mp3", waitForCompletion: false))
        
        //CREATING A BULLET NODE
        let bulletNode = SKSpriteNode(imageNamed: "bullet")
        //SETTING THE POSITION OF THE BULLET TO WHERE THE PLAYER IS
        bulletNode.position = CGPoint(x: player.position.x, y: player.position.y + 100)
        //ADJUSTING THE Y POSITION
        bulletNode.position.y += 5
        //SETTING VARIABLE NAME TO BULLET
        bulletNode.name = "Bullet"
        //setting physicsbody = to the size of the node
        bulletNode.physicsBody = SKPhysicsBody(texture: bulletTexture, size: player.size)
        bulletNode.physicsBody?.isDynamic = true
        self.addChild(bulletNode)
//        bulletNode.physicsBody?.categoryBitMask = bulletCategory
//        bulletNode.physicsBody?.contactTestBitMask = enemyCategory
//        bulletNode.physicsBody?.collisionBitMask = 0
//        bulletNode.physicsBody?.usesPreciseCollisionDetection = true
        
        
        
        let interval:TimeInterval = 0.3
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: frame.maxY - 10), duration: interval))
        actionArray.append(SKAction.removeFromParent())
        
        bulletNode.run(SKAction.sequence(actionArray))
        
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }
        print("didBegin")
//        var firstBody:SKPhysicsBody
//        var secondBody:SKPhysicsBody
        if nameA == "Enemy" && nameB == "Player"
        {
            //let pointB = nodeA.position
            print("collision with enemy and player")
            nodeA.removeFromParent()
            enemyDidCollideWithPlayer()
        }
        
        if nameA == "Bullet" && nameB == "Enemy"
        {
            print("collision with enemy and bullet")
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            bulletDidCollideWithEnemy()
        }
        
        //COLLISION BETWEEN ENEMY AND BULLET ************
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
//        {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        }
//        else
//        {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
//
//        if (firstBody.categoryBitMask & bulletCategory) != 0 && (secondBody.categoryBitMask & enemyCategory) != 0
//        {
//            bulletDidCollideWithEnemy(bullet: firstBody.node as! SKSpriteNode, enemy: secondBody.node as! SKSpriteNode)
//        }
//        //************************************************
//        if (firstBody.categoryBitMask & enemyCategory) != 0 && (secondBody.categoryBitMask & playerCategory) != 0
//        {
//            enemyDidCollideWithPlayer(enemy: firstBody.node as! SKSpriteNode, player: secondBody.node as! SKSpriteNode)
//        }
    }
    func bulletDidCollideWithEnemy()
    {
        self.run(SKAction.playSoundFileNamed("Explosion+1.mp3", waitForCompletion: false))
        
        
        score = score + 1
    }
    
    func enemyDidCollideWithPlayer()
    {
        self.run(SKAction.playSoundFileNamed("Explosion+1.mp3", waitForCompletion: false))
        //enemy.removeFromParent()
        
        lives = lives - 1
    }
    
    override func keyDown(with event: NSEvent)
    {
            guard let node = childNode(withName: "Player") else { return }
            
            if let characters = event.characters
            {
                //left
                if characters == "a"
                {
                    let left = SKAction.moveBy(x: -50.0, y: 0.0, duration : 0.1)
                    node.run(left)
                }
                //right
                else if characters == "d"
                {
                    let right = SKAction.moveBy(x: 50.0, y: 0.0, duration : 0.1)
                    node.run(right)
                }
                //win screen
                if characters == "w"
                {
                    gameOverWin()
                }
                //loss screen
                if characters == "l"
                {
                    gameOverLose()
                }
            }
    }
   func createScene()
   {

    //ANY INTIAL PLATFORMS CAN GO HERE
  
    
   }
    
    override func update(_ currentTime: TimeInterval)
    {
        //if points reaches the 50, you win
        if score >= 50
        {
            gameOverWin()
        }
        //this is to make sure score never goes negative
        if score < 0
        {
            score = 0
        }
        if lives <= 0
        {
            gameOverLose()
        }
        //didBegin(_ contact: SKPhysicsContact)
        //used for testing win/loss
//        if test >= 10
//        {
//            gameOverWin()
//        }
//        let randomSpawnTime = Double.random(in: 0..<10)
//        if randomSpawnTime < 0.1
//        {
//            let point = CGPoint(x: frame.midX + CGFloat.random(in: -400...400), y: frame.height)
//            addRainDrop(point: point)
//        }
    }
    func gameOverWin()
    {
        let win = Goodbye(size: size)
                win.message = "You Win!"
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                view?.presentScene(win, transition: transition)
    }
    func gameOverLose()
    {
        let lose = Lose(size: size)
        lose.message = "You Lose!"
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                view?.presentScene(lose, transition: transition)
    }
    
    
   /*
    
    func pointsUpdate()
    {
        if let pointsNode = childNode(withName: "Points") as? SKLabelNode
        {
            pointsNode.text = "Points: \(points)"
        }
    
    }
    
    
    func createScene() {
        backgroundColor = SKColor.black
        
        let pointsNode = SKLabelNode(fontNamed: "Futura")
        pointsNode.text = "Points: \(points)"
        pointsNode.fontSize = 48
        pointsNode.name = "Points"
        pointsNode.fontColor = SKColor.white
        pointsNode.position = CGPoint(x: frame.minX + 100, y: frame.maxY - 75)
        addChild(pointsNode)
        // Create the red apple using a texture, give it a physics body, and make it dynamic.
        let appleTexture = SKTexture(imageNamed: "redapple")
        let node = SKSpriteNode(texture: appleTexture)
        node.position = CGPoint(x: frame.midX, y: frame.midY)
        node.size = CGSize(width: 100, height: 100)
        node.name = "Apple"
        let body = SKPhysicsBody(rectangleOf: node.size)
        body.isDynamic = true
        node.physicsBody = body
        addChild(node)
        
        // Create the floor, give it a physics body, make it static.
        let floor = SKSpriteNode(color: SKColor.green, size: CGSize(width: frame.width, height: 10))
        floor.position = CGPoint(x: frame.midX, y: 5)
        floor.name = "Floor"
        let floorBody = SKPhysicsBody(rectangleOf: floor.size)
        floorBody.isDynamic = false
        floor.physicsBody = floorBody
        addChild(floor)
    }
    
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }
        if nameA == "Floor" && nameB == "Apple"
        {
            
        }
        //checking contact between rain (watermelon) and ground
        if nameA == "Floor" && nameB == "Rain"
        {
            let pointB = nodeB.position
            nodeB.removeFromParent()
            rainDropLoss(center: pointB, contactPoint: contact.contactPoint)
        }
        //checking contact between rain (watermelon) and apple (player)
        if nameA == "Apple" && nameB == "Rain" {
            let pointB = nodeB.position
            nodeB.removeFromParent()
            rainDropCatch(center: pointB, contactPoint: contact.contactPoint)
        }
    }
    //when they collide...
    func rainDropLoss(center: CGPoint, contactPoint: CGPoint) {
        points -= 1
//        for _ in 1...10 {
//            let point = CGPoint(x: center.x + CGFloat.random(in: -30...30), y: center.y + CGFloat.random(in: -30...30))
//           let dir = CGPoint(x: point.x - contactPoint.x, y: point.y - contactPoint.y)
//            makeCherries(point: point, direction: dir)
//        }
    }
    func rainDropCatch(center: CGPoint, contactPoint: CGPoint)
    {
        points += 10
    }
    
    func addRainDrop(point: CGPoint)
    {
        let node = SKSpriteNode(texture: melonTexture)
        node.position = point
        node.name = "Rain"
        node.size = CGSize(width: 80, height: 80)
//        let twoPI = CGFloat.pi * 2.0
//        node.zRotation = CGFloat.random(in: 0...twoPI)
        let body = SKPhysicsBody(texture: melonTexture, size: node.size)
        body.isDynamic = true
        body.contactTestBitMask = 1
        node.physicsBody = body
        addChild(node)
    }

   
    */
    
        
    
    
}
