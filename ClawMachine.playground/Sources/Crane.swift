import SpriteKit

public class Crane: SKNode {
    
    var crane: SKSpriteNode
    
    // TODO: Create a path for the crane to follow and reverse to?
    public init(defaultCraneImage: String) {
        crane = SKSpriteNode(imageNamed: defaultCraneImage)
        
        super.init()
        
        addChild(crane)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

