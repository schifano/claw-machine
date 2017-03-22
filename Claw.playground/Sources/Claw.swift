import SpriteKit

struct Actions {
    static let moveMotorLeft = SKAction.moveBy(x: -100.0, y: 20.0, duration: 2.0)
    static let moveMotorRight = SKAction.moveBy(x: 100.0, y: 0.0, duration: 2.0)
    static let moveMotorDown = SKAction.moveBy(x: 0.0, y: -100.0, duration: 3.0)
    static let wait = SKAction.wait(forDuration: 1.5)
}

public class Claw {
    
    public static var hasReturnedToStart = false

    public static func pauseMotor(motor: SKSpriteNode) {
        motor.removeAllActions()
        
        let sequence = SKAction.sequence([Actions.wait, Actions.moveMotorDown.reversed()])
        motor.run(sequence)
        
        hasReturnedToStart = true
    }
    
    func moveClaw(motor: SKSpriteNode) {
        let sequence = SKAction.sequence([Actions.moveMotorRight, Actions.moveMotorDown, Actions.wait, Actions.moveMotorDown.reversed(), Actions.moveMotorRight.reversed()])
        motor.run(sequence)
    }
}
