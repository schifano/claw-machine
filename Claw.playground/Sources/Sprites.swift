import SpriteKit

public struct Category {
    // bitmasks to set collide detection for sprites
    static let clawCategory: UInt32 = 0x1 << 2
    static let contactDetectorCategory: UInt32 =  0x1 << 0
    static let stuffedAnimalCategory: UInt32 =  0x1 << 1
    static let groundCategory: UInt32 = 0x1 << 3
}

public class Sprites {
    
    /// Methods used for creating sprites that make up the entire claw
    // Motor
    static func createMotorSprite() -> SKSpriteNode {
        let motorTexture = SKTexture(image: UIImage(named: "/Users/schifano/claw-machine/Claw.playground/Resources/claw-motor.png")!)
        let motor = SKSpriteNode(texture: motorTexture)
        motor.size = CGSize(width: 28, height: 41)
        motor.position = CGPoint(x: 100, y: 150)
        motor.physicsBody = SKPhysicsBody(texture: motorTexture, size: CGSize(width: 28, height: 41))
        motor.physicsBody?.affectedByGravity = false
        motor.physicsBody?.isDynamic = false
        motor.physicsBody?.collisionBitMask = 0
        
        return motor
    }
    
    // Left claw
    static func createLeftClawSprite(motor: SKSpriteNode) -> SKSpriteNode {
        let leftClawTexture = SKTexture(image: UIImage(named: "/Users/schifano/claw-machine/Claw.playground/Resources/claw-left.png")!)
        let leftClaw = SKSpriteNode(texture: leftClawTexture)
        
        leftClaw.size = CGSize(width: 26, height: 47)
        leftClaw.position = CGPoint(x: motor.position.x-22, y: motor.position.y-30)
        
        leftClaw.physicsBody = SKPhysicsBody(texture: leftClawTexture, size: CGSize(width: 26, height: 47))
        leftClaw.physicsBody?.affectedByGravity = true
        leftClaw.physicsBody?.isDynamic = true
        
        leftClaw.physicsBody?.categoryBitMask = Category.clawCategory
        leftClaw.physicsBody?.contactTestBitMask = Category.stuffedAnimalCategory
        leftClaw.physicsBody?.collisionBitMask = Category.stuffedAnimalCategory | Category.groundCategory
        
        return leftClaw
    }
    
    // Right claw
    static func createRightClawSprite(motor: SKSpriteNode) -> SKSpriteNode {
        let rightClawTexture = SKTexture(image: UIImage(named: "/Users/schifano/claw-machine/Claw.playground/Resources/claw-right.png")!)
        let rightClaw = SKSpriteNode(texture: rightClawTexture)
        
        rightClaw.size = CGSize(width: 26, height: 47)
        rightClaw.position = CGPoint(x: motor.position.x+22, y: motor.position.y-30)
        
        rightClaw.physicsBody = SKPhysicsBody(texture: rightClawTexture, size: CGSize(width: 26, height: 47))
        rightClaw.physicsBody?.affectedByGravity = true
        rightClaw.physicsBody?.isDynamic = true
        
        rightClaw.physicsBody?.categoryBitMask = Category.clawCategory
        rightClaw.physicsBody?.contactTestBitMask = Category.stuffedAnimalCategory
        rightClaw.physicsBody?.collisionBitMask = Category.stuffedAnimalCategory | Category.groundCategory
        
        return rightClaw
    }
    
    // Contact detector that serves somewhat as a pressure plate
    static func createContactDetectorSprite(motor: SKSpriteNode) -> SKShapeNode {
        let contactDetector = SKShapeNode(rectOf: CGSize(width: motor.frame.width/2+5, height: 5))
        contactDetector.fillColor = UIColor.clear
        contactDetector.position = CGPoint(x: motor.position.x, y: motor.position.y-20)
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
    
    // Invisible bar used to mount two springs to open the claws
    static func createBarSprite(motor: SKSpriteNode) -> SKShapeNode {
        let barSize = CGSize(width: 100, height: 5)
        let bar = SKShapeNode(rectOf: barSize) // test size
        bar.fillColor = UIColor.purple
        bar.position = CGPoint(x: motor.position.x, y: motor.position.y+20)
        bar.name = "bar"
        
        bar.physicsBody = SKPhysicsBody(rectangleOf: barSize)
        bar.physicsBody?.affectedByGravity = false
        bar.physicsBody?.isDynamic = true
        bar.physicsBody?.allowsRotation = false
        bar.physicsBody?.angularVelocity = 0
        
        return bar
    }
    
    
    /// Methods used to create stuffed animal sprites
    public static func createStuffedAnimal(image: UIImage, quantity: Int) {
        let stuffedAnimalSize = CGSize(width: 60, height: 60)
        let stuffedAnimalTexture = SKTexture(image: image)
        for _ in 1 ... quantity {
            let stuffedAnimal = SKSpriteNode(texture: stuffedAnimalTexture)
            // TODO: Can we make this the size of the image?
            stuffedAnimal.size = stuffedAnimalSize
            // FIXME: Generate animals in the correct space
            stuffedAnimal.position = CGPoint(
                x: Int(arc4random_uniform(300)),
                y: Int(arc4random_uniform(50)))
            stuffedAnimal.name = "stuffedAnimal"
            
            stuffedAnimal.physicsBody = SKPhysicsBody(texture: stuffedAnimalTexture, size: stuffedAnimalSize)
            stuffedAnimal.physicsBody?.affectedByGravity = true
            stuffedAnimal.physicsBody?.isDynamic = true
            stuffedAnimal.physicsBody?.categoryBitMask = Category.stuffedAnimalCategory
            stuffedAnimal.physicsBody?.contactTestBitMask = Category.contactDetectorCategory
            stuffedAnimal.physicsBody?.collisionBitMask = Category.groundCategory | Category.clawCategory
            
            Setup.scene.addChild(stuffedAnimal)
        }
    }
}
