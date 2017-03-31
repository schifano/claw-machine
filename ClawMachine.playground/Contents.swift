//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

ClawMachine.setup()

// Hold down the button to move the crane!
// Release the button to attempt a prize

// Create stuffed animal sprites
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-bully.png"), quantity: 1) // Bully
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-giraffee.png"), quantity: 2) // Giraffee
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "sprite-bunny.png"), quantity: 3) // Bunny

// Experiment with the strength of the claw
// Adjust force used to open and close
Claw.openStrength = 60
Claw.closeStrength = 100