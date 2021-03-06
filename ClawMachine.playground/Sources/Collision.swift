import SpriteKit

class Collision: NSObject, SKPhysicsContactDelegate, SKSceneDelegate {
    
    static var contactMade = false
    
    // ContactDelegate method is notified when there has been contact with sprites
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        
        if (collision == (Category.contactDetectorCategory | Category.stuffedAnimalCategory)) {
//            print("contact with stuffed animal") // DEBUG
            Collision.contactMade = true
        }
    }
    
    // SceneDelegate method checks scene and makes given updates
    // Method checks for existing springs to remove
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        
        // apply constant force to keep claw open
        // reverse force to keep it closed
        if Claw.isOpen {
//            print("Claw is open")
            Claw.openClaw()
        } else {
            Claw.closeClaw()
        }
        
        // audio playback when user is pressing the button or the claw is returning
        if Button.buttonIsPressed || Claw.isReturning {
            Sounds.playMelody()
        } else {
            Sounds.pauseMelody()
        }
    }
}
