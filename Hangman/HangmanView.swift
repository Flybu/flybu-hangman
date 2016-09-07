//
//  HangmanView.swift
//  Hangman
//
//  Created by Alex Banh on 8/8/16.
//  Copyright © 2016 Flybu. All rights reserved.
//
//  HangmanView.swift provides code for the paths and drawing of the gallows image and the 
//  hangman image. HangmanView is called by ViewController.swift in order to update the hangman 
//  image accordingly for every guess.

import UIKit

//  Code to render live preview of drawings in Storyboard
@IBDesignable

class HangmanView: UIView {
    
    //  Represents the number of wrong guesses. Can also check to see if value was changed externally
    @IBInspectable var wrongs: Int = 0 {
        didSet {
            if wrongs <= 6 {
                setNeedsDisplay()           //  Don't exactly understand this code yet
            }
        }
    }
    
    //  Represents the scale of the drawings. 1.00 and 0.00 are 100% and 0%, respectively
    var scale: CGFloat = 1.00
    
    //  Represents a relative unit of width to be used
    var relWidth: CGFloat {
        return (bounds.width/8) * scale
    }
    
    //  Represents a relative unit of height to be used
    var relHeight: CGFloat {
        return (bounds.height/8) * scale
    }
    
    //  Represents a value for the radius of the skull
    var skullRadius: CGFloat {
        return relHeight / 2
    }
    
    //  A point which represents the center point for the hangman's head
    var skullCenter: CGPoint {
        return CGPoint(x: relWidth * 6, y: (relHeight * 3) + skullRadius)
    }
    
    //  returns a path representing the path to follow for drawing the gallows
    private func pathForGallows() -> UIBezierPath {
        let gallowPath = UIBezierPath()
        gallowPath.moveToPoint(CGPoint(x:relWidth,y:(relHeight)*7))
        gallowPath.addLineToPoint(CGPoint(x:(relWidth)*5, y:(relHeight)*7))
        gallowPath.moveToPoint(CGPoint(x:(relWidth)*3, y:(relHeight)*7))
        gallowPath.addLineToPoint(CGPoint(x:(relWidth)*3, y:(relHeight)*2))
        gallowPath.addLineToPoint(CGPoint(x:(relWidth)*6, y:(relHeight)*2))
        gallowPath.addLineToPoint(CGPoint(x:(relWidth)*6, y:(relHeight)*3))
        gallowPath.lineWidth = 5.0
        return gallowPath
    }
    
    //  returns a path representing the path to follow for drawing the head
    private func pathForHead() -> UIBezierPath {
        let headPath = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        return headPath
    }
    
    //  returns a path representing the path to follow for drawing the body
    private func pathForBody() -> UIBezierPath {
        let bodyPath = UIBezierPath()
        bodyPath.moveToPoint(CGPoint(x: relWidth * 6, y: relHeight * 4))
        bodyPath.addLineToPoint(CGPoint(x: relWidth * 6, y: relHeight * 5 + relHeight / 2))
        return bodyPath
    }
    
    //  returns a path representing the path to follow for drawing a leg
    private func pathForLeg(x_value: CGFloat) -> UIBezierPath {
        let legPath = UIBezierPath()
        legPath.moveToPoint(CGPoint(x: relWidth * 6, y: relHeight * 5.5))
        legPath.addLineToPoint(CGPoint(x: relWidth * x_value, y: relHeight * 6.5))
        return legPath
    }
    
    //  returns a path representing the path to follow for drawing an arm
    private func pathForArm(x_value: CGFloat) -> UIBezierPath {
        let armPath = UIBezierPath()
        armPath.moveToPoint(CGPoint(x: relWidth * 6, y: relHeight * 4.5))
        armPath.addLineToPoint(CGPoint(x: relWidth * x_value, y: relHeight * 4))
        return armPath
    }

    //  draws various hangman paths depending on the number of guesses which have been used
    override func drawRect(rect: CGRect) {
        pathForGallows().stroke()
        if (wrongs >= 1) {
            pathForHead().stroke()
        }
        if (wrongs >= 2) {
            pathForBody().stroke()
        }
        if (wrongs >= 3) {
            pathForLeg(5).stroke()
        }
        if (wrongs >= 4) {
            pathForLeg(7).stroke()
        }
        if (wrongs >= 5) {
            pathForArm(4.5).stroke()
        }
        if (wrongs >= 6) {
            pathForArm(7.5).stroke()
        }
    }


}
