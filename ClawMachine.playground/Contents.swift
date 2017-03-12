//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let container = Container()
container.setup()
container.getContainerSize()

// TODO: Generate multiple items on screen
// TODO: Physics drop items

// UIKit Dynamics - drop things

let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
square.backgroundColor = UIColor.purple

container.viewController.view.addSubview(square)

var animator: UIDynamicAnimator!
var gravity: UIGravityBehavior!

animator = UIDynamicAnimator(referenceView: container.viewController.view)
gravity = UIGravityBehavior(items: [square])
animator.addBehavior(gravity)