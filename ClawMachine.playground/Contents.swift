//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

let container = Container()
container.setup()
//container.getContainerSize()

// TODO: Generate multiple items on screen
// TODO: Add overlap behavior



// UIKit Dynamics - drop things
//let containerView = container.viewController.view!

let containerView = container.clawMachineContainerView

//let boundary = SKNode()
let path = CGMutablePath()
path.addLines(between: [
    CGPoint(x: 0, y: container.physicsContainerView.frame.height),
    CGPoint(x: container.physicsContainerView.frame.width, y: container.physicsContainerView.frame.height),
    CGPoint(x: container.physicsContainerView.frame.width, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height),
    CGPoint(x: 130, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height),
    CGPoint(x: 130, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height + 100),
    CGPoint(x: 120, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height + 100),
    CGPoint(x: 120, y: 0),
    CGPoint(x: 20, y: 0),
    CGPoint(x: 20, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height + 100),
    CGPoint(x: 10, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height + 100),
    CGPoint(x: 10, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height),
    
    CGPoint(x: 0, y: container.physicsContainerView.frame.height - container.gameWindow.frame.height)
//    CGPoint(x: 460, y: 390),
//    CGPoint(x: 150, y: 300),
//    CGPoint(x: 20, y: 90)
    ])

//path.addLines(between: [
//    CGPoint(x: 0, y: 0),
//    CGPoint(x: 600, y: 500),
//    ])
path.closeSubpath()
//boundary.physicsBody = SKPhysicsBody(polygonFrom: path)

// y: containerHeight - gameWindowHeight, coords start bottom left
//let boundary = SKNode()
//boundary.physicsBody = SKPhysicsBody(edgeLoopFrom:
//    CGRect(x: 0, y: 250,
//           width: container.gameWindow.frame.width,
//           height: container.gameWindow.frame.height))
//container.scene.addChild(boundary)

let fullBoundary = SKNode()
fullBoundary.physicsBody = SKPhysicsBody(edgeLoopFrom: path)
container.scene.addChild(fullBoundary)


let texture = SKTexture(image: #imageLiteral(resourceName: "unicorn.jpg"))

for _ in 1 ... 10 {
    let ooni = SKSpriteNode(texture: texture)
    ooni.size = CGSize(width: 50, height: 50)
    ooni.position = CGPoint(x: Int(arc4random_uniform(141)+200), y: Int(arc4random_uniform(251) + 250))
    ooni.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: 30, height: 30))
    ooni.physicsBody?.affectedByGravity = true
    container.scene.addChild(ooni)
}
//
//let texture = SKTexture(image: #imageLiteral(resourceName: "bear2.png"))
//for _ in 1 ... 25 {
//    let star = SKSpriteNode(texture: texture)
//    star.size = CGSize(width: 50, height: 50)
//    //    star.size = CGSize(width: 10, height: 10)
//    
//    star.position = CGPoint(x: Int(arc4random() %  150), y: Int(arc4random() % 200))
//    
//    
//    star.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: 6.5, height: 6.5))
//    scene.addChild(star)
//








//
//let square = UIView(frame: CGRect(x: 100,  y: 100, width: 100, height: 100))
//square.backgroundColor = UIColor.purple
//
//let stuffedAnimalNames = ["bear.jpg", "unicorn.jpg", "duck.jpg"]
//let images = stuffedAnimalNames.map { UIImage(named: $0) }
//
//let bear = UIImageView(image: images[0])
//bear.frame = CGRect(x: 100, y: 100, width: 60, height: 60)
//
//let ooni = UIImageView(image: images[1])
//ooni.frame = CGRect(x: 105, y: 100, width: 60, height: 60)
//
//let quacky = UIImageView(image: images[2])
//quacky.frame = CGRect(x: 110, y: 100, width: 60, height: 60)
//
//
//containerView.addSubview(bear)
//containerView.addSubview(ooni)
//containerView.addSubview(quacky)
//
//// FIXME: Can I make these optional
//var animator: UIDynamicAnimator!
//var gravity: UIGravityBehavior!
//var collision: UICollisionBehavior!
//
//let dynamicItems = [bear, ooni, quacky]
//
//animator = UIDynamicAnimator(referenceView: containerView)
//gravity = UIGravityBehavior(items: dynamicItems)
//animator.addBehavior(gravity)
//
//
//
//// claw machine mouth barrier
let barrierMouthLeft = UIView(frame: CGRect(x: 40, y: 300, width: 5, height: 100))
barrierMouthLeft.backgroundColor = UIColor.gray

containerView.addSubview(barrierMouthLeft)
let barrierMouthRight = UIView(frame: CGRect(x: 140, y: 300, width: 5, height: 100))
barrierMouthRight.backgroundColor = UIColor.gray
containerView.addSubview(barrierMouthRight)

//barrierMouthLeft.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin] // adjusts only on iPad
//
//
//collision = UICollisionBehavior(items: dynamicItems)
//// translates uses the bounds of the reference view, aka container
//collision.translatesReferenceBoundsIntoBoundary = true
//animator.addBehavior(collision)
//
//collision.addBoundary(withIdentifier: "barrierMouthLeft" as NSCopying, for: UIBezierPath(rect: barrierMouthLeft.frame))
//collision.addBoundary(withIdentifier: "barrierMouthright" as NSCopying, for: UIBezierPath(rect: barrierMouthRight.frame))
//
////let window = container.gameWindowRight
////collision.addBoundary(withIdentifier: "window" as NSCopying, for: UIBezierPath(rect: window.frame))
//
