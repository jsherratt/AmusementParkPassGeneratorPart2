//
//  Button.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 26/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class Button: UIButton {

    //-----------------------
    //MARK: Functions
    //-----------------------
    
    //Round button corners
    override func drawRect(rect: CGRect) {
    
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
 

}
