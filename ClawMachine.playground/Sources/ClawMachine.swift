import UIKit
import SpriteKit
import CoreImage
import PlaygroundSupport

public class ClawMachine {
    
    var buttonIsPressed = false
    
    struct Colors {
        static let cyan = color(for: 0x98E3D4)  // soft cyan
        static let magenta = color(for: 0xd498e3)   // soft magenta
        
        
//        static let tan = color(for: 0x615aae)
        static let tan = color(for: 0x522f46)
        static let waxFlower = color(for: 0xFFBBA4)
        static let lightBlue = color(for: 0x80DEEA)
        static let darkPurple = color(for: 0x7D3FFA)
        static let aqua = color(for: 0x31D5C3)
        static let lightGreen = color(for: 0x44FAAC)
        static let lightPink = color(for: 0xFFCAFE)
        static let tacao = color(for: 0xF5A87A)
//        static let sail = color(for: 0x46AAAC)
        static let sail = UIColor(red: 181/255, green: 223/255, blue: 252/255, alpha: 1.0)
        
//        static let sail = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        
//        static let sail = UIColor(red: 0, green: 0.5, blue: 0.9, alpha: 0.2)
        static let voodoo = color(for: 0x915842)
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
    
    static let cabinetWidth = 350  /// width 432 max is used for iPad Playgrounds
    static let cabinetHeight = 450
    static let boundaryWidth = 350
//    static let boundaryWidth = 392 + 40 (= 432)
    static let boundaryHeight = 450
    
    static let clawMachineCabinetContainerView = SKView(frame: CGRect(x: 0, y: 0, width: cabinetWidth, height: cabinetHeight))
    static let scene = SKScene(size: CGSize(width: cabinetWidth, height: cabinetHeight))
    
    public static let gameWindowShape = SKShapeNode(rect: CGRect(x: 0, y: 240, width: boundaryWidth, height: 160))
    static let gameWindowGlassShape = SKShapeNode(rect: CGRect(x: 0, y: 240, width: boundaryWidth, height: 160))
    
    
    public static let prizeShootShape = SKShapeNode(rect: CGRect(x: 30, y: 70, width: 70, height: 215))
    public static let prizeShootGlassShape = SKShapeNode(rect: CGRect(x: 30, y: 70, width: 80, height: 50))
    static let prizeDispenser = SKShapeNode(rect: CGRect(x: prizeShootShape.frame.minX-15, y: prizeShootShape.frame.minY, width: prizeShootShape.frame.width+30, height: prizeShootShape.frame.width+30), cornerRadius: 10)
    static let button = Button.init(defaultButtonImage: "button-default.png", activeButtonImage: "button-active.png")
    
    
    public static var name = ""
    
    static let delegate = Collision()

    static let backgroundNode = SKNode()
    
    let title = SKLabelNode(text: "\(name)'s Skill Crane")
    
    public static func set(name: String) {
        self.name = name
    }
    
    
    static let panel = SKShapeNode(rect: CGRect(x: button.position.x+50, y: button.position.y-50, width: prizeShootShape.frame.width+30, height: prizeShootShape.frame.width+30), cornerRadius: 10)
    static let numberOfRetriesLabel = SKLabelNode(text: "12")
    
//    public static let numberOfRetriesLabel = SKLabelNode(text: "12")  
    
    
    public static func setup() {
        clawMachineCabinetContainerView.backgroundColor = Colors.gray
        
//        clawMachineCabinetContainerView.showsFields = true
//        clawMachineCabinetContainerView.showsPhysics = true
        
        // Scene
        scene.backgroundColor = Colors.color(for: 0x625AB0)
        scene.scaleMode = SKSceneScaleMode.aspectFit
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        // the delegate must be owned by something
        // setting contactDelegate = Collision() will not work without first creating a variable
        scene.physicsWorld.contactDelegate = delegate
        scene.delegate = delegate
        
        // Background image
        let color1 = CIColor(color: Colors.color(for: 0xE56A6F)) // bottom
        let color2 = CIColor(color: Colors.color(for: 0xE56A6F)) // top
        
        
//        let color1 = CIColor(color: Colors.color(for: 0xecafb5)) // bottom
//        let color2 = CIColor(color: Colors.color(for: 0xf7ccb8)) // top
//        let color1 = CIColor(color: Colors.color(for: 0xfa7e81))
//        let color2 = CIColor(color: Colors.color(for: 0xfda197))
        
//        let color1 = CIColor(red: 110/255, green: 242/255, blue: 212/255)
//        let color2 = CIColor(red: 153/255, green: 248/255, blue: 195/255)
        
        let backgroundGradient = SKTexture(size: clawMachineCabinetContainerView.frame.size, color1: color1, color2: color2)
        let backgroundGradientNode = SKSpriteNode(texture: backgroundGradient)
        backgroundGradientNode.size = clawMachineCabinetContainerView.frame.size
        backgroundGradientNode.position = CGPoint(x: clawMachineCabinetContainerView.frame.midX, y: clawMachineCabinetContainerView.frame.midY)
//        scene.addChild(backgroundGradientNode)
        
        
        
        let background = SKSpriteNode(imageNamed: "naked-bear")
        background.size = CGSize(width: clawMachineCabinetContainerView.frame.width-10, height: clawMachineCabinetContainerView.frame.height-20)
        background.position = CGPoint(x: clawMachineCabinetContainerView.frame.midX, y: clawMachineCabinetContainerView.frame.midY)
//        scene.addChild(background)
        
        
//        title.color = UIColor.white
//        title.position = CGPoint(x: clawMachineCabinetContainerView.frame.midX, y: clawMachineCabinetContainerView.frame.maxY-25)
////        title.fontName = "BanglaSangamMN-Bold"
//        title.fontSize = 25.0
//        title.horizontalAlignmentMode = .center;
//        title.verticalAlignmentMode = .center
//        title.fontName = "MarkerFelt-Thin"
//        scene.addChild(title)
        
        
        
        let cabinetNode = SKNode()
        
        // game window
        gameWindowShape.fillColor = Colors.sail
        gameWindowShape.lineWidth = 5.0
        gameWindowShape.strokeColor = Colors.color(for: 0x112549)
        //gameWindowShape.position = CGPoint(x: 40, y: 400)
        
        
        // game window glass
        gameWindowGlassShape.fillColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
        gameWindowGlassShape.lineWidth = 0.0
        
        // prize shoot
        prizeShootShape.fillColor = UIColor.clear
        prizeShootShape.lineWidth = 0.0
        
        // prize shoot glass
        prizeShootGlassShape.fillColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        prizeShootGlassShape.lineWidth = 0.0
        prizeShootGlassShape.position = CGPoint(x: gameWindowShape.frame.minX, y: gameWindowShape.frame.minY-65)
        
        
        // prize dispenser
        prizeDispenser.fillColor = Colors.color(for: 0x46AAAC)
        prizeDispenser.lineWidth = 5.0
        prizeDispenser.strokeColor = Colors.color(for: 0x112549)
        
        // button
//        button.position = CGPoint(x: 210, y: 120)
        button.position = CGPoint(x: boundaryWidth/2, y: 120)
        
        print("button x \(button.position.x)")
        print("button y \(button.position.y)")
        
        
        // panel
        panel.fillColor = Colors.lightGreen
        panel.lineWidth = 0.0
        //scene.addChild(panel)
        
        
        // panel label
        numberOfRetriesLabel.fontSize = 80.0
        numberOfRetriesLabel.fontName = "Courier-Bold"
        numberOfRetriesLabel.fontColor = UIColor.red
//        numberOfRetriesLabel.horizontalAlignmentMode = .center
//        numberOfRetriesLabel.verticalAlignmentMode = .center
        panel.addChild(numberOfRetriesLabel)
        numberOfRetriesLabel.position = CGPoint(x: 270, y: 100)
        print("panel x \(panel.position.x)")
        print("panel y \(panel.position.y)")
        
        
        
        // draw boundaries on scene
        let boundary = drawBoundaries()
        scene.addChild(boundary)
        
        
        
        
        scene.addChild(prizeDispenser)
        scene.addChild(gameWindowShape)
        // FIXME: add a tinted window on top with cabinet Node
        cabinetNode.addChild(prizeShootShape)
        cabinetNode.addChild(button)
        cabinetNode.addChild(panel)
        cabinetNode.addChild(gameWindowGlassShape)
        cabinetNode.addChild(prizeShootGlassShape)
        
        
        
        
        // MARK: Sprites - add before joints
        scene.addChild(Claw.motor)
        scene.addChild(Claw.bar)
        scene.addChild(Claw.leftClaw)
        scene.addChild(Claw.rightClaw)
        scene.addChild(Claw.contactDetector)
        
        // SETUP joints
        let leftClawJoint = Joints.createLeftClawJoint(motor: Claw.motor, leftClaw: Claw.leftClaw)
        let rightClawJoint = Joints.createRightClawJoint(motor: Claw.motor, rightClaw: Claw.rightClaw)
        let barJoint = Joints.createBarJoint(motor: Claw.motor, bar: Claw.bar)
        let contactDetectorJoint = Joints.createContactDetectorJoint(motor: Claw.motor, contactDetector: Claw.contactDetector)
        let clawSpringJoint = Joints.createClawSpringJoint(leftClaw: Claw.leftClaw, rightClaw: Claw.rightClaw)
        
        scene.physicsWorld.add(leftClawJoint)
        scene.physicsWorld.add(rightClawJoint)
        scene.physicsWorld.add(barJoint)
        scene.physicsWorld.add(contactDetectorJoint)
        scene.physicsWorld.add(clawSpringJoint)
    
        clawMachineCabinetContainerView.presentScene(scene)
        
//        scene.addChild(backgroundNode)
        cabinetNode.zPosition = 150
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
            
            // ### border around dispenser
            CGPoint(x: prizeMaxX, y: prizeMinY+ClawMachine.prizeDispenser.frame.height),
            CGPoint(x: ClawMachine.prizeDispenser.frame.maxX, y: ClawMachine.prizeDispenser.frame.maxY),
            CGPoint(x: ClawMachine.prizeDispenser.frame.maxX, y: ClawMachine.prizeDispenser.frame.minY),
            CGPoint(x: ClawMachine.prizeDispenser.frame.minX, y: ClawMachine.prizeDispenser.frame.minY),
            CGPoint(x: ClawMachine.prizeDispenser.frame.minX, y: ClawMachine.prizeDispenser.frame.maxY),
            CGPoint(x: prizeMinX, y: prizeMinY+ClawMachine.prizeDispenser.frame.height),
            
//            CGPoint(x: prizeMaxX, y: prizeMinY),
//            CGPoint(x: prizeMinX, y: prizeMinY),
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
