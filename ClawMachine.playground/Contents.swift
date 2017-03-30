//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

ClawMachine.setup()

// Create stuffed animal sprites
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "bear3.png"), quantity: 1)
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-goldi.png"), quantity: 1)
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-giraffee.png"), quantity: 1)
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-bunny.png"), quantity: 1)
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-bully.png"), quantity: 1)

// Experiment with the strength of the claw by adjusting force used to open and close it
Claw.openStrength = 60
Claw.closeStrength = 100

// TODO: Customize speed of claw (duration in the repeating action)


// TODO: Customize skin of machine
// TODO: Add name at the top in a font?
// TODO: Sound of stuffed animal at bottom??


//ClawMachine.name = "Rachel"

