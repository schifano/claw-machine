import SpriteKit

struct Joints {
    
    static var springs = [SKPhysicsJointSpring]()
    
    static func createLeftClawJoint(motor: SKSpriteNode, leftClaw: SKSpriteNode) -> SKPhysicsJointPin {
        let leftClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: leftClaw.physicsBody!, anchor: CGPoint(x: leftClaw.frame.maxX, y: motor.frame.minY))

        
        leftClawJoint.shouldEnableLimits = true
        leftClawJoint.upperAngleLimit = CGFloat(GLKMathDegreesToRadians(10)) // change 0 to 5 for a shakier claw
        leftClawJoint.lowerAngleLimit = CGFloat(GLKMathDegreesToRadians(-45))
        
        
        
        return leftClawJoint
    }
    
    static func createRightClawJoint(motor: SKSpriteNode, rightClaw: SKSpriteNode) -> SKPhysicsJointPin {
        let rightClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: rightClaw.physicsBody!,
                                                     anchor: CGPoint(x: rightClaw.frame.minX, y: motor.frame.minY))
        rightClawJoint.shouldEnableLimits = true
        rightClawJoint.upperAngleLimit = CGFloat(GLKMathDegreesToRadians(45))
        rightClawJoint.lowerAngleLimit = CGFloat(GLKMathDegreesToRadians(-10))
        return rightClawJoint
        
    }
    
    static func createClawSpringJoint(leftClaw: SKSpriteNode, rightClaw: SKSpriteNode) -> SKPhysicsJointSpring {
        let clawSpringJoint = SKPhysicsJointSpring.joint(withBodyA: leftClaw.physicsBody!, bodyB: rightClaw.physicsBody!, anchorA: CGPoint(x: leftClaw.position.x+25, y: leftClaw.position.y-15), anchorB: CGPoint(x: rightClaw.position.x-25, y: rightClaw.position.y-15))
        clawSpringJoint.frequency = 5.0
//        clawSpringJoint.damping = 9.0
        springs.append(clawSpringJoint) // used to track added springs
        return clawSpringJoint
    }
    
    static func createContactDetectorJoint(motor: SKSpriteNode, contactDetector: SKShapeNode) -> SKPhysicsJointPin {
        let contactDetectorJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: contactDetector.physicsBody!, anchor: CGPoint(x: motor.position.x, y: motor.position.y))
        return contactDetectorJoint
    }
}
