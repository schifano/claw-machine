import UIKit
import PlaygroundSupport

public class Container {

    public let viewController = UIViewController()
    
    public let container = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
    public let gameWindow = UIView(frame: CGRect(x: 20, y: 90, width: 460, height: 300))
    
    public init() { } // needs to be public to be accessible from main playground
    
    public func setup() {
//        viewController.view.layer.backgroundColor = UIColor.green.cgColor
//        viewController.view.frame = CGRect(x: 0, y: 0, width: 500, height: 700)
        
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 700))
        
        container.backgroundColor = UIColor.green
        gameWindow.backgroundColor = UIColor.cyan
        
        container.addSubview(gameWindow)
        
        
        PlaygroundPage.current.liveView = container
        PlaygroundPage.current.needsIndefiniteExecution = true
        
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 800))
//        container.backgroundColor = UIColor.white
//        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        view.backgroundColor = UIColor.red
//        container.addSubview(view)
//
//        PlaygroundPage.current.liveView = container
//        PlaygroundPage.current.needsIndefiniteExecution = true
//        ViewController Height: 668.0
//        ViewController Width: 375.0

    }

    public func getContainerSize() {
        // DEBUG
//        print("ViewController Height: \(viewController.view.frame.size.height)")
//        print("ViewController Width: \(viewController.view.frame.size.width)")
        
        print("Container Width: \(container.frame.size.width)")
        print("Container Height: \(container.frame.size.height)")
    }
}
