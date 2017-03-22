//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport


// bitmasks to set collide detection for sprites
public let contactDetectorCategory: UInt32 =  0x1 << 0
public let stuffedAnimalCategory: UInt32 =  0x1 << 1
public let clawCategory: UInt32 = 0x1 << 2
public let groundCategory: UInt32 = 0x1 << 3


public var hasReturnedToStart = false


// Motor
let motorTexture = SKTexture(image: #imageLiteral(resourceName: "claw-motor.png"))
let motor = SKSpriteNode(texture: motorTexture)
motor.size = CGSize(width: 28, height: 41)
motor.position = CGPoint(x: 100, y: 150)
motor.physicsBody = SKPhysicsBody(texture: motorTexture, size: CGSize(width: 28, height: 41))
motor.physicsBody?.affectedByGravity = false
motor.physicsBody?.isDynamic = false

motor.physicsBody?.collisionBitMask = 0


let moveNodeLeft = SKAction.moveBy(x: -100.0,
                                   y: 20.0,
                                   duration: 2.0)


let openLeftClaw = SKAction.moveBy(x: -5.0,
                                   y: 0.0,
                                   duration: 2.0)

let moveNodeDown = SKAction.moveBy(x: 0.0,
                                   y: -100.0,
                                   duration: 3.0)

let wait = SKAction.wait(forDuration: 1.5)


public func pauseAction() {
    motor.removeAllActions()
    let sequence = SKAction.sequence([wait, moveNodeDown.reversed()])
    motor.run(sequence)
    //    motor.run(wait)
    //    motor.run(moveNodeDown.reversed())
    
    hasReturnedToStart = true
    
}



let physicsContainerView = SKView(frame: CGRect(x: 20, y: 90, width: 392, height: 200))
public let scene = SKScene(size: CGSize(width: 392, height: 200))



physicsContainerView.showsPhysics = true
physicsContainerView.showsFields = true

scene.backgroundColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0) // pale robin egg blue: #98E3D4
scene.scaleMode = SKSceneScaleMode.aspectFit

physicsContainerView.presentScene(scene)


PlaygroundPage.current.liveView = physicsContainerView
PlaygroundPage.current.needsIndefiniteExecution = true






// CLAW SPRITES

// Detector
let contactDetector = SKShapeNode(rectOf: CGSize(width: motor.frame.width/2+5, height: 5))
contactDetector.fillColor = UIColor.clear
contactDetector.position = CGPoint(x: motor.position.x, y: motor.position.y-20)

contactDetector.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: contactDetector.frame.width, height: contactDetector.frame.height))

contactDetector.physicsBody?.affectedByGravity = false
contactDetector.physicsBody?.isDynamic = true

contactDetector.physicsBody?.categoryBitMask = contactDetectorCategory
contactDetector.physicsBody?.contactTestBitMask = stuffedAnimalCategory
contactDetector.physicsBody?.collisionBitMask = stuffedAnimalCategory
contactDetector.name = "detector"

contactDetector.physicsBody?.allowsRotation = false
contactDetector.physicsBody?.angularVelocity = 0




// Left Claw
let leftClawTexture = SKTexture(image: #imageLiteral(resourceName: "claw-left.png"))
let leftClaw = SKSpriteNode(texture: leftClawTexture)
leftClaw.size = CGSize(width: 26, height: 47)
leftClaw.position = CGPoint(x: motor.position.x-22, y: motor.position.y-30)
leftClaw.physicsBody = SKPhysicsBody(texture: leftClawTexture, size: CGSize(width: 26, height: 47))

leftClaw.physicsBody?.affectedByGravity = true
leftClaw.physicsBody?.isDynamic = true


leftClaw.physicsBody?.categoryBitMask = clawCategory
leftClaw.physicsBody?.contactTestBitMask = stuffedAnimalCategory
leftClaw.physicsBody?.collisionBitMask = stuffedAnimalCategory | groundCategory


//leftClaw.physicsBody?.affectedByGravity = false
//leftClaw.physicsBody?.isDynamic = false

// Right Claw
let rightClawTexture = SKTexture(image: #imageLiteral(resourceName: "claw-right.png"))
let rightClaw = SKSpriteNode(texture: rightClawTexture)
rightClaw.size = CGSize(width: 26, height: 47)
rightClaw.position = CGPoint(x: motor.position.x+22, y: motor.position.y-30)
rightClaw.physicsBody = SKPhysicsBody(texture: rightClawTexture, size: CGSize(width: 26, height: 47))

rightClaw.physicsBody?.affectedByGravity = true
rightClaw.physicsBody?.isDynamic = true


rightClaw.physicsBody?.categoryBitMask = clawCategory
rightClaw.physicsBody?.contactTestBitMask = stuffedAnimalCategory
rightClaw.physicsBody?.collisionBitMask = stuffedAnimalCategory | groundCategory

//rightClaw.physicsBody?.affectedByGravity = false
//rightClaw.physicsBody?.isDynamic = false


//motor.anchorPoint = CGPoint(x: 0, y: 0)
//motor.anchorPoint = CGPoint(x: motor.frame.maxX, y: 0)

// SET POSITION OF CLAWS
let leftClawPosition = leftClaw.position
let rightClawPosition = rightClaw.position

// add to scene before joint
scene.addChild(motor)
scene.addChild(contactDetector)
scene.addChild(leftClaw)
scene.addChild(rightClaw)


print(leftClaw.frame.maxX)
print(motor.frame.minX)
print(motor.frame.minY)


let leftClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: leftClaw.physicsBody!, anchor: CGPoint(x: leftClaw.frame.maxX, y: motor.frame.minY))


let rightClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: rightClaw.physicsBody!,
                                             anchor: CGPoint(x: rightClaw.frame.minX, y: motor.frame.minY))

leftClawJoint.shouldEnableLimits = true
rightClawJoint.shouldEnableLimits = true

// change 0 to 5 for a shakier claw
leftClawJoint.upperAngleLimit = CGFloat(GLKMathDegreesToRadians(0))
leftClawJoint.lowerAngleLimit = CGFloat(GLKMathDegreesToRadians(-45))

rightClawJoint.upperAngleLimit = CGFloat(GLKMathDegreesToRadians(45))
rightClawJoint.lowerAngleLimit = CGFloat(GLKMathDegreesToRadians(0))


// detector joint
let contactDetectorJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: contactDetector.physicsBody!, anchor: CGPoint(x: motor.position.x, y: motor.position.y))





// remove spring from claw
public var springs = [SKPhysicsJointSpring]()

class Collision: NSObject, SKPhysicsContactDelegate, SKSceneDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("didBegin?")
        
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        
        if (collision == (contactDetectorCategory | stuffedAnimalCategory)) {
            print("bear")
            pauseAction()
        }
    }
    
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        if hasReturnedToStart {
            for spring in springs {
                print("#####SPRING: \(spring)")
                scene.physicsWorld.remove(spring)
                if let index = springs.index(of: spring) {
                    springs.remove(at: index)
                    
                    let clawSpringJoint = SKPhysicsJointSpring.joint(withBodyA: leftClaw.physicsBody!, bodyB: rightClaw.physicsBody!, anchorA: CGPoint(x: leftClaw.position.x+25, y: leftClaw.position.y-15), anchorB: CGPoint(x: rightClaw.position.x-25, y: rightClaw.position.y-15))
                    clawSpringJoint.frequency = 9.0
                    clawSpringJoint.damping = 1.0
                    
                    scene.physicsWorld.add(clawSpringJoint)
                }
            }
        }
    }
}



let clawSpringJoint = SKPhysicsJointSpring.joint(withBodyA: leftClaw.physicsBody!, bodyB: rightClaw.physicsBody!, anchorA: CGPoint(x: leftClaw.position.x+25, y: leftClaw.position.y-15), anchorB: CGPoint(x: rightClaw.position.x-25, y: rightClaw.position.y-15))
clawSpringJoint.frequency = 9.0
clawSpringJoint.damping = 1.0


// the delegate must be owned by something
// setting contactDelegate = Collision() will not work without first creating a variable
let delegate = Collision()

scene.physicsWorld.contactDelegate = delegate
scene.delegate = delegate

scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
scene.physicsWorld.add(leftClawJoint)
scene.physicsWorld.add(rightClawJoint)
scene.physicsWorld.add(contactDetectorJoint)
scene.physicsWorld.add(clawSpringJoint)

springs.append(clawSpringJoint)


let boundary = SKPhysicsBody(edgeLoopFrom: scene.frame)
boundary.categoryBitMask = groundCategory
scene.physicsBody = boundary
//scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)



//let bearTexture = SKTexture(image: #imageLiteral(resourceName: "bear3.png"))
let bearTexture = SKTexture(image: #imageLiteral(resourceName: "bear3.png"))
for _ in 1 ... 5 {
    let bear = SKSpriteNode(texture: bearTexture)
    bear.size = CGSize(width: 60, height: 60)
    //    bear.position = CGPoint(x: Int(arc4random_uniform(141)+200), y: Int(arc4random_uniform(251) + 250))
    
    bear.position = CGPoint(
        x: Int(arc4random_uniform(300)),
        y: Int(arc4random_uniform(50)))

//        x: 175,
//        y: 50)
    
    bear.physicsBody = SKPhysicsBody(texture: bearTexture, size: CGSize(width: 50, height: 50))
    bear.physicsBody?.affectedByGravity = true
    
    bear.physicsBody?.isDynamic = true
    bear.physicsBody?.categoryBitMask = stuffedAnimalCategory
    bear.physicsBody?.contactTestBitMask = contactDetectorCategory
    bear.physicsBody?.collisionBitMask = groundCategory | clawCategory
//    bear.physicsBody?.usesPreciseCollisionDetection = true
    bear.name = "stuffedAnimal"
    
    scene.addChild(bear)
}

let duckTexture = SKTexture(image: #imageLiteral(resourceName: "duck.png"))
for _ in 1 ... 5 {
    let duck = SKSpriteNode(texture: duckTexture)
    duck.size = CGSize(width: 60, height: 50)
    duck.position = CGPoint(
        x: Int(arc4random_uniform(300)),
        y: Int(arc4random_uniform(50)))
    duck.physicsBody = SKPhysicsBody(texture: duckTexture, size: CGSize(width: 50, height: 40))
    duck.physicsBody?.affectedByGravity = true
    
    duck.physicsBody?.isDynamic = true
    duck.physicsBody?.categoryBitMask = stuffedAnimalCategory
    duck.physicsBody?.contactTestBitMask = contactDetectorCategory
    duck.physicsBody?.collisionBitMask = groundCategory | clawCategory
    //    duck.physicsBody?.usesPreciseCollisionDetection = true
    duck.name = "stuffedAnimal"
    
    scene.addChild(duck)
}





//let bear = SKSpriteNode(texture: bearTexture)
//bear.size = CGSize(width: 60, height: 60)
//bear.position = CGPoint(
//    x: 260, y: 0)
//
//bear.physicsBody = SKPhysicsBody(texture: bearTexture, size: CGSize(width: 30, height: 30))
//bear.physicsBody?.affectedByGravity = true
//scene.addChild(bear)
//
//let bear2 = SKSpriteNode(texture: bearTexture)
//bear2.size = CGSize(width: 60, height: 60)
//bear2.position = CGPoint(
//    x: 250, y: 0)
//
//bear2.physicsBody = SKPhysicsBody(texture: bearTexture, size: CGSize(width: 30, height: 30))
//bear2.physicsBody?.affectedByGravity = true
//scene.addChild(bear2)






// Movement of claw

let moveNodeRight = SKAction.moveBy(x: 100.0,
                                    y: 0.0,
                                    duration: 2.0)



func moveClaw() {
    let sequence = SKAction.sequence([moveNodeRight, moveNodeDown, wait, moveNodeDown.reversed(), moveNodeRight.reversed()])
//    let sequence = SKAction.sequence([moveNodeRight, moveNodeDown, moveNodeDown.reversed(), moveNodeRight.reversed()])
    motor.run(sequence)
    
//    let moveLeft = SKAction.moveBy(x: -10.0,
//                                        y: 0.0,
//                                        duration: 2.0)
//    leftClaw.run(moveLeft)
}

moveClaw()


