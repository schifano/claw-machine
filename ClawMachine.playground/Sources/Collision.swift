import SpriteKit

class Collision: NSObject, SKPhysicsContactDelegate, SKSceneDelegate {
    
    static var contactMade = false
    
    static var counter = 0
    // ContactDelegate method is notified when there has been contact with sprites
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        if (collision == (Category.contactDetectorCategory | Category.stuffedAnimalCategory)) {
            print("contact with stuffed animal")
//            Collision.contactMade = true
            
            if Collision.counter == 0 {
                Collision.counter+=1
                Collision.contactMade = true
            }
        }
    }
    
    // SceneDelegate method checks scene and makes given updates
    // Method checks for existing springs to remove
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        

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
