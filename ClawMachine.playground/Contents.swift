//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

ClawMachine.setup()

// Create stuffed animal sprites
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-giraffee.png"), quantity: 2) // Giraffee
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-bunny.png"), quantity: 4) // Bunny
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-bully.png"), quantity: 2) // Bully

//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-oinky.png"), quantity: 1)


//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-goldi.png"), quantity: 1)
//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-toffee.png"), quantity: 1)

//Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-beary.png"), quantity: 1) // Beary

// Experiment with the strength of the claw
// Adjust force used to open and close it
Claw.openStrength = 60
Claw.closeStrength = 100

// Change shape of claw

