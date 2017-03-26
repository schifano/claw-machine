import SpriteKit



// TODO: Open claw state
// TODO: Closed claw state
// FIXME: handle collision with glass

struct Actions {
    static let up = SKAction.moveBy(x: 0.0, y: 6.0, duration: 0.1)
    
    static let down = SKAction.moveBy(x: 0.0, y: -6.0, duration: 0.1)
    static let moveDown = SKAction.repeatForever(down)
    
    static let left = SKAction.moveBy(x: -6.0, y: 0.0, duration: 0.1)
    
    static let right = SKAction.moveBy(x: 6.0, y: 0.0, duration: 0.1)
    static let moveRight = SKAction.repeatForever(right)
    
    
    static let wait = SKAction.wait(forDuration: 1.5)
    
    // FIXME: Test and find a better point to apply force for both claws
    static let leftForce = SKAction.applyForce(leftClawForceVector(), at: leftClawForcePoint(), duration: 5.0)
    static let repeatLeftForce = SKAction.repeatForever(leftForce)
    
    static let rightForce = SKAction.applyForce(leftClawForceVector(), at: rightClawForcePoint(), duration: 5.0)
    static let repeatRightForce = SKAction.repeatForever(rightForce)
    
    
    // Utility methods
    static func leftClawForceVector() -> CGVector {
        let degreesInRadians = GLKMathDegreesToRadians(45)
        // determine vector components and direction
        let dx = cosf(degreesInRadians)
        let dy = sinf(degreesInRadians)
        // 5 represents scale of force
        let forceVector = CGVector(dx: CGFloat(dx*500), dy: CGFloat(dy*500))
        return forceVector
    }
    
    /// Returns point at which the force is applied on the left claw
    static func leftClawForcePoint() -> CGPoint {
        let leftClawPoint = CGPoint(x: Claw.leftClaw.position.x, y: Claw.leftClaw.position.y)
        return leftClawPoint
    }
    
    /// Returns point at which the force is applied on the right claw
    static func rightClawForcePoint() -> CGPoint {
        let rightClawPoint = CGPoint(x: Claw.rightClaw.position.x, y: Claw.rightClaw.position.y)
        return rightClawPoint
    }
    
}

public class Claw {
    
    static let motor = Sprites.createMotorSprite()
    static let leftClaw = Sprites.createLeftClawSprite()
    static let rightClaw = Sprites.createRightClawSprite()
    static let contactDetector = Sprites.createContactDetectorSprite()
    
    // MARK: Apply Force
    static func applyForceToOpen(leftClaw: SKSpriteNode, rightClaw: SKSpriteNode) {
        
        // ######## LEFT CLAW
        // Experiment with force
        let degreesInRadians = GLKMathDegreesToRadians(45)
        // determine vector components and direction
        let dx = cosf(degreesInRadians)
        let dy = sinf(degreesInRadians)
        // 5 represents scale of force
        let forceVector = CGVector(dx: CGFloat(dx*500), dy: CGFloat(dy*500))
        let leftClawPoint = CGPoint(x: leftClaw.position.x, y: leftClaw.position.y)
        leftClaw.physicsBody?.applyForce(forceVector, at: leftClawPoint)
        
    
        
        // ######## RIGHT CLAW
        // Experiment with force
        let degreesInRadians2 = GLKMathDegreesToRadians(45)
        // determine vector components and direction
        let dx2 = cosf(degreesInRadians2)
        let dy2 = sinf(degreesInRadians2)
        // 5 represents scale of force
        let forceVector2 = CGVector(dx: CGFloat(dx2*500), dy: CGFloat(dy2*500))
        let rightClawPoint = CGPoint(x: rightClaw.position.x, y: rightClaw.position.y)
        rightClaw.physicsBody?.applyForce(forceVector2, at: rightClawPoint)
        
    }

    static func moveClawDown(finished: () -> Void) {
        print("down")

        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    Actions.down,
                    SKAction.run({
                        //Code you want to execute
                        if Claw.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
                            Claw.motor.removeAction(forKey: "moveDown")
                        }
                        
                        if Claw.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
                            Claw.motor.removeAction(forKey: "moveDown")
                        }
                    })
                ])
            ),
            withKey: "moveDown"
        )
        finished()
    }

    
    
    // MARK: Claw movement code blocks
    static let moveLeftBlock = SKAction.run({
        
        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    SKAction.run({
                        //Code you want to execute
                        if Claw.leftClaw.position.x <= 50 {
                            
                            print("moved left")
                            
                            Claw.motor.removeAction(forKey: "moveLeft")
                            
                            Container.button.isUserInteractionEnabled = true
                            Collision.contactMade = false // reset
                        }
                    }),
                    Actions.left
                    ])
            ),
            withKey: "moveLeft"
        )
        
    })
    
    static let moveUpBlock = SKAction.run({
        
        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    SKAction.run({
                        //Code you want to execute
                        if Claw.motor.frame.maxY >= Container.gameWindowShape.frame.maxY-10 {
                            print("made it up")
                            Claw.motor.run(Claw.moveLeftBlock)
                            Claw.motor.removeAction(forKey: "moveUp")
                        }
                    }),
                    Actions.up
                    ])
            ),
            withKey: "moveUp"
        )
        
    })
    
    static let moveDownBlock = SKAction.run({
        
        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    SKAction.run({
                        
                        //Code you want to execute
                        // FIXME: if one has been hit, don't check the other
                        if (Claw.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10) || Collision.contactMade {
                            Claw.motor.removeAction(forKey: "moveDown")
                            Claw.motor.run(Actions.wait,
                                           completion: {() -> Void in
                                            Claw.motor.run(Claw.moveUpBlock)
                            })
                        } else if (Claw.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10) || Collision.contactMade {
                            Claw.motor.removeAction(forKey: "moveDown")
                            Claw.motor.run(Actions.wait,
                                           completion: {() -> Void in
                                            Claw.motor.run(Claw.moveUpBlock)
                            })
                        }
                    }),
                    Actions.down
                ])
            ),
            withKey: "moveDown"
        )
    })
    
    
    
    /// Method that handles claw sequence to return home
    static func returnClawHome() {
        print("return claw home")

        // user must wait for claw to return to try again
        Container.button.isUserInteractionEnabled = false
        
        // FIXME: further decouple these methods
        let forceGroup = SKAction.group([Actions.leftForce, Actions.rightForce])
        Claw.motor.run(forceGroup,
            completion: {() -> Void in
                print("finished force for some reason")
        })
        
        Claw.motor.run(moveDownBlock)
    }
    
    
    /// Method moves claw right continuously until the button is released
    static let moveRightBlock = SKAction.run({
        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    
                    // first action - check logic
                    SKAction.run({
                        if Claw.rightClaw.frame.maxX >= Container.gameWindowShape.frame.maxX-10 {
                            Claw.motor.removeAction(forKey: "moveRight")
                        }
                    }),
                    
                    // second action - execute movement
                    Actions.right
                ])
            ),
            withKey: "moveRight"
        )
    })
        
        
        
        

    
    /// Method moves claw down continuously until a collision occurs
    static func moveClawDown() {
        
        
//        // FIXME: if one has been hit, don't check the other
//        if (Claw.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10) || Collision.contactMade {
//            Claw.motor.removeAction(forKey: "moveDown")
//            Claw.motor.run(Actions.wait,
//                           completion: {() -> Void in
//                            let group = SKAction.group([Actions.repeatLeftForce, block1])
//                            Claw.motor.run(group,
//                                           completion: {() -> Void in
//                                            
//                            })
//            })
//        } else if (Claw.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10) || Collision.contactMade {
//            Claw.motor.removeAction(forKey: "moveDown")
//            Claw.motor.run(Actions.wait,
//                           completion: {() -> Void in
//                            Claw.motor.run(block1)
//            })
//        }
//    }
//    
    }
}
