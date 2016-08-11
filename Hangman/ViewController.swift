//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Banh on 8/8/16.
//  Copyright © 2016 Flybu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var HangmanWord: UILabel!
    
    @IBOutlet weak var Message: UILabel!
    
    @IBOutlet weak var hangmanView: HangmanView!
    
    private var Brain = HangmanBrain()
    
    private var gameOver = false

    @IBAction func Letter(sender: UIButton) {
        if (!gameOver) {
            let oldCode = HangmanWord.text
            var newCode = ""
            if let letter = sender.currentTitle {
                newCode = Brain.checkLetter(letter, oldCode: oldCode!)
            }
            HangmanWord.text = newCode
            if (oldCode == newCode) {
                Message.text = "Try Again!"
                hangmanView.wrongs += 1
            } else {
                Message.text = "Nice Job!"
                if (newCode.rangeOfString("_") == nil) {
                    Message.text = "You win!"
                    gameOver = true
                }
            }
            if (hangmanView.wrongs == 6) {
                Message.text = "Game Over!"
                gameOver = true
                HangmanWord.text = Brain.showAnswer()
            }
        }
    }
    

}

