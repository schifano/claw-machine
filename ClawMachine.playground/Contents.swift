//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

ClawMachine.setup()

// Create your own stuffed animal sprites
// size?
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "bear3.png"), quantity: 3)
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "duck.png"), quantity: 3)

// Experiment with strength of claw
Claw.openStrength = 70
Claw.closeStrength = 100

// TODO: Customize speed of claw (duration in the repeating action)


// TODO: Customize skin of machine
