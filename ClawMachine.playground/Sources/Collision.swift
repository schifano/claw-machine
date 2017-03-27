import SpriteKit

class Collision: NSObject, SKPhysicsContactDelegate, SKSceneDelegate {
    
    static var contactMade = false
    
    // ContactDelegate method is notified when there has been contact with sprites
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        if (collision == (Category.contactDetectorCategory | Category.stuffedAnimalCategory)) {
            print("contact with stuffed animal")
            

            Collision.contactMade = true
            
        }
    }
    
    // SceneDelegate method checks scene and makes given updates
    // Method checks for existing springs to remove
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        
        
        if Claw.isOpen {
            print("Claw is open")
            Claw.openClaw()
        } else {
            Claw.closeClaw()
        }
        
        
        
        
        // If contact has been made, close claw
        if Collision.contactMade {
            let forceGroup = SKAction.group([Actions.repeatLeftForce, Actions.repeatRightForce])
            Claw.motor.run(forceGroup)
        }
        
        
        
        
        
//        let degreesInRadians = GLKMathDegreesToRadians(45)
//        // determine vector components and direction
//        let dx = cosf(degreesInRadians)
//        let dy = sinf(degreesInRadians)
//        // 5 represents scale of force
//        let forceVector = CGVector(dx: CGFloat(dx*500), dy: CGFloat(dy*500))
//        let leftClawPoint = CGPoint(x: Claw.leftClaw.position.x, y: Claw.leftClaw.position.y)
//        
//        
//        let rightClawPoint = CGPoint(x: Claw.rightClaw.position.x, y: Claw.rightClaw.position.y)
//        
//        Claw.leftClaw.physicsBody?.applyForce(forceVector, at: leftClawPoint)
//        Claw.rightClaw.physicsBody?.applyForce(forceVector, at: rightClawPoint)
        
        
        
        //        Claw.applyForceToOpen()
//        Claw.motor.run(Actions.repeatLeftForce)

        
//        if Button.isBeingHeld == 1 {
//            Claw.moveClawRight()
//        } else if Button.isBeingHeld == 0 {
//            Claw.moveClawDown()
//            Claw.returnClawHome()
//            Button.isBeingHeld = 2
//        }
        
//        if Claw.hasReturnedToStart {
//            Claw.applyForceToOpen(leftClaw: ClawSprites.leftClaw, rightClaw: ClawSprites.rightClaw)
//        }
        
        // FIXME: May need this if I need to re-apply the spring later
//        if Claw.hasReturnedToStart {
//            for spring in Joints.springs {
//                print("#####SPRING: \(spring)")
//                scene.physicsWorld.remove(spring)
//                if let index = Joints.springs.index(of: spring) {
//                    Joints.springs.remove(at: index)
//                    
//                    
//                }
//            }
//        }
    }
    
//    static func contact(hasMadeContact: Bool) -> Bool {
//        return hasMadeContact
//    }
}
