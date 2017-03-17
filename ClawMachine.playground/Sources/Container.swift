import UIKit
import SpriteKit
import PlaygroundSupport

public class Container {

    /// Main view of the claw machine that all other views are added to
    /// width 432 max is used for iPad Playgrounds
    public let clawMachineCabinetContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 432, height: 600))
    
    /// View where all physics occurs
    public let physicsContainerView = SKView(frame: CGRect(x: 20, y: 90, width: 392, height: 450))
    public let scene = SKScene(size: CGSize(width: 392, height: 450))
    
    public let gameWindow = UIView(frame: CGRect(x: 20, y: 90, width: 392, height: 225))
    public let gamePanel = UIView(frame: CGRect(x: 120, y: 350, width: 50, height: 50))
    // TODO: Add gamePanel and dispenserWindow
    
    /// Colors
//    let cabinetColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0) // pale robin egg blue: #98E3D4
    let cabinetColor = UIColor(red:0.39, green:0.00, blue:0.76, alpha:1.00)
//    let gameWindowColor = UIColor(red: 212/255, green: 152/255, blue: 227/255, alpha: 1.0) // soft magenta #d498e3
    let gameWindowColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0)
    // TODO: consider making a blurry transparent background for window effect
    let gamePanelColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0)
    
    public init() { } // needs to be public to be accessible from main playground
    
    public func setup() {

        // FIXME: Adjust views to be resizable on iPad
        // Set autoreizingMask for compatibility in iPad Playgrounds
        // This adjusts only the gameWindow, other views need adjusting - try bottom eventually
        // 432 is the min root view width for iPad
        
        // TODO: CREATE WORKING BUTTONS
        let button = Button.init(defaultButtonImage: "button-default.png", activeButtonImage: "button-active.png", buttonAction: doSomething)
        button.position = CGPoint(x: 250, y: 150)
        
        
        gameWindow.backgroundColor = gameWindowColor
        gamePanel.backgroundColor = gamePanelColor
        clawMachineCabinetContainerView.backgroundColor = cabinetColor
        
        gamePanel.layer.cornerRadius = 25
        gamePanel.layer.masksToBounds = true
        
        clawMachineCabinetContainerView.addSubview(gameWindow)
//        clawMachineCabinetContainerView.addSubview(gamePanel)
        clawMachineCabinetContainerView.addSubview(physicsContainerView)
        
        
        physicsContainerView.allowsTransparency = true
        physicsContainerView.showsPhysics = true    // debug
        physicsContainerView.showsFields = true     // debug
        
        scene.backgroundColor = UIColor.clear
        scene.scaleMode = SKSceneScaleMode.aspectFit
        
        scene.addChild(button) // BUTTON
        
        
        physicsContainerView.presentScene(scene)
        
        PlaygroundPage.current.liveView = clawMachineCabinetContainerView
        PlaygroundPage.current.needsIndefiniteExecution = true
    }
    
    func doSomething() {
        
    }

//    public func getContainerSize() {
//        // DEBUG
//        print("Container Width: \(clawMachineContainer.frame.size.width)")
//        print("Container Height: \(clawMachineContainer.frame.size.height)")
//    }
}
