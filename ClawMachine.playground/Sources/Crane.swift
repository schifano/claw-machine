import SpriteKit

class Crane: SKNode {
    
    var crane: SKSpriteNode
    
    // TODO: Create a path for the crane to follow and reverse to?
    init(defaultCraneImage: String) {
        crane = SKSpriteNode(imageNamed: defaultCraneImage)
        
        super.init()
        
        addChild(crane)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

