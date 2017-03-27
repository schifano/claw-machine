import SpriteKit

// TODO: Open claw state
// TODO: Closed claw state
// FIXME: handle collision with glass

struct Actions {
    static let up = SKAction.moveBy(x: 0.0, y: 4.0, duration: 0.1)
    
    static let down = SKAction.moveBy(x: 0.0, y: -4.0, duration: 0.1)
    static let moveDown = SKAction.repeatForever(down)
    
    static let left = SKAction.moveBy(x: -6.0, y: 0.0, duration: 0.1)
    
    static let right = SKAction.moveBy(x: 6.0, y: 0.0, duration: 0.1)
    static let moveRight = SKAction.repeatForever(right)
    
    
    static let wait = SKAction.wait(forDuration: 1.5)
    
    static let leftForce = SKAction.applyForce(leftClawForceVector(), at: leftClawForcePoint(), duration: 1.0)
    static let repeatLeftForce = SKAction.repeatForever(leftForce)
    
    static let rightForce = SKAction.applyForce(rightClawForceVector(), at: rightClawForcePoint(), duration: 1.0)
    static let repeatRightForce = SKAction.repeatForever(rightForce)
    
    static let closeClaw = SKAction.group([repeatLeftForce, repeatRightForce])
    
    
    
    static let openLeftClaw = SKAction.applyForce(rightClawForceVector(), at: leftClawForcePoint(), duration: 1.0)
    static let repeatLeftOpen = SKAction.repeatForever(openLeftClaw)
    static let openRightClaw = SKAction.applyForce(leftClawForceVector(), at: rightClawForcePoint(), duration: 1.0)
    static let repeatRightOpen = SKAction.repeatForever(openRightClaw)
    static let openClaw = SKAction.group([openLeftClaw, openRightClaw])
    
    // Utility methods
    static func leftClawForceVector() -> CGVector {
        // determine vector components and direction
        let dx: CGFloat = 50
        let dy: CGFloat = 0
        // 5 represents scale of force
        let forceVector = CGVector(dx: dx, dy: dy)
        return forceVector
    }
    
    
    static func rightClawForceVector() -> CGVector {
        // determine vector components and direction
        let dx: CGFloat = -50
        let dy: CGFloat = 0
        // 5 represents scale of force
        let forceVector = CGVector(dx: dx, dy: dy)
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
    
    
    
    
    
    // Partial - DOWN
    
    
    
    
    // Closed - UP/LEFT
    
    
    // Open - End of sequence
    
    
    // try an action
    static func closeClaw() {
        // determine vector components and direction
        let dx1: CGFloat = -1000
        let dy: CGFloat = 0
        
        let dx2: CGFloat = 1000
        
        // 5 represents scale of force
        // FIXME: rename
        let forceMovingLeftVector = CGVector(dx: dx1, dy: dy)
        let forceMovingRightVector = CGVector(dx: dx2, dy: dy)
        
        let leftClawPoint = CGPoint(x: Claw.leftClaw.frame.minX, y: Claw.leftClaw.frame.minY)
        let rightClawPoint = CGPoint(x: Claw.rightClaw.frame.minX, y: Claw.rightClaw.frame.minY)
        
        Claw.leftClaw.physicsBody?.applyForce(forceMovingRightVector, at: leftClawPoint)
        Claw.rightClaw.physicsBody?.applyForce(forceMovingLeftVector, at: rightClawPoint)
    }
    
    
    static func openClaw() {
        // determine vector components and direction
        let dx1: CGFloat = -100
        let dy: CGFloat = 0
        
        let dx2: CGFloat = 100
        
        // 5 represents scale of force
        // FIXME: rename
        let forceMovingLeftVector = CGVector(dx: dx1, dy: dy)
        let forceMovingRightVector = CGVector(dx: dx2, dy: dy)
        
        let leftClawPoint = CGPoint(x: Claw.leftClaw.frame.minX, y: Claw.leftClaw.frame.minY)
        let rightClawPoint = CGPoint(x: Claw.rightClaw.frame.minX, y: Claw.rightClaw.frame.minY)
        
        Claw.leftClaw.physicsBody?.applyForce(forceMovingLeftVector, at: leftClawPoint)
        Claw.rightClaw.physicsBody?.applyForce(forceMovingRightVector, at: rightClawPoint)
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
                            
                            
                            
                            Claw.openClaw()

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
                        Claw.closeClaw()
                    }),
                    
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
                            print("contactMade?: \(Collision.contactMade)") // TEST
                            Claw.motor.removeAction(forKey: "moveDown")
                            
                            Claw.motor.run(Actions.wait,
                                           completion: {() -> Void in
                                            
                                            Claw.motor.run(Claw.moveUpBlock)
                            })
                        } else if (Claw.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10) || Collision.contactMade {
                            print("contactMade?: \(Collision.contactMade)") // TEST
                            Claw.motor.removeAction(forKey: "moveDown")
                            Claw.motor.run(Actions.wait,
                                           completion: {() -> Void in
                                            let forceGroup = SKAction.group([Actions.repeatLeftForce, Actions.repeatRightForce, moveUpBlock])
//                                            Claw.motor.run(forceGroup)
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
        // user must wait for claw to return to try again
        Container.button.isUserInteractionEnabled = false
        Claw.motor.run(moveDownBlock)
    }
}
