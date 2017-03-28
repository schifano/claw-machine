import UIKit
import SpriteKit
import PlaygroundSupport

// TODO: Add gamePanel
// TODO: consider making a blurry transparent background for window effect

public class Container {
    
    var buttonIsPressed = false
    
    struct Colors {
        static let cyan = color(for: 0x98E3D4)  // soft cyan
        static let magenta = color(for: 0xd498e3)   // soft magenta
        
        static let waxFlower = color(for: 0xFFBBA4)
        static let lightBlue = color(for: 0x80DEEA)
        static let darkPurple = color(for: 0x7D3FFA)
        static let aqua = color(for: 0x31D5C3)
        static let lightGreen = color(for: 0x44FAAC)
        static let lightPink = color(for: 0xFFCAFE)
        static let tacao = color(for: 0xF5A87A)
//        static let sail = color(for: 0xB5DFFC)
        static let sail = UIColor(red: 0, green: 0.5, blue: 0.9, alpha: 0.2)
        static let voodoo = color(for: 0x45343D)
        static let pink = color(for: 0xF280B3)
        
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
    static let cabinetHeight = 500
    static let boundaryWidth = 392 + 40
    static let boundaryHeight = 450
    
    static let clawMachineCabinetContainerView = SKView(frame: CGRect(x: 0, y: 0, width: cabinetWidth, height: cabinetHeight))
    static let scene = SKScene(size: CGSize(width: cabinetWidth, height: cabinetHeight))
    
    static let gameWindowShape = SKShapeNode(rect: CGRect(x: 0, y: 225, width: boundaryWidth, height: 200))
    static let prizeShootShape = SKShapeNode(rect: CGRect(x: 30, y: 70, width: 70, height: 220))
    static let prizeDispenser = SKShapeNode(rect: CGRect(x: prizeShootShape.frame.minX-15, y: prizeShootShape.frame.minY, width: prizeShootShape.frame.width+30, height: prizeShootShape.frame.width+30), cornerRadius: 10)
    static let button = Button.init(defaultButtonImage: "button-default.png", activeButtonImage: "button-active.png", buttonAction: triggerButtonAction)
    static let panel = SKShapeNode(rect: CGRect(x: 120, y: 160, width: 100, height: 100))
    
    static let delegate = Collision()

    static let backgroundNode = SKNode()
    
    public static func setup() {
        clawMachineCabinetContainerView.backgroundColor = Colors.gray
        clawMachineCabinetContainerView.showsFields = true
        clawMachineCabinetContainerView.showsPhysics = true
        
        // Scene
        scene.backgroundColor = Colors.tacao
        scene.scaleMode = SKSceneScaleMode.aspectFit
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        // the delegate must be owned by something
        // setting contactDelegate = Collision() will not work without first creating a variable
        scene.physicsWorld.contactDelegate = delegate
        scene.delegate = delegate
        
        let cabinetNode = SKNode()
        
        // game window
        gameWindowShape.fillColor = Colors.sail
        //gameWindowShape.position = CGPoint(x: 40, y: 400)
//        scene.addChild(gameWindowShape)
        
        // prize shoot
        prizeShootShape.fillColor = UIColor.clear
        prizeShootShape.lineWidth = 0.0
//        scene.addChild(prizeShootShape)
        
        // prize dispenser
        prizeDispenser.fillColor = Colors.voodoo
        prizeDispenser.lineWidth = 0.0
//        scene.addChild(prizeDispenser)
    
        // panel
        panel.fillColor = Colors.lightGreen
        panel.lineWidth = 0.0
        //scene.addChild(panel)
        
        // button
        button.position = CGPoint(x: 250, y: 120)
//        scene.addChild(button)
        
        
        // draw boundaries on scene
        let boundary = drawBoundaries()
        scene.addChild(boundary)
        
        
        
        
        cabinetNode.addChild(gameWindowShape)
        cabinetNode.addChild(prizeShootShape)
        scene.addChild(prizeDispenser)
        cabinetNode.addChild(button)
        
        
        
        
        
        // MARK: Sprites - add before joints
        scene.addChild(Claw.motor)
        scene.addChild(Claw.leftClaw)
        scene.addChild(Claw.rightClaw)
        scene.addChild(Claw.contactDetector)
        
        // SETUP joints
        let leftClawJoint = Joints.createLeftClawJoint(motor: Claw.motor, leftClaw: Claw.leftClaw)
        let rightClawJoint = Joints.createRightClawJoint(motor: Claw.motor, rightClaw: Claw.rightClaw)
        let contactDetectorJoint = Joints.createContactDetectorJoint(motor: Claw.motor, contactDetector: Claw.contactDetector)
        let clawSpringJoint = Joints.createClawSpringJoint(leftClaw: Claw.leftClaw, rightClaw: Claw.rightClaw)
        
        scene.physicsWorld.add(leftClawJoint)
        scene.physicsWorld.add(rightClawJoint)
        scene.physicsWorld.add(contactDetectorJoint)
        scene.physicsWorld.add(clawSpringJoint)
    
        clawMachineCabinetContainerView.presentScene(scene)
        
//        scene.addChild(backgroundNode)
        cabinetNode.zPosition = 100
        scene.addChild(cabinetNode)
        
        PlaygroundPage.current.liveView = clawMachineCabinetContainerView
        PlaygroundPage.current.needsIndefiniteExecution = true
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
        fullBoundary.physicsBody?.categoryBitMask = Category.groundCategory
        fullBoundary.physicsBody?.collisionBitMask = Category.stuffedAnimalCategory
        return fullBoundary
    }
    
    static func triggerButtonAction() {
        
    }
}
