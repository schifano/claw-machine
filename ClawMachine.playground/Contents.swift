//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

ClawMachine.setup()

// Create your own stuffed animal sprites
// size?
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "bear3.png"), quantity: 1)
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "bunny-sprite.png"), quantity: 1)
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "ooni-sprite.png"), quantity: 1)
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "giraffee-sprite.png"), quantity: 1)
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "oinky-sprite.png"), quantity: 1)

// Experiment with the strength of the claw by adjusting force used to open and close it
Claw.openStrength = 60
Claw.closeStrength = 100

// TODO: Customize speed of claw (duration in the repeating action)


// TODO: Customize skin of machine
// TODO: Add name at the top in a font?
// TODO: Sound of stuffed animal at bottom??


ClawMachine.name = "Michelle"


//print(ClawMachine.numberOfRetriesLabel.position.x)
//print(ClawMachine.numberOfRetriesLabel.position.y)
