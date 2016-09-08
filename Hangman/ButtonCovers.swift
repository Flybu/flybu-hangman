//
//  ButtonCovers.swift
//  Hangman
//
//  Created by Howard Yang on 9/7/16.
//  Copyright © 2016 Flybu. All rights reserved.
//

import UIKit

class ButtonCovers: UIButton {
        
    func coverButton() {
        self.enabled = false
    }
    
    func uncoverButton() {
        self.enabled = true;
    }
    

}
