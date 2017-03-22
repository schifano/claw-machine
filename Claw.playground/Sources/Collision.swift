import SpriteKit

class Collision: NSObject, SKPhysicsContactDelegate, SKSceneDelegate {
    
    // ContactDelegate method is notified when there has been contact with sprites
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact made")
        
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        if (collision == (Category.contactDetectorCategory | Category.stuffedAnimalCategory)) {
            print("contact with stuffed animal")
//            Claw.pauseMotorAction()
        }
    }
    
    // SceneDelegate method checks scene and makes given updates
    // Method checks for existing springs to remove
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        if Claw.hasReturnedToStart {
            for spring in Joints.springs {
                print("#####SPRING: \(spring)")
                scene.physicsWorld.remove(spring)
                if let index = Joints.springs.index(of: spring) {
                    Joints.springs.remove(at: index)

                    // TODO: Experiment re-add claw
//                    let clawSpringJoint = SKPhysicsJointSpring.joint(withBodyA: leftClaw.physicsBody!, bodyB: rightClaw.physicsBody!, anchorA: CGPoint(x: leftClaw.position.x+25, y: leftClaw.position.y-15), anchorB: CGPoint(x: rightClaw.position.x-25, y: rightClaw.position.y-15))
//                    clawSpringJoint.frequency = 9.0
//                    clawSpringJoint.damping = 1.0
//                    
//                    scene.physicsWorld.add(clawSpringJoint)
                }
            }
        }
    }
    
    // TODO: Add left and right claw springs
    // TODO: Open claw state
    // TODO: Closed claw state
}

