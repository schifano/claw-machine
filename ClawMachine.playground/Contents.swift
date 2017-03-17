//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

let container = Container()
container.setup()

let containerView = container.clawMachineCabinetContainerView

let bearTexture = SKTexture(image: #imageLiteral(resourceName: "bear3.png"))
for _ in 1 ... 5 {
    let bear = SKSpriteNode(texture: bearTexture)
    bear.size = CGSize(width: 60, height: 60)
//    bear.position = CGPoint(x: Int(arc4random_uniform(141)+200), y: Int(arc4random_uniform(251) + 250))
    
    bear.position = CGPoint(
        x: Int(arc4random_uniform(340)),
        y: Int(arc4random_uniform(226) + 190))
    
    bear.physicsBody = SKPhysicsBody(texture: bearTexture, size: CGSize(width: 50, height: 50))
    bear.physicsBody?.affectedByGravity = true
    container.scene.addChild(bear)
}

let duckTexture = SKTexture(image: #imageLiteral(resourceName: "duck.png"))
for _ in 1 ... 5 {
    let duck = SKSpriteNode(texture: duckTexture)
    duck.size = CGSize(width: 60, height: 50)
    duck.position = CGPoint(x: Int(arc4random_uniform(141)+200), y: Int(arc4random_uniform(251) + 250))
    duck.physicsBody = SKPhysicsBody(texture: duckTexture, size: CGSize(width: 50, height: 40))
    duck.physicsBody?.affectedByGravity = true
    container.scene.addChild(duck)
}


//// claw machine mouth barrier
//let barrierMouthLeft = UIView(frame: CGRect(x: 40, y: 220, width: 5, height: 100))
//barrierMouthLeft.backgroundColor = UIColor.gray
//
//containerView.addSubview(barrierMouthLeft)
//let barrierMouthRight = UIView(frame: CGRect(x: 140, y: 220, width: 5, height: 100))
//barrierMouthRight.backgroundColor = UIColor.gray
//containerView.addSubview(barrierMouthRight)
