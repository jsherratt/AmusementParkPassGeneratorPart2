//
//  TextField.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 26/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

//-----------------------
//MARK: Classes
//-----------------------

//Subclass UITextField to adjust the inset for text postion and set a text field state toggle
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

//-----------------------
//MARK: Extensions
//-----------------------

//Extension of UITextField to add a max length property to a text field that can be set in interface builder

private var maxLengths = [UITextField: Int]()

extension UITextField {
    
    //set the maxLength property with @IBInspectable to make it available to Interface Builder.This then provides an editor for its value in the Attributes Inspector
    @IBInspectable var maxLength: Int {
        
        get {
            
            //Filter out cases where no maximum length has been defined for the text field, in which case, simply return the theoretical maximum string size
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            
            maxLengths[self] = newValue
            
            //Use addTarget in maxLength‘s setter to ensure that if a text field is assigned a maximum length, the limitLength method is called whenever the text field’s contents change
            addTarget(self, action: #selector(limitLength), forControlEvents: UIControlEvents.EditingChanged)
        }
    }
    
    func limitLength(textField: UITextField) {
        
        //Any case that gets past this is one where the text about to go into the text field is longer than the maximum length
        guard let prospectiveText = textField.text
            where prospectiveText.characters.count > maxLength else { return }
        
        let selection = selectedTextRange
        
        text = prospectiveText.substringWithRange(Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.startIndex.advancedBy(maxLength)))
        selectedTextRange = selection
    }
}
