//
//  HangmanBrain.swift
//  Hangman
//
//  Created by Alex Banh on 8/8/16.
//  Copyright © 2016 Flybu. All rights reserved.
//

import Foundation

class HangmanBrain {
    private var word = "grow"
    
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
}