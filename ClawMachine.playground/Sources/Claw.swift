import SpriteKit

struct Actions {
    static let up = SKAction.moveBy(x: 0.0, y: 4.0, duration: 0.1)
    
    static let down = SKAction.moveBy(x: 0.0, y: -4.0, duration: 0.1)
    static let moveDown = SKAction.repeatForever(down)
    
    static let left = SKAction.moveBy(x: -6.0, y: 0.0, duration: 0.1)
    
    static let right = SKAction.moveBy(x: 6.0, y: 0.0, duration: 0.1)
    static let moveRight = SKAction.repeatForever(right)
    
    static let wait = SKAction.wait(forDuration: 1.5)
}

public class Claw {
    static let motor = Sprites.createMotorSprite()
    static let bar = Sprites.createBarSprite()
    static let leftClaw = Sprites.createLeftClawSprite()
    static let rightClaw = Sprites.createRightClawSprite()
    static let contactDetector = Sprites.createContactDetectorSprite()

    static var isOpen = true
    
    public static var openStrength = 70
    public static var closeStrength = 100
    
    
    /// Method applies force to close claw
    public static func closeClaw() {
        // determine vector components and direction
        let dx1: Int = -(closeStrength)
        let dx2: Int = -dx1

        // left is a negative force, right is positive on a coord system
        let forceMovingLeftVector = CGVector(dx: dx1, dy: 0)
        let forceMovingRightVector = CGVector(dx: dx2, dy: 0)
        
        let leftClawPoint = CGPoint(x: Claw.leftClaw.frame.minX, y: Claw.leftClaw.frame.minY)
        let rightClawPoint = CGPoint(x: Claw.rightClaw.frame.maxX, y: Claw.rightClaw.frame.minY)
        
        Claw.leftClaw.physicsBody?.applyForce(forceMovingRightVector, at: leftClawPoint)
        Claw.rightClaw.physicsBody?.applyForce(forceMovingLeftVector, at: rightClawPoint)
    }
    
    /// Method applies force to open claw
    public static func openClaw() {
        // determine vector components and direction
        let dx1: Int = -(openStrength)
        let dx2: Int = -dx1
        
        // left is a negative force, right is positive on a coord system
        let forceMovingLeftVector = CGVector(dx: dx1, dy: 0)
        let forceMovingRightVector = CGVector(dx: dx2, dy: 0)
        
        let leftClawPoint = CGPoint(x: Claw.leftClaw.frame.minX, y: Claw.leftClaw.frame.minY)
        let rightClawPoint = CGPoint(x: Claw.rightClaw.frame.minX, y: Claw.rightClaw.frame.minY)
        
        Claw.leftClaw.physicsBody?.applyForce(forceMovingLeftVector, at: leftClawPoint)
        Claw.rightClaw.physicsBody?.applyForce(forceMovingRightVector, at: rightClawPoint)
    }
    
    // MARK: Claw movement code blocks
    /// Move Left
    static let moveLeftBlock = SKAction.run({
        
        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    SKAction.run({
                        if Claw.leftClaw.frame.maxX <= ClawMachine.gameWindowShape.frame.minX+75 {
                            
                            print("moved left")

                            Claw.motor.removeAction(forKey: "moveLeft")
                            
                            Claw.isOpen = true

                            ClawMachine.button.isUserInteractionEnabled = true
                            Collision.contactMade = false // reset
                        }
                    }),
                    Actions.left
                    ])
            ),
            withKey: "moveLeft"
        )
        
    })
    
    /// Move Up
    static let moveUpBlock = SKAction.run({
        
        Claw.motor.run(
            SKAction.sequence([
                SKAction.run {
                    Claw.isOpen = false
                },
                SKAction.wait(forDuration: 1.0),
                
                SKAction.repeatForever (
                    SKAction.sequence([
                        SKAction.run({
                            Claw.isOpen = false
                        }),
                        
                        SKAction.run({
                            if Claw.motor.frame.maxY >= ClawMachine.gameWindowShape.frame.maxY-7 {
                                print("made it up")
                                Claw.motor.run(Claw.moveLeftBlock)
                                Claw.motor.removeAction(forKey: "moveUp")
                            }
                        }),
                        
                        Actions.up
                        ])
                )]
            ),
            withKey: "moveUp"
        )
        
    })
    
    /// Move down - moves claw down continuously until a collision occurs
    static let moveDownBlock = SKAction.run({
        
        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    SKAction.run({
                        
                        if (Claw.leftClaw.frame.minY <= ClawMachine.gameWindowShape.frame.minY+10) || Collision.contactMade {
                            print("contactMade?: \(Collision.contactMade)") // TEST
                            Claw.motor.removeAction(forKey: "moveDown")
                            
                            Claw.motor.run(Actions.wait,
                                           completion: {() -> Void in
                                            
                                            Claw.motor.run(Claw.moveUpBlock)
                            })
                        } else if (Claw.rightClaw.frame.minY <= ClawMachine.gameWindowShape.frame.minY+10) || Collision.contactMade {
                            print("contactMade?: \(Collision.contactMade)") // TEST
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
    
    
    /// Method moves claw right continuously until the button is released
    static let moveRightBlock = SKAction.run({
        Claw.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    
                    // first action - check logic
                    SKAction.run({
                        if Claw.rightClaw.frame.maxX >= ClawMachine.gameWindowShape.frame.maxX-10 {
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
    
    /// Method that handles claw sequence to return home
    static func returnClawHome() {
        print("return claw home")
        
        // user must wait for claw to return to try again
        ClawMachine.button.isUserInteractionEnabled = false
        Claw.motor.run(moveDownBlock)
    }
}
