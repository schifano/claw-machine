//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

Container.setup()

// create sprites
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "bear3.png"), quantity: 2)
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "duck.png"), quantity: 5)

// TODO: Customize strength of claw
// TODO: Customize speed of claw (duration in the repeating action)
// TODO: Customize skin of machine


print("claw position x: \(ClawSprites.motor.position.x)")
print("claw position y: \(ClawSprites.motor.position.y)")


//claw position x: 78.6500015258789
//claw position y: 461.349975585938



