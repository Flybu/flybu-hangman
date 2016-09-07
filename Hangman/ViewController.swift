//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Banh on 8/8/16.
//  Copyright © 2016 Flybu. All rights reserved.
//
//  Test Comment

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var HangmanWord: UILabel!
    
    @IBOutlet weak var Message: UILabel!
    
    @IBOutlet weak var hangmanView: HangmanView!
    
    private var Brain = HangmanBrain()
    
    private var gameOver = true

    @IBAction func Start_Reset(sender: UIButton) {
        hangmanView.wrongs = 0
        HangmanWord.text = Brain.startOrResetGame()
        Message.text = "Good Luck!"
        sender.setTitle("Reset", forState: UIControlState.Normal)
        gameOver = false
    }

    @IBAction func Letter(sender: UIButton) {
        if (!gameOver) {
            let oldCode = HangmanWord.text
            var newCode = ""
            if let letter = sender.currentTitle {
                if (!Brain.checkIfUsed(letter)) {
                    Brain.markAsUsed(letter)
                    newCode = Brain.checkLetter(letter, oldCode: oldCode!)
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
                } else {
                    Message.text = "You already tried that!"
                }
            }
        }
    }
    

}

