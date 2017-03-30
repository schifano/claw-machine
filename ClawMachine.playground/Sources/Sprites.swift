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
    static func createMotorSprite() -> SKSpriteNode {
        let motorTexture = SKTexture(image: UIImage(named: "claw-motor.png")!)
        let motor = SKSpriteNode(texture: motorTexture)
        motor.size = CGSize(width: 28, height: 41)
        motor.position = CGPoint(x: ClawMachine.gameWindowShape.frame.minX+65, y: ClawMachine.gameWindowShape.frame.maxY-25)
        motor.physicsBody = SKPhysicsBody(texture: motorTexture, size: CGSize(width: 28, height: 41))
        motor.physicsBody?.affectedByGravity = false
        motor.physicsBody?.isDynamic = false
        motor.physicsBody?.collisionBitMask = 0
        
        return motor
    }

    // Bar
    static func createBarSprite() -> SKSpriteNode {
        let motor = Claw.motor
        let barTexture = SKTexture(image: UIImage(named: "claw-bar.png")!)
        let bar = SKSpriteNode(texture: barTexture)
        bar.size = CGSize(width: 10, height: 100)
        bar.position = CGPoint(x: motor.frame.midX, y: motor.frame.maxY+50)
        bar.physicsBody = SKPhysicsBody(texture: barTexture, size: CGSize(width: 10, height: 100))
        bar.physicsBody?.affectedByGravity = false
        bar.physicsBody?.isDynamic = true
        bar.physicsBody?.collisionBitMask = 0
        bar.physicsBody?.categoryBitMask = Category.clawCategory
        return bar
    }
    
    // Left claw
    static func createLeftClawSprite() -> SKSpriteNode {
        let motor = Claw.motor
        let leftClawTexture = SKTexture(image: UIImage(named: "claw-left2.png")!)
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
        let rightClawTexture = SKTexture(image: UIImage(named: "claw-right2.png")!)
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
        contactDetector.lineWidth = 0.0
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
    
    // Methods used to generate random values for x and y components
    static let minX: Int = Int(ClawMachine.prizeShootShape.frame.maxX)+10
    static let maxX: Int = Int(ClawMachine.gameWindowShape.frame.maxX)-20
    
    static let minY: Int = Int(ClawMachine.gameWindowShape.frame.minY)+20
    static let maxY: Int = Int(ClawMachine.gameWindowShape.frame.maxY)-20
    
    static func randomNumberX(range: ClosedRange<Int> = minX...maxX) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    
    static func randomNumberY(range: ClosedRange<Int> = minY...maxY) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    
    /// Methods used to create stuffed animal sprites
    public static func createStuffedAnimal(image: UIImage, quantity: Int) {
        let stuffedAnimalSize = CGSize(width: image.size.width/2, height: image.size.height/2)
        let stuffedAnimalTexture = SKTexture(image: image)
        for _ in 1 ... quantity {
            let stuffedAnimal = SKSpriteNode(texture: stuffedAnimalTexture)
            stuffedAnimal.size = stuffedAnimalSize
            
            let point = CGPoint(
                x: randomNumberX(),
                y: randomNumberY())
            stuffedAnimal.position = point
            
            stuffedAnimal.name = "stuffedAnimal"
            
            stuffedAnimal.physicsBody = SKPhysicsBody(texture: stuffedAnimalTexture, size: stuffedAnimalSize)
            stuffedAnimal.physicsBody?.affectedByGravity = true
            stuffedAnimal.physicsBody?.isDynamic = true
            stuffedAnimal.physicsBody?.categoryBitMask = Category.stuffedAnimalCategory
            stuffedAnimal.physicsBody?.contactTestBitMask = Category.contactDetectorCategory
            stuffedAnimal.physicsBody?.collisionBitMask = Category.boundaryCategory | Category.clawCategory
            
            ClawMachine.scene.addChild(stuffedAnimal)
        }
    }
}
