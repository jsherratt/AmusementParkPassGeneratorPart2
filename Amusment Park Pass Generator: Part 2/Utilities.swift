//
//  Utilities.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 27/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

//-----------------------
//MARK: Variables
//-----------------------
var dateFormatter: NSDateFormatter = {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
}()

//-----------------------
//MARK: Extensions
//-----------------------
extension UIViewController {
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}