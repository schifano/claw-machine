import UIKit
import SpriteKit
import CoreImage
import PlaygroundSupport

public class ClawMachine {
    
    struct Colors {
        static let lightGreen = color(for: 0x44FAAC)
        static let sail = color(for: 0xB3D7F7)
        /// Precede each hex int value with 0x
        static func color(for hex: Int) -> UIColor {
            return UIColor(red: CGFloat(Float((hex & 0xff0000) >> 16) / 255.0),
                           green: CGFloat(Float((hex & 0x00ff00) >> 8) / 255.0),
                           blue: CGFloat(Float((hex & 0x0000ff) >> 0) / 255.0),
                           alpha: CGFloat(1.0))
        }
    }
    
    static let delegate = Collision()
    
    static let cabinetWidth = 350  /// width 432 max is used for iPad Playgrounds
    static let cabinetHeight = 450
    static let boundaryWidth = 350
//    static let boundaryWidth = 392 + 40 (= 432)
    static let boundaryHeight = 450
    
    static let clawMachineCabinetContainerView = SKView(frame: CGRect(x: 0, y: 0, width: cabinetWidth, height: cabinetHeight))
    static let scene = SKScene(size: CGSize(width: cabinetWidth, height: cabinetHeight))
    
    static let gameWindowShape = SKShapeNode(rect: CGRect(x: 0, y: 240, width: boundaryWidth, height: 160))
    static let gameWindowGlassShape = SKShapeNode(rect: CGRect(x: 0, y: 240, width: boundaryWidth, height: 160))
    
    static let prizeShootShape = SKShapeNode(rect: CGRect(x: 30, y: 70, width: 70, height: 215))
    static let prizeShootGlassShape = SKShapeNode(rect: CGRect(x: 27, y: 65, width: 80, height: 50))
    static let prizeDispenser = SKShapeNode(rect: CGRect(x: prizeShootShape.frame.minX-15, y: prizeShootShape.frame.minY, width: prizeShootShape.frame.width+30, height: prizeShootShape.frame.width+30), cornerRadius: 10)
    
    static let button = Button.init(defaultButtonImage: "button-default.png", activeButtonImage: "button-active.png")

    static let panel = SKShapeNode(rect: CGRect(x: button.position.x+50, y: button.position.y-50, width: prizeShootShape.frame.width+30, height: prizeShootShape.frame.width+30), cornerRadius: 10)
    static let numberOfRetriesLabel = SKLabelNode(text: "12")
    
    public static func setup() {
//        clawMachineCabinetContainerView.showsFields = true    // DEBUG
//        clawMachineCabinetContainerView.showsPhysics = true   // DEBUG
        
        // Scene
        scene.backgroundColor = Colors.color(for: 0xecafb5)
        scene.scaleMode = SKSceneScaleMode.aspectFit
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        // the delegate must be owned by something
        // setting contactDelegate = Collision() will not work without first creating a variable
        scene.physicsWorld.contactDelegate = delegate
        scene.delegate = delegate
        
        // MARK: Background Gradient
        let color1 = CIColor(color: Colors.color(for: 0xecafb5)) // bottom
//        let color1 = CIColor(color: Colors.color(for: 0xe79aa2)) // bottom darker
        let color2 = CIColor(color: Colors.color(for: 0xf7ccb8)) // top
        
        let backgroundGradient = SKTexture(size: clawMachineCabinetContainerView.frame.size, color1: color1, color2: color2)
        let backgroundGradientNode = SKSpriteNode(texture: backgroundGradient)
        backgroundGradientNode.size = clawMachineCabinetContainerView.frame.size
        backgroundGradientNode.position = CGPoint(x: clawMachineCabinetContainerView.frame.midX, y: clawMachineCabinetContainerView.frame.midY)
//        scene.addChild(backgroundGradientNode)
        
        
        // MARK: Background Image
        let background = SKSpriteNode(imageNamed: "background-bear")
        background.size = CGSize(width: clawMachineCabinetContainerView.frame.width-10, height: clawMachineCabinetContainerView.frame.height-50)
        background.position = CGPoint(x: clawMachineCabinetContainerView.frame.midX, y: clawMachineCabinetContainerView.frame.midY-50)
        scene.addChild(background)
        
        
        // MARK: Cabinet Header
        let header = SKShapeNode(rect: CGRect(x: 0, y: Int(gameWindowShape.frame.maxY), width: cabinetWidth, height: 50))
        header.fillColor = Colors.color(for: 0xecafb5)
        header.lineWidth = 0.0
        

        // MARK: Header Label
        let title = SKLabelNode(text: "Stuffy Time")
        title.position = CGPoint(x: header.frame.midX, y: gameWindowShape.frame.maxY+10)
//        title.position = CGPoint(x: 100, y: 100)
        title.fontName = "AvenirNextCondensed-Bold"
        title.fontSize = 32.0
        title.fontColor = UIColor(red:0.76, green:0.44, blue:0.40, alpha:1.00)
//        title.horizontalAlignmentMode = .center;
//        title.verticalAlignmentMode = .center
        
        
        // MARK: Game Window
        gameWindowShape.fillColor = UIColor.clear
        gameWindowShape.lineWidth = 0.0
        gameWindowShape.strokeColor = Colors.color(for: 0x112549)
        //gameWindowShape.position = CGPoint(x: 40, y: 400)
        
        
        // MARK: Game Window Glass
        gameWindowGlassShape.fillColor = UIColor(red:0.70, green:0.84, blue:0.97, alpha: 0.3)
        gameWindowGlassShape.lineWidth = 0.0
        
        // MARK: Prize Shoot
        prizeShootShape.fillColor = UIColor.clear
        prizeShootShape.lineWidth = 0.0
        
        // MARK: Prize Shoot Glass
        prizeShootGlassShape.fillColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        prizeShootGlassShape.lineWidth = 0.0
//        prizeShootGlassShape.strokeColor = Colors.color(for: 0x112549)
        prizeShootGlassShape.position = CGPoint(x: gameWindowShape.frame.minX, y: gameWindowShape.frame.minY-65)
        
        
        // MARK: Prize Dispenser
        prizeDispenser.fillColor = UIColor(red:0.70, green:0.84, blue:0.97, alpha:0.5)
        prizeDispenser.lineWidth = 5.0
        prizeDispenser.strokeColor = UIColor(red:0.17, green:0.85, blue:0.56, alpha:1.00)
        
        // MARK: Button
//        button.position = CGPoint(x: 210, y: 120)
        button.position = CGPoint(x: boundaryWidth/2, y: 120)
        
        
        // MARK: Panel
        // TODO: If time, integrate retry count
        panel.fillColor = Colors.lightGreen
        panel.lineWidth = 0.0
        //scene.addChild(panel)
        
        
        // MARK: Panel Label
        numberOfRetriesLabel.fontSize = 80.0
        numberOfRetriesLabel.fontName = "Courier-Bold"
        numberOfRetriesLabel.fontColor = UIColor.red
//        numberOfRetriesLabel.horizontalAlignmentMode = .center
//        numberOfRetriesLabel.verticalAlignmentMode = .center
        panel.addChild(numberOfRetriesLabel)
        numberOfRetriesLabel.position = CGPoint(x: 270, y: 100)
//        print("panel x \(panel.position.x)")
//        print("panel y \(panel.position.y)")
        
        
        // draw boundaries on scene
        let boundary = drawBoundaries()
        
        
        // MARK: Joints
        let leftClawJoint = Joints.createLeftClawJoint(motor: Claw.motor, leftClaw: Claw.leftClaw)
        let rightClawJoint = Joints.createRightClawJoint(motor: Claw.motor, rightClaw: Claw.rightClaw)
        let barJoint = Joints.createBarJoint(motor: Claw.motor, bar: Claw.bar)
        let contactDetectorJoint = Joints.createContactDetectorJoint(motor: Claw.motor, contactDetector: Claw.contactDetector)
        let clawSpringJoint = Joints.createClawSpringJoint(leftClaw: Claw.leftClaw, rightClaw: Claw.rightClaw)
        
        
        // MARK: Scene Node - add children
        scene.addChild(boundary)
        
        scene.addChild(gameWindowShape)
        scene.addChild(prizeDispenser)
        
        // MARK: Sprites - add to scene before joints
        scene.addChild(Claw.motor)
        scene.addChild(Claw.bar)
        scene.addChild(Claw.leftClaw)
        scene.addChild(Claw.rightClaw)
        scene.addChild(Claw.contactDetector)
        
        scene.physicsWorld.add(leftClawJoint)
        scene.physicsWorld.add(rightClawJoint)
        scene.physicsWorld.add(barJoint)
        scene.physicsWorld.add(contactDetectorJoint)
        scene.physicsWorld.add(clawSpringJoint)
    
        clawMachineCabinetContainerView.presentScene(scene)

        // MARK: Cabinet Node - add children
        let cabinetNode = SKNode()
        cabinetNode.zPosition = 100
        
        cabinetNode.addChild(header)
        cabinetNode.addChild(title)
        cabinetNode.addChild(prizeShootShape)
        cabinetNode.addChild(button)
//        cabinetNode.addChild(panel)
        cabinetNode.addChild(prizeShootGlassShape)
        cabinetNode.addChild(gameWindowGlassShape)
        
        scene.addChild(cabinetNode)
        
        // MARK: Audio setup
        Sounds.setupAudio()
        
        PlaygroundPage.current.liveView = clawMachineCabinetContainerView
        PlaygroundPage.current.needsIndefiniteExecution = true
    }
    
    /// Method used to draw claw machine boundaries
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
            
            // ########### 
            // border around dispenser
            CGPoint(x: prizeMaxX, y: prizeMinY+ClawMachine.prizeDispenser.frame.height),
            CGPoint(x: ClawMachine.prizeDispenser.frame.maxX-5, y: ClawMachine.prizeDispenser.frame.maxY),
            CGPoint(x: ClawMachine.prizeDispenser.frame.maxX-5, y: ClawMachine.prizeDispenser.frame.minY+5),
            CGPoint(x: ClawMachine.prizeDispenser.frame.minX+5, y: ClawMachine.prizeDispenser.frame.minY+5),
            CGPoint(x: ClawMachine.prizeDispenser.frame.minX+5, y: ClawMachine.prizeDispenser.frame.maxY-5),
            CGPoint(x: prizeMinX, y: prizeMinY+ClawMachine.prizeDispenser.frame.height),
            // ###########
            
            CGPoint(x: prizeMinX, y: prizeMaxY),
            CGPoint(x: prizeMinX-5, y: prizeMaxY),
            CGPoint(x: prizeMinX-5, y: windowMinY),
            CGPoint(x: windowMinX, y: windowMinY)
            ])
        path.closeSubpath()
        
        let fullBoundary = SKNode()
        fullBoundary.physicsBody = SKPhysicsBody(edgeLoopFrom: path)
        fullBoundary.physicsBody?.categoryBitMask = Category.boundaryCategory
        fullBoundary.physicsBody?.collisionBitMask = Category.stuffedAnimalCategory
        return fullBoundary
    }
}

// MARK: SKTexture extension to add gradients
extension SKTexture {
    convenience init(size: CGSize, color1: CIColor, color2: CIColor) {
        let coreImageContext = CIContext(options: nil)
        let gradientFilter = CIFilter(name: "CILinearGradient")
        gradientFilter?.setDefaults()
        var startVector:CIVector
        var endVector:CIVector

        startVector = CIVector(x: size.width/2, y: 0)
        endVector = CIVector(x: size.width/2, y: size.height)
        
        gradientFilter?.setValue(startVector, forKey: "inputPoint0")
        gradientFilter?.setValue(endVector, forKey: "inputPoint1")
        gradientFilter?.setValue(color1, forKey: "inputColor0")
        gradientFilter?.setValue(color2, forKey: "inputColor1")
        let cgimg = coreImageContext.createCGImage((gradientFilter?.outputImage)!, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.init(cgImage: cgimg!)
    }
}
