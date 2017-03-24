import SpriteKit
import PlaygroundSupport

public class Setup {
    
    static let physicsContainerView = SKView(frame: CGRect(x: 20, y: 90, width: 392, height: 200))
    static let scene = SKScene(size: CGSize(width: 392, height: 200))
    static let delegate = Collision()
    
    public static func clawMachine() {
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        physicsContainerView.showsPhysics = true
        physicsContainerView.showsFields = true
        
        scene.backgroundColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0) // pale robin egg blue: #98E3D4
        scene.scaleMode = SKSceneScaleMode.aspectFit
        
        // Add boundary physics body for entire scene
        // TODO: Change this to the path in original project
        let boundary = SKPhysicsBody(edgeLoopFrom: scene.frame)
        boundary.categoryBitMask = Category.groundCategory
        scene.physicsBody = boundary
        
        // SETUP claw
//        let motor = Sprites.createMotorSprite()
//        let leftClaw = Sprites.createLeftClawSprite(motor: motor)
//        let rightClaw = Sprites.createRightClawSprite(motor: motor)
//        let contactDetector = Sprites.createContactDetectorSprite(motor: motor)
//        let bar = Sprites.createBarSprite(motor: motor)
        
        // add sprites to scene before joints
        scene.addChild(ClawSprites.motor)
        scene.addChild(ClawSprites.leftClaw)
        scene.addChild(ClawSprites.rightClaw)
        scene.addChild(ClawSprites.contactDetector)
        scene.addChild(ClawSprites.bar)
        
        
        // SETUP joints
        let leftClawJoint = Joints.createLeftClawJoint(motor: ClawSprites.motor, leftClaw: ClawSprites.leftClaw)
        let rightClawJoint = Joints.createRightClawJoint(motor: ClawSprites.motor, rightClaw: ClawSprites.rightClaw)
        let contactDetectorJoint = Joints.createContactDetectorJoint(motor: ClawSprites.motor, contactDetector: ClawSprites.contactDetector)
        let clawSpringJoint = Joints.createClawSpringJoint(leftClaw: ClawSprites.leftClaw, rightClaw: ClawSprites.rightClaw)
        let barJoint = Joints.createBarJoint(motor: ClawSprites.motor, bar: ClawSprites.bar)
        
        let leftSpringJoint = Joints.createLeftSpringJoint(leftClaw: ClawSprites.leftClaw, bar: ClawSprites.bar)
        let rightSpringJoint = Joints.createRightSpringJoint(rightClaw: ClawSprites.rightClaw, bar: ClawSprites.bar)
        
        scene.physicsWorld.add(leftClawJoint)
        scene.physicsWorld.add(rightClawJoint)
        scene.physicsWorld.add(contactDetectorJoint)
//        scene.physicsWorld.add(clawSpringJoint)
        scene.physicsWorld.add(barJoint)
        
        scene.physicsWorld.add(leftSpringJoint)
        scene.physicsWorld.add(rightSpringJoint)
        
        // the delegate must be owned by something
        // setting contactDelegate = Collision() will not work without first creating a variable
        scene.physicsWorld.contactDelegate = delegate
        scene.delegate = delegate
        
        physicsContainerView.presentScene(scene)
        
        PlaygroundPage.current.liveView = physicsContainerView
        PlaygroundPage.current.needsIndefiniteExecution = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Initiate movement
        Claw.moveClaw(motor: ClawSprites.motor)
    }
}
