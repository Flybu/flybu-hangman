//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Banh on 8/8/16.
//  Copyright © 2016 Flybu. All rights reserved.
//
//  ViewController.swift provides code for the interaction between the storyboard and
//  HangmanBrain. It receives input from the view, sends relevant information to the
//  brain, and then updates elements of the view accordingly.

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties

    //  The current "code" presented to the user
    @IBOutlet weak var HangmanWord: UILabel!
    
    //  The current informational message displayed (Good luck, try again, etc)
    @IBOutlet weak var Message: UILabel!
    
    //  Displays the number of guesses left
    @IBOutlet weak var GuessesLeft: UILabel!
    
    //  Class which contains paths and methods for drawing the hangman
    @IBOutlet weak var hangmanView: HangmanView!
        
    // Set which contains the Buttons used in the game
    var buttonsSet = Set<UIButton>()
    
    //  Class which processes the actual game mechanics. See HangmanBrain.swift comments for more
    private var Brain = HangmanBrain()
    
    //  Boolean which represents whether a game is currently occurring or not
    private var gameOver = true
    
    //  Keeps track of the remaining number of guesses
    private var numGuessesLeft = 5

    //  pre:  Start_Reset takes a sender of type UIButton
    //  post: On button press, Start_Reset uses HangmanBrain to reset the game to an initial 
    //        state. It additionally resets the number of wrongs in hangmanView.
    @IBAction func Start_Reset(sender: UIButton) {
        hangmanView.wrongs = 0
        HangmanWord.text = Brain.startOrResetGame()
        Message.text = "Good Luck!"
        sender.setTitle("Reset", forState: UIControlState.Normal)
        gameOver = false
        numGuessesLeft = 6
        GuessesLeft.text = "Guesses Left: " + String(numGuessesLeft)
        for button in buttonsSet {
            button.enabled = true
        }
    }

    //  pre:  Letter takes a sender of type UIButton which represents the guessed letter
    //  post: Letter uses HangmanBrain to check to see if the letter has been used. If it has
    //  not been used, the func then uses HangmanBrain to see if the letter is contained 
    //  within the target word and whether the target word has been found. Also fades the button used.
    //  Letter then updates var Message with a new message depending on the outcome.
    @IBAction func Letter(sender: UIButton) {
        if (!gameOver) {
            buttonsSet.insert(sender)
            let oldCode = HangmanWord.text
            var newCode = ""
            if let letter = sender.currentTitle {
                if (!Brain.checkIfUsed(letter)) {
                    sender.adjustsImageWhenDisabled = true
                    sender.enabled = false
                    Brain.markAsUsed(letter)
                    newCode = Brain.checkLetter(letter, oldCode: oldCode!)
                    HangmanWord.text = newCode
                    if (oldCode == newCode) {
                        Message.text = "Try Again!"
                        hangmanView.wrongs += 1
                        numGuessesLeft -= 1
                        GuessesLeft.text = "Guesses Left: " + String(numGuessesLeft)
                    } else {
                        Message.text = "Nice Job!"
                        if (newCode.rangeOfString("_") == nil) {
                            Message.text = "You win!"
                            gameOver = true
                            for button in buttonsSet {
                                button.enabled = true
                            }
                        }
                    }
                    if (hangmanView.wrongs == 6) {
                        Message.text = "Game Over!"
                        gameOver = true
                        HangmanWord.text = Brain.showAnswer()
                        for button in buttonsSet {
                            button.enabled = true
                        }
                    }
                } else {
                    Message.text = "You already tried that!"
                }
            }
        }
    }
    

}

