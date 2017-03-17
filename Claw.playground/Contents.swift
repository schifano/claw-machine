//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

let physicsContainerView = SKView(frame: CGRect(x: 20, y: 90, width: 392, height: 450))
let scene = SKScene(size: CGSize(width: 392, height: 450))

//physicsContainerView.showsPhysics = true
physicsContainerView.showsFields = true

scene.backgroundColor = UIColor(red: 152/255, green: 227/255, blue: 212/255, alpha: 1.0) // pale robin egg blue: #98E3D4
scene.scaleMode = SKSceneScaleMode.aspectFit

physicsContainerView.presentScene(scene)

PlaygroundPage.current.liveView = physicsContainerView
PlaygroundPage.current.needsIndefiniteExecution = true


// CLAW SPRITES
// Motor
let motorTexture = SKTexture(image: #imageLiteral(resourceName: "claw-motor.png"))
let motor = SKSpriteNode(texture: motorTexture)
motor.size = CGSize(width: 28, height: 41)
motor.position = CGPoint(x: 100, y: 300)
motor.physicsBody = SKPhysicsBody(texture: motorTexture, size: CGSize(width: 28, height: 41))
motor.physicsBody?.affectedByGravity = false
motor.physicsBody?.isDynamic = false

// Left Claw
let leftClawTexture = SKTexture(image: #imageLiteral(resourceName: "claw-left.png"))
let leftClaw = SKSpriteNode(texture: leftClawTexture)
leftClaw.size = CGSize(width: 26, height: 47)
leftClaw.position = CGPoint(x: motor.position.x-22, y: motor.position.y-30)
leftClaw.physicsBody = SKPhysicsBody(texture: leftClawTexture, size: CGSize(width: 26, height: 47))

leftClaw.physicsBody?.affectedByGravity = true
leftClaw.physicsBody?.isDynamic = true

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

//rightClaw.physicsBody?.affectedByGravity = false
//rightClaw.physicsBody?.isDynamic = false

// SET POSITION OF CLAWS
let leftClawPosition = leftClaw.position
let rightClawPosition = rightClaw.position

// add to scene before joint
scene.addChild(motor)
scene.addChild(leftClaw)
scene.addChild(rightClaw)




//let leftClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: leftClaw.physicsBody!, anchor: CGPoint(x: motor.frame.maxX, y: leftClaw.frame.minY))

let leftClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: leftClaw.physicsBody!, anchor:
    CGPoint(x:leftClawPosition.x, y: leftClawPosition.y+30))

//let rightClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: rightClaw.physicsBody!, anchor: rightClawPosition)

let rightClawJoint = SKPhysicsJointPin.joint(withBodyA: motor.physicsBody!, bodyB: rightClaw.physicsBody!,
anchor: CGPoint(x: rightClawPosition.x, y: rightClawPosition.y+30))


scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
scene.physicsWorld.add(leftClawJoint)
scene.physicsWorld.add(rightClawJoint)


// Movement of claw
func moveClaw() {
    let moveNodeRight = SKAction.moveBy(x: 150.0,
                                        y: 0.0,
                                        duration: 2.0)
    let moveNodeDown = SKAction.moveBy(x: 0.0,
                                       y: -100.0,
                                       duration: 1.0)
    
    let sequence = SKAction.sequence([moveNodeRight, moveNodeDown, moveNodeDown.reversed(), moveNodeRight.reversed()])
    motor.run(sequence)
}

moveClaw()
