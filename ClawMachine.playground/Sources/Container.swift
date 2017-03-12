import UIKit
import PlaygroundSupport

public class Container {

    let viewController = UIViewController()
    
    public init() { } // needs to be public to be accessible from main playground
    
    public func setup() {
        viewController.view.layer.backgroundColor = UIColor.green.cgColor
        
        PlaygroundPage.current.liveView = viewController
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
    }

    public func getContainerSize() {
        // DEBUG
        print("ViewController Height: \(viewController.view.frame.size.height)")
        print("ViewController Width: \(viewController.view.frame.size.width)")
    }
}
