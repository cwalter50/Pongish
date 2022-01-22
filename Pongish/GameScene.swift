//
//  GameScene.swift
//  Pongish
//
//  Created by Christopher Walter on 1/22/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    
    override func didMove(to view: SKView)
    {
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.physicsBody = border
      
    }
    
   
}
