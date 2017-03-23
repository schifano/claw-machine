import SpriteKit

struct Joints {
    
    static var springs = [SKPhysicsJointSpring]()
    
    static func createLeftClawJoint(motor: SKSpriteNode, leftClaw: SKSpriteNode) -> SKPhysicsJointPin {
        let leftClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: leftClaw.physicsBody!, anchor: CGPoint(x: leftClaw.frame.maxX, y: motor.frame.minY))
        leftClawJoint.shouldEnableLimits = true
        leftClawJoint.upperAngleLimit = CGFloat(GLKMathDegreesToRadians(0)) // change 0 to 5 for a shakier claw
        leftClawJoint.lowerAngleLimit = CGFloat(GLKMathDegreesToRadians(-45))
        return leftClawJoint
    }
    
    static func createRightClawJoint(motor: SKSpriteNode, rightClaw: SKSpriteNode) -> SKPhysicsJointPin {
        let rightClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: rightClaw.physicsBody!,
                                                     anchor: CGPoint(x: rightClaw.frame.minX, y: motor.frame.minY))
        rightClawJoint.shouldEnableLimits = true
        rightClawJoint.upperAngleLimit = CGFloat(GLKMathDegreesToRadians(45))
        rightClawJoint.lowerAngleLimit = CGFloat(GLKMathDegreesToRadians(0))
        return rightClawJoint
        
    }
    
    static func createClawSpringJoint(leftClaw: SKSpriteNode, rightClaw: SKSpriteNode) -> SKPhysicsJointSpring {
        let clawSpringJoint = SKPhysicsJointSpring.joint(withBodyA: leftClaw.physicsBody!, bodyB: rightClaw.physicsBody!, anchorA: CGPoint(x: leftClaw.position.x+25, y: leftClaw.position.y-15), anchorB: CGPoint(x: rightClaw.position.x-25, y: rightClaw.position.y-15))
        clawSpringJoint.frequency = 9.0
        clawSpringJoint.damping = 1.0
        springs.append(clawSpringJoint) // used to track added springs
        return clawSpringJoint
    }
    
    static func createContactDetectorJoint(motor: SKSpriteNode, contactDetector: SKShapeNode) -> SKPhysicsJointPin {
        let contactDetectorJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: contactDetector.physicsBody!, anchor: CGPoint(x: motor.position.x, y: motor.position.y))
        return contactDetectorJoint
    }
    
    static func createBarJoint(motor: SKSpriteNode, bar: SKShapeNode) -> SKPhysicsJoint {
        let barJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: bar.physicsBody!, anchor: CGPoint(x: motor.position.x, y: motor.position.y))
        return barJoint
    }
    
    // Joints used on outside of claws
    static func createLeftSpringJoint(leftClaw: SKSpriteNode, bar: SKShapeNode) -> SKPhysicsJointSpring {
        let leftSpringJoint = SKPhysicsJointSpring.joint(withBodyA: leftClaw.physicsBody!, bodyB: bar.physicsBody!,
            anchorA: CGPoint(x: leftClaw.frame.minX, y: leftClaw.frame.maxY),
            anchorB: CGPoint(x: bar.frame.minX, y: bar.frame.minY))
        
        leftSpringJoint.frequency = 9.0
        leftSpringJoint.damping = 1.0
        
        return leftSpringJoint
    }
    
    static func createRightSpringJoint(rightClaw: SKSpriteNode, bar: SKShapeNode) -> SKPhysicsJointSpring {
        let rightSpringJoint = SKPhysicsJointSpring.joint(withBodyA: rightClaw.physicsBody!, bodyB: bar.physicsBody!,
            anchorA: CGPoint(x: rightClaw.frame.maxX, y: rightClaw.frame.maxY),
            anchorB: CGPoint(x: bar.frame.maxX, y: bar.frame.minY))
        
        rightSpringJoint.frequency = 9.0
        rightSpringJoint.damping = 1.0
        
        return rightSpringJoint
    }
}
