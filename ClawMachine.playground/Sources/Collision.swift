import SpriteKit

class Collision: NSObject, SKPhysicsContactDelegate, SKSceneDelegate {
    
    // ContactDelegate method is notified when there has been contact with sprites
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact made")
        
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        if (collision == (Category.contactDetectorCategory | Category.stuffedAnimalCategory)) {
            print("contact with stuffed animal")
            Claw.pauseMotorAction()
        }
    }
    
    // SceneDelegate method checks scene and makes given updates
    // Method checks for existing springs to remove
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        
        if Button.isBeingHeld == 1 {
            Claw.moveClawRight()
        } else if Button.isBeingHeld == 0 {
            Claw.moveClawDown()
            Claw.returnClawHome()
            Button.isBeingHeld = 2
        }
        
//        if Claw.hasReturnedToStart {
//            Claw.applyForceToOpen(leftClaw: ClawSprites.leftClaw, rightClaw: ClawSprites.rightClaw)
//        }
        
        if Claw.hasReturnedToStart {
            for spring in Joints.springs {
                print("#####SPRING: \(spring)")
                scene.physicsWorld.remove(spring)
                if let index = Joints.springs.index(of: spring) {
                    Joints.springs.remove(at: index)
                    
                    
                }
            }
        }
    }
    
    
    // TODO: Add left and right claw springs
    // TODO: Open claw state
    // TODO: Closed claw state
}
