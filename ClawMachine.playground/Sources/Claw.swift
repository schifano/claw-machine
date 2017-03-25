import SpriteKit

struct Actions {
    static let up = SKAction.moveBy(x: 0.0, y: 6.0, duration: 0.1)
    static let down = SKAction.moveBy(x: 0.0, y: -6.0, duration: 0.1)
    static let left = SKAction.moveBy(x: -6.0, y: 0.0, duration: 0.1)
    static let right = SKAction.moveBy(x: 6.0, y: 0.0, duration: 0.1)
    
    static let wait = SKAction.wait(forDuration: 1.5)
}

// FIXME: handle collision with glass



public struct ClawSprites {
    public static let motor = Sprites.createMotorSprite()
    static let leftClaw = Sprites.createLeftClawSprite()
    static let rightClaw = Sprites.createRightClawSprite()
    static let contactDetector = Sprites.createContactDetectorSprite()
}

public class Claw {

    
    static var trackedActions = [SKAction]() // FIXME: Probably not needed
    
    public static var hasReturnedToStart = false
    
    public static func pauseMotorAction() {
        ClawSprites.motor.removeAllActions()
        hasReturnedToStart = true
    }
    
//    public static func moveClaw(motor: SKSpriteNode) {
//        let sequence = SKAction.sequence([Actions.moveMotorRight, Actions.moveMotorDown, Actions.wait, Actions.moveMotorDown.reversed(), Actions.moveMotorRight.reversed()])
//        motor.run(sequence)
//    }
    
    
    // MARK: Apply Force
    static func applyForceToOpen(leftClaw: SKSpriteNode, rightClaw: SKSpriteNode) {
        
        // ######## LEFT CLAW
        // Experiment with force
        let degreesInRadians = GLKMathDegreesToRadians(45)
        // determine vector components and direction
        let dx = cosf(degreesInRadians)
        let dy = sinf(degreesInRadians)
        // 5 represents scale of force
        let forceVector = CGVector(dx: CGFloat(dx*500), dy: CGFloat(dy*500))
        let leftClawPoint = CGPoint(x: leftClaw.position.x, y: leftClaw.position.y)
        leftClaw.physicsBody?.applyForce(forceVector, at: leftClawPoint)
        
        
        
        // ######## RIGHT CLAW
        // Experiment with force
        let degreesInRadians2 = GLKMathDegreesToRadians(45)
        // determine vector components and direction
        let dx2 = cosf(degreesInRadians2)
        let dy2 = sinf(degreesInRadians2)
        // 5 represents scale of force
        let forceVector2 = CGVector(dx: CGFloat(dx2*500), dy: CGFloat(dy2*500))
        let rightClawPoint = CGPoint(x: rightClaw.position.x, y: rightClaw.position.y)
        rightClaw.physicsBody?.applyForce(forceVector2, at: rightClawPoint)
        
    }

    
//    static func moveClawLeft() {
//        print("left")
//        if ClawSprites.motor.position.x > Container.gameWindowShape.frame.minX+100 {
//            ClawSprites.motor.run(moveLeft)
//        }
//    }
    
    

    

    
    static func moveClawDown(finished: () -> Void) {
        print("down")

        ClawSprites.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    Actions.down,
                    SKAction.run({
                        //Code you want to execute
                        if ClawSprites.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
                            ClawSprites.motor.removeAction(forKey: "moveDown")
                        }
                        
                        if ClawSprites.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
                            ClawSprites.motor.removeAction(forKey: "moveDown")
                        }
                    })
                ])
            ),
            withKey: "moveDown"
        )
        finished()
    }

    
    
//    static func moveClawDown() {
//        print("down")
//        
//        while ClawSprites.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
//            ClawSprites.motor.run(<#T##action: SKAction##SKAction#>, completion: <#T##() -> Void#>)
//        }
//        ClawSprites.motor.run(
//            SKAction.repeatForever (
//                SKAction.sequence([
//                    down,
//                    SKAction.run({
//                        //Code you want to execute
//                        if ClawSprites.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
//                            ClawSprites.motor.removeAction(forKey: "moveDown")
//                        }
//                        
//                        if ClawSprites.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
//                            ClawSprites.motor.removeAction(forKey: "moveDown")
//                        }
//                    })
//                    ])
//            ),
//            withKey: "moveDown"
//        )
//        finished()
//    }
//
    
//    
//    static func moveClawUp(finished: () -> Void) {
//        print("up")
//
//
//        ClawSprites.motor.run(
//            SKAction.repeatForever (
//                SKAction.sequence([
//                    up,
//                    SKAction.run({
//                        //Code you want to execute
//                        if ClawSprites.motor.frame.maxY >= Container.gameWindowShape.frame.maxY-10 {
//                            ClawSprites.motor.removeAction(forKey: "moveUp")
//                        }
//                    })
//                    ])
//            ),
//            withKey: "moveUp"
//        )
//        finished()
//    }

    
    
    static var counter = 0
    static func removeClawActions(contactMadeWithStuffedAnimal: Bool) {
        if contactMadeWithStuffedAnimal {
            closeClaw()
            returnClawHome()
        } else {
            ClawSprites.motor.removeAllActions()
        }
    }
    
    
    // this may need to be done by moving claw until it returns home
    static func returnClawHome() {
        print("return claw home")

        // user must wait for claw to return to try again
        Container.button.isUserInteractionEnabled = false
        
        let block2 = SKAction.run({
            
            ClawSprites.motor.run(
                SKAction.repeatForever (
                    SKAction.sequence([
                        SKAction.run({
                            //Code you want to execute
                            if ClawSprites.leftClaw.position.x <= 50 {
                                ClawSprites.motor.removeAction(forKey: "moveLeft")
//                                    ClawSprites.motor.run(left)
                                Container.button.isUserInteractionEnabled = true
                            }
                        }),
                        Actions.left
                        ])
                ),
                withKey: "moveLeft"
            )
            
        })
        
        
        let block1 = SKAction.run({
            
            ClawSprites.motor.run(
                SKAction.repeatForever (
                    SKAction.sequence([
                        SKAction.run({
                            //Code you want to execute
                            if ClawSprites.motor.frame.maxY >= Container.gameWindowShape.frame.maxY-10 {
                                    print("made it up")
                                    ClawSprites.motor.run(block2)
                                ClawSprites.motor.removeAction(forKey: "moveUp")
                                
                            }
                        }),
                        Actions.up
                        ])
                ),
                withKey: "moveUp"
            )
            
        })
        
        
        
        
        
        let block0 = SKAction.run({
            
            ClawSprites.motor.run(
            SKAction.repeatForever (
                SKAction.sequence([
                    SKAction.run({
                        
                        //Code you want to execute
                        // FIXME: if one has been hit, don't check the other
                        if ClawSprites.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
                            ClawSprites.motor.removeAction(forKey: "moveDown")
                            ClawSprites.motor.run(block1)
                        } else if ClawSprites.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
                            ClawSprites.motor.removeAction(forKey: "moveDown")
                            ClawSprites.motor.run(block1)
                        }
                    }),
                    Actions.down
                    ])
            ),
            withKey: "moveDown"
            )
        })
        


        
        
        // MARK: METHODS

        
//        DispatchQueue.main.async {
//            ClawSprites.motor.run(block0,
//                completion: {() -> Void in
//                    print("down")
//                    DispatchQueue.main.async {
//                        ClawSprites.motor.run(block1)
//                        print("up")
//                    }
//            })
//        }
        
        
//        ClawSprites.motor.run(block0,
//            completion: {() -> Void in
//                print("down complete")
//                ClawSprites.motor.run(block1,
//                    completion: {() -> Void in
//                        print("up complete")
//                        ClawSprites.motor.run(block2,
//                            completion: {() -> Void in
//                                print("left complete")
//                            })
//                    })
//            })
//    

        
        let sequence = SKAction.sequence([block0])
        ClawSprites.motor.run(sequence)
    }
    
    

//    ClawSprites.motor.run(
//    SKAction.repeatForever (
//    SKAction.sequence([
//    SKAction.run({
//    
//    //Code you want to execute
//    // FIXME: if one has been hit, don't check the other
//    if ClawSprites.leftClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
//    ClawSprites.motor.removeAction(forKey: "moveDown")
//    ClawSprites.motor.run(block1)
//    } else if ClawSprites.rightClaw.frame.minY <= Container.gameWindowShape.frame.minY+10 {
//    ClawSprites.motor.removeAction(forKey: "moveDown")
//    ClawSprites.motor.run(block1)
//    }
//    }),
//    Actions.down
//    ])
//    ),
//    withKey: "moveDown"
//    )
    
    
    
    static let moveRight = SKAction.repeatForever(Actions.right)
    static func moveClawRight() {
        if ClawSprites.motor.position.x < Container.gameWindowShape.frame.maxX-60 && ClawSprites.motor.position.x > Container.gameWindowShape.frame.minX {
            ClawSprites.motor.run(moveRight)
        }
    }
    
    
    
    static func moveDown() {
        
    }
    
    
    static func closeClaw() {
        
    }
    
}
