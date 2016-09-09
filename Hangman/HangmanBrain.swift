//
//  HangmanBrain.swift
//  Hangman
//
//  Created by Alex Banh on 8/8/16.
//  Copyright © 2016 Flybu. All rights reserved.
//
//  HangmanBrain.swift provides code to process a game of Hangman. It receives input from
//  ViewController.swift and returns information accordingly. HangmanBrain.swift can start/reset
//  a game, choose a new word at random, generate a code for a word, update the code for that word
//  depending on a guess, show the target word (answer), and handle letter checks to see if they
//  are within the code or not, and whether or not they have been used.

import Foundation

class HangmanBrain {
    
    //  Array containing the current dictionary of words
    private let words = ["Kathy", "Howie", "Ally", "Alex", "Grow", "Toe", "Test", "Class", "Drink", "Car", "Bar", "Surface", "Pen", "Apple", "Banana"]
    
    //  String representing the current word
    private var word = ""
    
    //  String used to keep track of all letters guessed
    private var used = ""
    
    //  pre:  checkLetter takes in a letter of type String representing a guessed letter and an
    //        oldCode of type String representing the previous "code"
    //  post: checkLetter checks to see whether the letter passed in matches with a letter or
    //        letters in the answer. checkLetter then generates a newCode which reflects whether
    //        a match was found or not. checkLetter then returns a String representing the new code
    func checkLetter(letter: String, oldCode: String) -> String {
        var newCode = ""
        let characters = [Character](letter.characters) // Converts from a string to an array of characters
        let character = characters[0]                   //  Chooses the character
        let oldCharacters = [Character](oldCode.characters)
        for (i, letter) in word.uppercaseString.characters.enumerate() {
            if (character == letter) {
                newCode += String(letter) + " "
            } else {
                let append = String(oldCharacters[i * 2]) + String(oldCharacters[i * 2 + 1])
                newCode += append
            }
        }
        return newCode
    }
    
    //  post: showAnswer returns a String which represents the current game's answer
    func showAnswer() -> String {
        var answer = ""
        for letter in word.uppercaseString.characters {
            answer += String(letter) + " "
        }
        return answer
    }
    
    //  post: startOrResetGame resets the game to an initial state where no letters have been
    //        guessed. It also chooses a new answer word at random
    func startOrResetGame() -> String {
        let rand = Int(arc4random_uniform(UInt32(words.count)))
        word = words[rand]
        used = ""
        var code = ""
        for _ in word.uppercaseString.characters {
            code += "_ "
        }
        return code
    }
    
    //  pre:  markAsUsed takes in a letter of type String which represents the current guess
    //  post: markAsUsed adds the letter to the list of letters which have already been used
    func markAsUsed(letter: String) {
        used += letter
    }
    
    //  pre:  checkIfUsed takes in a letter of type String which represents the current guess
    //  post: checkIfUsed returns a bool representing whether or not the letter has been used
    func checkIfUsed(letter: String) -> Bool {
        return !(used.rangeOfString(letter) == nil)
    }
    
    //  post: getHint returns a String representing a missing letter of the word
    func getHint() -> String {
        var rand = Int(arc4random_uniform(UInt32(word.characters.count)))
        let characters = [Character](word.characters)
        var charHint = String(characters[rand])
        while (checkIfUsed(charHint)) {
            rand = Int(arc4random_uniform(UInt32(word.characters.count)))
            charHint = String(characters[rand])
        }
        return charHint.uppercaseString;
    }
    
}