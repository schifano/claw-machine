import SpriteKit
import PlaygroundSupport

public class Setup {
    
    static let physicsContainerView = SKView(frame: CGRect(x: 20, y: 90, width: 392, height: 200))
    static let scene = SKScene(size: CGSize(width: 392, height: 200))
    
    public static func setupContainer() {
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        physicsContainerView.showsPhysics = true
        physicsContainerView.showsFields = true
        
        scene.backgroundColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0) // pale robin egg blue: #98E3D4
        scene.scaleMode = SKSceneScaleMode.aspectFit
        
        physicsContainerView.presentScene(scene)
        
        PlaygroundPage.current.liveView = physicsContainerView
        PlaygroundPage.current.needsIndefiniteExecution = true
        
        
        // Add boundary physics body for entire scene
        // TODO: Change this to the path in original project
        let boundary = SKPhysicsBody(edgeLoopFrom: scene.frame)
        boundary.categoryBitMask = Category.groundCategory
        scene.physicsBody = boundary
        
        // SETUP claw
        let motor = Sprites.createMotorSprite()
        let leftClaw = Sprites.createLeftClawSprite(motor: motor)
        let rightClaw = Sprites.createRightClawSprite(motor: motor)
        let contactDetector = Sprites.createContactDetectorSprite(motor: motor)
        // add sprites to scene before joints
        scene.addChild(motor)
        scene.addChild(leftClaw)
        scene.addChild(rightClaw)
        scene.addChild(contactDetector)
        
        // SETUP joints
        let leftClawJoint = Joints.createLeftClawJoint(motor: motor, leftClaw: leftClaw)
        let rightClawJoint = Joints.createRightClawJoint(motor: motor, rightClaw: rightClaw)
        let contactDetectorJoint = Joints.createContactDetectorJoint(motor: motor, contactDetector: contactDetector)
        let clawSpringJoint = Joints.createClawSpringJoint(leftClaw: leftClaw, rightClaw: rightClaw)
        scene.physicsWorld.add(leftClawJoint)
        scene.physicsWorld.add(rightClawJoint)
        scene.physicsWorld.add(contactDetectorJoint)
        scene.physicsWorld.add(clawSpringJoint)
        
        // the delegate must be owned by something
        // setting contactDelegate = Collision() will not work without first creating a variable
        let delegate = Collision()
        scene.physicsWorld.contactDelegate = delegate
        scene.delegate = delegate
        
        // Initiate movement
        Claw.moveClaw(motor: motor)
    }
}
