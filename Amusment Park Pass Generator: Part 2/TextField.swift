//
//  TextField.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 26/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

//Subclass UITextField to adjust the inset for text postion 
class TextField: UITextField {
    
    //-----------------------
    //MARK: Variables
    //-----------------------
    let textInset: CGFloat = 10
    
    var changeState = false {
        
        didSet {
            
            if changeState {
                
                //Enable textField and change background color
                enabled = true
                backgroundColor = UIColor.whiteColor()
                
            } else {
                
                //Disable textField and change background color
                enabled = false
                backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    
    //Text position
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        
        return CGRectInset(bounds, textInset, textInset)
    }
    
    //Placeholder position
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        
        return CGRectInset(bounds, textInset, textInset)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        
        return CGRectInset(bounds, textInset, textInset)
    }
    
    //Round the corners of the text field
    override func drawRect(rect: CGRect) {
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.4
        self.layer.borderColor = UIColor(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0).CGColor
    }

}
