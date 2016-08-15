//
//  HangmanBrain.swift
//  Hangman
//
//  Created by Alex Banh on 8/8/16.
//  Copyright © 2016 Flybu. All rights reserved.
//

import Foundation

class HangmanBrain {
    
    private let words = ["Kathy", "Howie", "Ally", "Alex", "Grow", "Toe", "Test", "Class", "Drink", "Car", "Bar", "Surface", "Pen", "Apple", "Banana"]
    
    private var word = ""
    
    private var used = ""
    
    func checkLetter(letter: String, oldCode: String) -> String {
        var newCode = ""
        let characters = [Character](letter.characters)
        let character = characters[0]
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
    
    func showAnswer() -> String {
        var answer = ""
        for letter in word.uppercaseString.characters {
            answer += String(letter) + " "
        }
        return answer
    }
    
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
    
    func markAsUsed(letter: String) {
        used += letter
    }
    
    func checkIfUsed(letter: String) -> Bool {
        return !(used.rangeOfString(letter) == nil)
    }
    
}