import SpriteKit
import AVFoundation

class Button: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    
    static var buttonIsPressed = false

    init(defaultButtonImage: String, activeButtonImage: String) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.isHidden = true
        
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
        
        Button.buttonIsPressed = true
        Claw.motor.run(Claw.moveRightBlock)
        
//        print("touches began") // DEBUG
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeButton.isHidden = true
        defaultButton.isHidden = false
        
        Button.buttonIsPressed = false
        Claw.motor.removeAllActions()
        Claw.returnClawHome()
    }
}

