import SpriteKit

struct Actions {
    static let moveMotorLeft = SKAction.moveBy(x: -100.0, y: 20.0, duration: 2.0)
    static let moveMotorRight = SKAction.moveBy(x: 100.0, y: 0.0, duration: 2.0)
    static let moveMotorDown = SKAction.moveBy(x: 0.0, y: -100.0, duration: 3.0)
    static let wait = SKAction.wait(forDuration: 1.5)
}

struct ClawSprites {
    static let motor = Sprites.createMotorSprite()
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
}
