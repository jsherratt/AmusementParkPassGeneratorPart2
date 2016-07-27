//
//  PassViewController.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 27/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {

    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //-----------------------
    //MARK: Button Actions
    //-----------------------
    @IBAction func createNewPass(sender: Button) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
