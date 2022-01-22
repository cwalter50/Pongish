//
//  GameScene.swift
//  Pongish
//
//  Created by Christopher Walter on 1/22/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
 
    var paddle = SKSpriteNode()
    var ball = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        physicsWorld.contactDelegate = self
        
        paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.contactTestBitMask = 2
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.physicsBody = border
      
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
//        print(contact.bodyA)
//        print(contact.bodyB)
        
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2)
        {
            print("ball hit bob")
            contact.bodyB.node?.removeFromParent()
            // do math... to calcualte correct push after contact...
            ball.physicsBody?.applyImpulse(CGVector(dx: 300, dy: 300))
        }
        
        if (contact.bodyB.categoryBitMask == 1 && contact.bodyA.categoryBitMask == 2)
        {
            contact.bodyA.node?.removeFromParent()
            ball.physicsBody?.applyImpulse(CGVector(dx: 300, dy: 300))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        
        
        if location.y > frame.height / 2
        {
            createBob(touchLocation: location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
    
    func createBob(touchLocation: CGPoint)
    {
        let bob = SKSpriteNode(imageNamed: "BobBrownClearBackground")
        bob.size = CGSize(width: 75, height: 75)
        bob.position = touchLocation
        
        addChild(bob)
        
        bob.physicsBody = SKPhysicsBody(circleOfRadius: 37.5)
        bob.physicsBody?.affectedByGravity = false
        
        bob.physicsBody?.categoryBitMask = 2
        bob.physicsBody?.contactTestBitMask = 1

    }
   
}
