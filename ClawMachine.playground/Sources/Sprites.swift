import SpriteKit

public struct Category {
    // bitmasks to set collide detection for sprites
    static let clawCategory: UInt32 = 0x1 << 2
    static let contactDetectorCategory: UInt32 =  0x1 << 0
    static let stuffedAnimalCategory: UInt32 =  0x1 << 1
    static let boundaryCategory: UInt32 = 0x1 << 3
}

public class Sprites {
    
    /// Methods used for creating sprites that make up the entire claw
    // Motor
    // TODO: CHECK THE PATH OF THESE IMAGES
    static func createMotorSprite() -> SKSpriteNode {
        let motorTexture = SKTexture(image: UIImage(named: "claw-motor.png")!)
        let motor = SKSpriteNode(texture: motorTexture)
        motor.size = CGSize(width: 28, height: 41)
        motor.position = CGPoint(x: Container.gameWindowShape.frame.minX+65, y: Container.gameWindowShape.frame.maxY-23)
        motor.physicsBody = SKPhysicsBody(texture: motorTexture, size: CGSize(width: 28, height: 41))
        motor.physicsBody?.affectedByGravity = false
        motor.physicsBody?.isDynamic = false
        motor.physicsBody?.collisionBitMask = 0
        
        return motor
    }
    
    // Left claw
    static func createLeftClawSprite() -> SKSpriteNode {
        let motor = Claw.motor
        let leftClawTexture = SKTexture(image: UIImage(named: "claw-left.png")!)
        let leftClaw = SKSpriteNode(texture: leftClawTexture)
        
        leftClaw.size = CGSize(width: 26, height: 47)
        leftClaw.position = CGPoint(x: motor.position.x-22, y: motor.position.y-30)
        
        leftClaw.physicsBody = SKPhysicsBody(texture: leftClawTexture, size: CGSize(width: 26, height: 47))
        leftClaw.physicsBody?.affectedByGravity = true
        leftClaw.physicsBody?.isDynamic = true
        
        leftClaw.physicsBody?.categoryBitMask = Category.clawCategory
        leftClaw.physicsBody?.contactTestBitMask = Category.stuffedAnimalCategory
        leftClaw.physicsBody?.collisionBitMask = Category.stuffedAnimalCategory
        
        return leftClaw
    }
    
    // Right claw
    static func createRightClawSprite() -> SKSpriteNode {
        let motor = Claw.motor
        let rightClawTexture = SKTexture(image: UIImage(named: "claw-right.png")!)
        let rightClaw = SKSpriteNode(texture: rightClawTexture)
        
        rightClaw.size = CGSize(width: 26, height: 47)
        rightClaw.position = CGPoint(x: motor.position.x+22, y: motor.position.y-30)
        
        rightClaw.physicsBody = SKPhysicsBody(texture: rightClawTexture, size: CGSize(width: 26, height: 47))
        rightClaw.physicsBody?.affectedByGravity = true
        rightClaw.physicsBody?.isDynamic = true
        
        rightClaw.physicsBody?.categoryBitMask = Category.clawCategory
        rightClaw.physicsBody?.contactTestBitMask = Category.stuffedAnimalCategory
        rightClaw.physicsBody?.collisionBitMask = Category.stuffedAnimalCategory
        
        return rightClaw
    }
    
    // Contact detector that serves somewhat as a pressure plate
    static func createContactDetectorSprite() -> SKShapeNode {
        let motor = Claw.motor
        let contactDetector = SKShapeNode(rectOf: CGSize(width: motor.frame.width/2+5, height: 5))
        contactDetector.fillColor = UIColor.clear
        contactDetector.position = CGPoint(x: motor.position.x, y: motor.position.y-18)
        contactDetector.name = "detector"
        
        contactDetector.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: contactDetector.frame.width, height: contactDetector.frame.height))
        
        contactDetector.physicsBody?.affectedByGravity = false
        contactDetector.physicsBody?.isDynamic = true
        contactDetector.physicsBody?.allowsRotation = false
        contactDetector.physicsBody?.angularVelocity = 0
        
        contactDetector.physicsBody?.categoryBitMask = Category.contactDetectorCategory
        contactDetector.physicsBody?.contactTestBitMask = Category.stuffedAnimalCategory
        contactDetector.physicsBody?.collisionBitMask = Category.stuffedAnimalCategory
        
        return contactDetector
    }
    
    /// Methods used to create stuffed animal sprites
    public static func createStuffedAnimal(image: UIImage, quantity: Int) {
        let stuffedAnimalSize = CGSize(width: 50, height: 50)
        let stuffedAnimalTexture = SKTexture(image: image)
        for _ in 1 ... quantity {
            let stuffedAnimal = SKSpriteNode(texture: stuffedAnimalTexture)
            stuffedAnimal.zPosition = 0
            // TODO: Can we make this the size of the image?
            stuffedAnimal.size = stuffedAnimalSize
            // FIXME: Generate animals in the correct space
//            stuffedAnimal.position = CGPoint(
//                x: Int(arc4random_uniform(UInt32(151)+150)),
//                y: Int(arc4random_uniform(UInt32(Container.gameWindowShape.frame.maxY)-60)))
            // TODO: make relative to the window
            stuffedAnimal.position = CGPoint(
                x: 250,
                y: 380)
            
            stuffedAnimal.name = "stuffedAnimal"
            
            stuffedAnimal.physicsBody = SKPhysicsBody(texture: stuffedAnimalTexture, size: stuffedAnimalSize)
            stuffedAnimal.physicsBody?.affectedByGravity = true
            stuffedAnimal.physicsBody?.isDynamic = true
            stuffedAnimal.physicsBody?.categoryBitMask = Category.stuffedAnimalCategory
            stuffedAnimal.physicsBody?.contactTestBitMask = Category.contactDetectorCategory
            stuffedAnimal.physicsBody?.collisionBitMask = Category.boundaryCategory | Category.clawCategory
            
            Container.scene.addChild(stuffedAnimal)
        }
    }
}
