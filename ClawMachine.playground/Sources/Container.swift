import UIKit
import SpriteKit
import PlaygroundSupport

public class Container {

    /// Main view of the claw machine that all other views are added to
    /// width 432 max is used for iPad Playgrounds
//    public let clawMachineCabinetContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 432, height: 600))
    
    
    public let clawMachineCabinetContainerView = SKView(frame: CGRect(x: 0, y: 0, width: 432, height: 600))
    
//    /// View where all physics occurs
    public let physicsContainerView = SKView(frame: CGRect(x: 20, y: 90, width: 392, height: 450))
    public let scene = SKScene(size: CGSize(width: 392, height: 450))
    
    public let gameWindow = UIView(frame: CGRect(x: 20, y: 90, width: 392, height: 200))
    public let gamePanel = UIView(frame: CGRect(x: 120, y: 350, width: 50, height: 50))
    // TODO: Add gamePanel and dispenserWindow
    
    /// Colors
//    let cabinetColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0) // pale robin egg blue: #98E3D4
    let cabinetColor = UIColor(red:0.39, green:0.00, blue:0.76, alpha:1.00)
//    let gameWindowColor = UIColor(red: 212/255, green: 152/255, blue: 227/255, alpha: 1.0) // soft magenta #d498e3
    let gameWindowColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0)
    // TODO: consider making a blurry transparent background for window effect
    let gamePanelColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0)
    
    
    
    public let crane = Crane.init(defaultCraneImage: "crane.png")
    
    public init() { } // needs to be public to be accessible from main playground
    
    public func setup() {

        // FIXME: lol this doesn't work
        clawMachineCabinetContainerView.contentMode = .scaleAspectFit
        
        // FIXME: Adjust views to be resizable on iPad
        // Set autoreizingMask for compatibility in iPad Playgrounds
        // This adjusts only the gameWindow, other views need adjusting - try bottom eventually
        // 432 is the min root view width for iPad
        
        // TODO: CREATE WORKING BUTTONS
        let button = Button.init(defaultButtonImage: "button-default.png", activeButtonImage: "button-active.png", buttonAction: doSomething)
        button.position = CGPoint(x: 250, y: 150)
        
        
//        let crane = Crane.init(defaultCraneImage: "crane.png")
        crane.position = CGPoint(x: 55, y: 410)
        
        gameWindow.backgroundColor = gameWindowColor
        gamePanel.backgroundColor = gamePanelColor
        clawMachineCabinetContainerView.backgroundColor = cabinetColor
        
        gamePanel.layer.cornerRadius = 25
        gamePanel.layer.masksToBounds = true
        
        clawMachineCabinetContainerView.addSubview(gameWindow)
//        clawMachineCabinetContainerView.addSubview(gamePanel)
//        clawMachineCabinetContainerView.addSubview(physicsContainerView)
        
        
//        clawMachineCabinetContainerView.addSubview(physicsContainerView)
        physicsContainerView.allowsTransparency = true
        physicsContainerView.showsPhysics = true    // debug
        physicsContainerView.showsFields = true     // debug
        
        scene.backgroundColor = UIColor.clear
        scene.scaleMode = SKSceneScaleMode.aspectFit
        physicsContainerView.contentMode = .scaleAspectFit
        
        scene.addChild(button)  // BUTTON
        scene.addChild(crane)   // CRANE
        
        drawBoundaries()
        
        clawMachineCabinetContainerView.presentScene(scene)
        
        PlaygroundPage.current.liveView = clawMachineCabinetContainerView
        PlaygroundPage.current.needsIndefiniteExecution = true

    }
    
    // FIXME: Moves crane in designated path
    func doSomething() {
        let moveNodeRight = SKAction.moveBy(x: 150.0,
                                            y: 0.0,
                                            duration: 2.0)
        let moveNodeDown = SKAction.moveBy(x: 0.0,
                                           y: -100.0,
                                           duration: 1.0)
        
        let sequence = SKAction.sequence([moveNodeRight, moveNodeDown, moveNodeDown.reversed(), moveNodeRight.reversed()])
        crane.run(sequence)
    }
    
    func drawBoundaries() {
        let physicsHeight = physicsContainerView.frame.height
        let physicsWidth = physicsContainerView.frame.width
        let windowHeight = gameWindow.frame.height
        
        let path = CGMutablePath()
        path.addLines(between: [
            CGPoint(x: 0, y: physicsHeight),
            CGPoint(x: physicsWidth, y: physicsHeight),
            CGPoint(x: physicsWidth, y: physicsHeight - windowHeight),
            CGPoint(x: 105, y: physicsHeight - windowHeight),
            CGPoint(x: 105, y: physicsHeight - windowHeight + 100),
            CGPoint(x: 100, y: physicsHeight - windowHeight + 100),
            CGPoint(x: 100, y: 0),
            CGPoint(x: 15, y: 0),
            CGPoint(x: 15, y: physicsHeight - windowHeight + 100),
            CGPoint(x: 10, y: physicsHeight - windowHeight + 100),
            CGPoint(x: 10, y: physicsHeight - windowHeight),
            
            CGPoint(x: 0, y: physicsHeight - windowHeight)
            ])
        path.closeSubpath()
        
        let fullBoundary = SKNode()
        fullBoundary.physicsBody = SKPhysicsBody(edgeLoopFrom: path)
        scene.addChild(fullBoundary)
    }
    
// FIXME: Broken path for crane
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 55, y: 410))
//        path.addLine(to: CGPoint(x: 200, y: 410))
//        
//        let followCraneLine = SKAction.follow(path, speed: 3.0)
//        
//        crane.run(followCraneLine)
//        crane.run(followCraneLine.reversed())
    
    
    
    
    
//    public func getContainerSize() {
//        // DEBUG
//        print("Container Width: \(clawMachineContainer.frame.size.width)")
//        print("Container Height: \(clawMachineContainer.frame.size.height)")
//    }
}
