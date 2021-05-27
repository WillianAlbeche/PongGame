//
//  GameScene.swift
//  PongGame
//
//  Created by Willian Magnum Albeche on 25/05/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main =  SKSpriteNode()
    var topLabel = SKLabelNode()
    var btmLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) { // control de scene
        
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLabel = self.childNode(withName: "btmLabel") as! SKLabelNode
        
        
        
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        print(self.view?.bounds.height)
        
        enemy = self.childNode(withName: "enemy")! as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main")! as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        starGame()
        
    }
    
    func starGame(){
        score = [0,0]
        topLabel.text = "\(score[1])"
        btmLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 8, dy: 8))
    }
    
    func addScore(playerWon: SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 8, dy: 8))
        }
        else if playerWon ==  enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -8, dy: -8))
        }
        
        topLabel.text = "\(score[1])"
        btmLabel.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            
            if currentyGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentyGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentyGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.5))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
            break
        case .player2:
            
            break
        }
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWon: main)
        }
        
        
    }
}
