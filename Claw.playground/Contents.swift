//: Playground - noun: a place where people can play

import UIKit
import Claw_Sources

// setup scene
Setup.setupContainer()

// create sprites
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "bear3.png"))
Sprites.createStuffedAnimal(image: #imageLiteral(resourceName: "duck.png"))

// move motor
Claw.moveClaw(motor: Sprites.createMotorSprite())
