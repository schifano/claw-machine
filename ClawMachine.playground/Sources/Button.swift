import SpriteKit

class Button: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: () -> Void
    
    static var isBeingHeld = 2
    
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: @escaping () -> Void) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.isHidden = true
        action = buttonAction
        
        // button container can now have access to methods inherited by SKNode
        super.init()
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    /// required by Xcode
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Show the active state button if the user starts touching a button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeButton.isHidden = false
        defaultButton.isHidden = true
        
        Claw.moveClawRight()
        
        guard let touch = touches.first else {
            print("There is no touch object")
            return
        }
        
        let location: CGPoint = touch.location(in: self)
        if defaultButton.contains(location) {
            action() // begin action
        }
        
        print("touches began")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeButton.isHidden = true
        defaultButton.isHidden = false
        
        
        Claw.motor.removeAllActions()
        Claw.returnClawHome()
        
    }
}

