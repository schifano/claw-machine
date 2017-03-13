//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let container = Container()
container.setup()
//container.getContainerSize()

// TODO: Generate multiple items on screen
// TODO: Add overlap behavior



// UIKit Dynamics - drop things
//let containerView = container.viewController.view!

let containerView = container.clawMachineContainer

let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
square.backgroundColor = UIColor.purple

let stuffedAnimalNames = ["bear.jpg", "unicorn.jpg", "duck.jpg"]
let images = stuffedAnimalNames.map { UIImage(named: $0) }

let bear = UIImageView(image: images[0])
bear.frame = CGRect(x: 100, y: 100, width: 60, height: 60)

let ooni = UIImageView(image: images[1])
ooni.frame = CGRect(x: 105, y: 100, width: 60, height: 60)

let quacky = UIImageView(image: images[2])
quacky.frame = CGRect(x: 110, y: 100, width: 60, height: 60)

containerView.addSubview(bear)
containerView.addSubview(ooni)
containerView.addSubview(quacky)

// FIXME: Can I make these optional
var animator: UIDynamicAnimator!
var gravity: UIGravityBehavior!
var collision: UICollisionBehavior!

let dynamicItems = [bear, ooni, quacky]

animator = UIDynamicAnimator(referenceView: containerView)
gravity = UIGravityBehavior(items: dynamicItems)
animator.addBehavior(gravity)



// claw machine mouth barrier
let barrierMouthLeft = UIView(frame: CGRect(x: 50, y: 300, width: 5, height: 100))
barrierMouthLeft.backgroundColor = UIColor.gray

containerView.addSubview(barrierMouthLeft)
let barrierMouthRight = UIView(frame: CGRect(x: 150, y: 300, width: 5, height: 100))
barrierMouthRight.backgroundColor = UIColor.gray
containerView.addSubview(barrierMouthRight)

barrierMouthLeft.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin] // adjusts only on iPad


collision = UICollisionBehavior(items: dynamicItems)
// translates uses the bounds of the reference view, aka container
collision.translatesReferenceBoundsIntoBoundary = true
animator.addBehavior(collision)

collision.addBoundary(withIdentifier: "barrierMouthLeft" as NSCopying, for: UIBezierPath(rect: barrierMouthLeft.frame))
collision.addBoundary(withIdentifier: "barrierMouthright" as NSCopying, for: UIBezierPath(rect: barrierMouthRight.frame))

let window = container.gameWindowRight
collision.addBoundary(withIdentifier: "window" as NSCopying, for: UIBezierPath(rect: window.frame))

