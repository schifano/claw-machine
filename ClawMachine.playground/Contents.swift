//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

ClawMachine.setup()

// create sprites
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "bear3.png"), quantity: 3)
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "duck.png"), quantity: 3)

// TODO: Customize strength of claw
// TODO: Customize speed of claw (duration in the repeating action)
// TODO: Customize skin of machine
