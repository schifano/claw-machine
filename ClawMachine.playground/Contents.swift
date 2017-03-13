//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let container = Container()
container.setup()
//container.getContainerSize()

// TODO: Generate multiple items on screen
// TODO: Physics drop items




// UIKit Dynamics - drop things
let containerView = container.viewController.view

let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
square.backgroundColor = UIColor.purple

let stuffedAnimalNames = ["bear.jpg", "unicorn.jpg", "duck.jpg"]
let images = stuffedAnimalNames.map { UIImage(named: $0) }

let bear = UIImageView(image: images[0])
bear.frame = CGRect(x: 100, y: 100, width: 100, height: 100)

let ooni = UIImageView(image: images[1])
ooni.frame = CGRect(x: 180, y: 120, width: 100, height: 100)

let quacky = UIImageView(image: images[2])
quacky.frame = CGRect(x: 200, y: 105, width: 100, height: 100)

containerView?.addSubview(bear)
containerView?.addSubview(ooni)
containerView?.addSubview(quacky)

// FIXME: Can I make these optional
var animator: UIDynamicAnimator!
var gravity: UIGravityBehavior!
var collision: UICollisionBehavior!

let dynamicItems = [bear, ooni, quacky]

animator = UIDynamicAnimator(referenceView: containerView!)
gravity = UIGravityBehavior(items: dynamicItems)
animator.addBehavior(gravity)

collision = UICollisionBehavior(items: dynamicItems)
// translates uses the bounds of the reference view, aka container
collision.translatesReferenceBoundsIntoBoundary = true
animator.addBehavior(collision)
