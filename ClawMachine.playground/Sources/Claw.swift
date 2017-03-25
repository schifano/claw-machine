import SpriteKit

struct Actions {
    static let moveMotorLeft = SKAction.moveBy(x: -100.0, y: 20.0, duration: 2.0)
    static let moveMotorRight = SKAction.moveBy(x: 100.0, y: 0.0, duration: 2.0)
    static let moveMotorDown = SKAction.moveBy(x: 0.0, y: -100.0, duration: 3.0)
    static let wait = SKAction.wait(forDuration: 1.5)
}

struct Directions {
    
}


public struct ClawSprites {
    public static let motor = Sprites.createMotorSprite()
    static let leftClaw = Sprites.createLeftClawSprite()
    static let rightClaw = Sprites.createRightClawSprite()
    static let contactDetector = Sprites.createContactDetectorSprite()
}

public class Claw {
    
    public static var hasReturnedToStart = false
    
    public static func pauseMotorAction() {
        ClawSprites.motor.removeAllActions()
        
        let sequence = SKAction.sequence([Actions.wait, Actions.moveMotorDown.reversed()])
        ClawSprites.motor.run(sequence)
        
        hasReturnedToStart = true
    }
    
    public static func moveClaw(motor: SKSpriteNode) {
        let sequence = SKAction.sequence([Actions.moveMotorRight, Actions.moveMotorDown, Actions.wait, Actions.moveMotorDown.reversed(), Actions.moveMotorRight.reversed()])
        motor.run(sequence)
    }
    
    
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
    
    static var trackedActions = [SKAction]()
    
    
    /// Method that continually moves claw right if button is held down
    static let right = SKAction.moveBy(x: 4.0, y: 0.0, duration: 0.1)
    static let moveRight = SKAction.repeatForever(right)
    
    static func moveClawRight() {
        if ClawSprites.motor.position.x < Container.gameWindowShape.frame.maxX-60 && ClawSprites.motor.position.x > Container.gameWindowShape.frame.minX {
            ClawSprites.motor.run(moveRight)
        }
    }
    
    
    static let left = SKAction.moveBy(x: -4.0, y: 0.0, duration: 0.1)
    static let moveLeft = SKAction.repeatForever(left)
    
    static func moveClawLeft() {
        print("left")
        if ClawSprites.motor.position.x > Container.gameWindowShape.frame.minX+100 {
            ClawSprites.motor.run(moveLeft)
        }
    }
    
    
//    trackedActions.append(moveRight)
    
    /// Method that moves the claw down
    static let down = SKAction.moveBy(x: 0.0, y: -4.0, duration: 0.1)
//    static let moveDown = SKAction.repeatForever(down)
    
    
    // FIXME: handle collision with glass
    
    static func moveClawDown() {
        print("down")

        ClawSprites.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    down,
                    SKAction.run({
                        //Code you want to execute
                        if ClawSprites.motor.frame.minY <= Container.gameWindowShape.frame.minY+30 {
                            ClawSprites.motor.removeAction(forKey: "moveDown")
                        }
                    })
                ])
            ),
            withKey: "moveDown"
        )
    }
    
    static let up = SKAction.moveBy(x: 0.0, y: 4.0, duration: 0.1)
    static let moveUp = SKAction.repeatForever(up)
    static func moveClawUp() {
        print("up")
        
        ClawSprites.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    up,
                    SKAction.run({
                        //Code you want to execute
                        if ClawSprites.motor.frame.maxY >= Container.gameWindowShape.frame.maxY-30 {
                            ClawSprites.motor.removeAction(forKey: "moveUp")
                        }
                    })
                    ])
            ),
            withKey: "moveUp"
        )
        
        moveClawLeft()
    }

    
    
    static var counter = 0
    static func removeClawActions(contactMadeWithStuffedAnimal: Bool) {
        if contactMadeWithStuffedAnimal {
            closeClaw()
            returnClawHome()
        } else {
            ClawSprites.motor.removeAllActions()
        }
    }
    
    
    // this may need to be done by moving claw until it returns home
    static func returnClawHome() {
        print("return claw home")
        moveClawUp()
        
//        let sequence = SKAction.sequence(trackedActions)
//        ClawSprites.motor.run(sequence.reversed())
//        applyForceToOpen(leftClaw: ClawSprites.leftClaw, rightClaw: ClawSprites.rightClaw)
    }
    
    
    static func closeClaw() {
        
    }
    
}
