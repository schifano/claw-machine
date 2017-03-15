import UIKit
import PlaygroundSupport

public class Container {

//    public let container = UIViewController()
    
    public let clawMachineContainer = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 700))
    public let gameWindow = UIView(frame: CGRect(x: 20, y: 90, width: 460, height: 300))
    
    public let gameWindowLeft = UIView(frame: CGRect(x: 20, y: 90, width: 150, height: 300))
    public let gameWindowRight = UIView(frame: CGRect(x: 170, y: 90, width: 310, height: 300))
    
    
//    public let gameWindow = UIView(frame: CGRect(x: 20, y: 90, width: 392, height: 300))    // iPad
    
    public init() { } // needs to be public to be accessible from main playground
    
    public func setup() {
        clawMachineContainer.backgroundColor = UIColor.green
        gameWindow.backgroundColor = UIColor.cyan
        
        gameWindowLeft.backgroundColor = UIColor.darkGray
        gameWindowRight.backgroundColor = UIColor.brown
        
        
        // Set autoreizingMask for compatibility in iPad Playgrounds
        // This adjusts only the gameWindow, other views need adjusting - try bottom eventually
        // 432 is the min root view width for iPad
        gameWindow.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        
//        clawMachineContainer.addSubview(gameWindow)
        
        clawMachineContainer.addSubview(gameWindowLeft)
        clawMachineContainer.addSubview(gameWindowRight)
        
        PlaygroundPage.current.liveView = clawMachineContainer
        PlaygroundPage.current.needsIndefiniteExecution = true
    }

    public func getContainerSize() {
        // DEBUG
        print("Container Width: \(clawMachineContainer.frame.size.width)")
        print("Container Height: \(clawMachineContainer.frame.size.height)")
    }
}
