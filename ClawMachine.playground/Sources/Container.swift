import UIKit
import SpriteKit
import PlaygroundSupport

// TODO: Add gamePanel
// TODO: consider making a blurry transparent background for window effect

public class Container {
    
    struct Colors {
        static let cyan = color(for: 0x98E3D4)  // soft cyan
        static let magenta = color(for: 0xd498e3)   // soft magenta
        static let gray = UIColor.gray
        
        /// Precede each hex int value with 0x
        static func color(for hex: Int) -> UIColor {
            return UIColor(red: CGFloat(Float((hex & 0xff0000) >> 16) / 255.0),
                           green: CGFloat(Float((hex & 0x00ff00) >> 8) / 255.0),
                           blue: CGFloat(Float((hex & 0x0000ff) >> 0) / 255.0),
                           alpha: CGFloat(1.0))
        }
    }
    
    static let cabinetWidth = 432  /// width 432 max is used for iPad Playgrounds
    static let cabinetHeight = 580
    static let boundaryWidth = 392
    static let boundaryHeight = 450
    
    static let clawMachineCabinetContainerView = SKView(frame: CGRect(x: 0, y: 0, width: cabinetWidth, height: cabinetHeight))
    static let scene = SKScene(size: CGSize(width: cabinetWidth, height: cabinetHeight))
    
    static let gameWindowShape = SKShapeNode(rect: CGRect(x: 20, y: 300, width: boundaryWidth, height: 200))
    static let prizeShootShape = SKShapeNode(rect: CGRect(x: 40, y: 70, width: 70, height: 310))
    static let prizeDispenser = SKShapeNode(rect: CGRect(x: prizeShootShape.frame.minX, y: prizeShootShape.frame.minY, width: prizeShootShape.frame.width, height: prizeShootShape.frame.width))
    static let button = Button.init(defaultButtonImage: "button-default.png", activeButtonImage: "button-active.png", buttonAction: buttonIsPressed)
    
    static let delegate = Collision()
    
    public static func setup() {
        clawMachineCabinetContainerView.backgroundColor = Colors.gray
        clawMachineCabinetContainerView.showsFields = true
        clawMachineCabinetContainerView.showsPhysics = true
        
        // Scene
        scene.backgroundColor = Colors.magenta
        scene.scaleMode = SKSceneScaleMode.aspectFit
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        // the delegate must be owned by something
        // setting contactDelegate = Collision() will not work without first creating a variable
        scene.physicsWorld.contactDelegate = delegate
        scene.delegate = delegate
        
        // game window
        gameWindowShape.fillColor = UIColor.blue
        scene.addChild(gameWindowShape)
        
        // prize shoot
        prizeShootShape.fillColor = UIColor.clear
        prizeShootShape.lineWidth = 0.0
        scene.addChild(prizeShootShape)
        
        // prize dispenser
        prizeDispenser.fillColor = UIColor.black
        prizeDispenser.lineWidth = 0.0
        scene.addChild(prizeDispenser)
    
        // button
        button.position = CGPoint(x: 270, y: 210)
        scene.addChild(button)
        
        // draw boundaries on scene
        let boundary = drawBoundaries()
        scene.addChild(boundary)
        
        // MARK: Sprites - add before joints
        scene.addChild(ClawSprites.motor)
        scene.addChild(ClawSprites.leftClaw)
        scene.addChild(ClawSprites.rightClaw)
        scene.addChild(ClawSprites.contactDetector)
        
        // SETUP joints
        let leftClawJoint = Joints.createLeftClawJoint(motor: ClawSprites.motor, leftClaw: ClawSprites.leftClaw)
        let rightClawJoint = Joints.createRightClawJoint(motor: ClawSprites.motor, rightClaw: ClawSprites.rightClaw)
        let contactDetectorJoint = Joints.createContactDetectorJoint(motor: ClawSprites.motor, contactDetector: ClawSprites.contactDetector)
        let clawSpringJoint = Joints.createClawSpringJoint(leftClaw: ClawSprites.leftClaw, rightClaw: ClawSprites.rightClaw)
        
        scene.physicsWorld.add(leftClawJoint)
        scene.physicsWorld.add(rightClawJoint)
        scene.physicsWorld.add(contactDetectorJoint)
        scene.physicsWorld.add(clawSpringJoint)
    
        clawMachineCabinetContainerView.presentScene(scene)
        
        PlaygroundPage.current.liveView = clawMachineCabinetContainerView
        PlaygroundPage.current.needsIndefiniteExecution = true
        
        // FIXME: Initiate movement
//        Claw.moveClaw(motor: ClawSprites.motor)
    }
    
    // Method used to draw claw machine boundaries
    // pass in the frame to get precise on w/e
    static func drawBoundaries() -> SKNode {
        let windowMinX = gameWindowShape.frame.minX
        let windowMaxX = gameWindowShape.frame.maxX
        let windowMaxY = gameWindowShape.frame.maxY
        let windowMinY = gameWindowShape.frame.minY
        
        let prizeMinX = prizeShootShape.frame.minX
        let prizeMaxX = prizeShootShape.frame.maxX
        let prizeMinY = prizeShootShape.frame.minY
        let prizeMaxY = prizeShootShape.frame.maxY
        
        let path = CGMutablePath()
        path.addLines(between: [
            CGPoint(x: windowMinX, y: windowMaxY),
            CGPoint(x: windowMaxX, y: windowMaxY),
            CGPoint(x: windowMaxX, y: windowMinY),
            CGPoint(x: prizeMaxX+5, y: windowMinY),
            CGPoint(x: prizeMaxX+5, y: prizeMaxY),
            CGPoint(x: prizeMaxX, y: prizeMaxY),
            CGPoint(x: prizeMaxX, y: prizeMinY),
            CGPoint(x: prizeMinX, y: prizeMinY),
            CGPoint(x: prizeMinX, y: prizeMaxY),
            CGPoint(x: prizeMinX-5, y: prizeMaxY),
            CGPoint(x: prizeMinX-5, y: windowMinY),
            CGPoint(x: windowMinX, y: windowMinY)
            ])
        path.closeSubpath()
        
        let fullBoundary = SKNode()
        fullBoundary.physicsBody = SKPhysicsBody(edgeLoopFrom: path)
        
        return fullBoundary
    }
    
    static func buttonIsPressed() {
        print("Button pressed")
    }
}
