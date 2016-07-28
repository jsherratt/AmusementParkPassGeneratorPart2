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
    //MARK: Variables
    //-----------------------
    var guest: Entrant?

    //-----------------------
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var passHole: UIView!
    @IBOutlet weak var passBackground: UIView!
    @IBOutlet weak var passAvatar: UIImageView!
    @IBOutlet weak var testResultLabel: UILabel!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundViewCorners()
    }

    //-----------------------
    //MARK: Button Actions
    //-----------------------
    @IBAction func createNewPass(sender: Button) {
        
        // TODO: Rest guest back to nil on dismiss
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    
    //Round the corners of the pass hole at the top, the avatar and the pass background
    func roundViewCorners() {
        
        passHole.layer.cornerRadius = 6
        passHole.layer.masksToBounds = true
        
        passBackground.layer.cornerRadius = 5
        passBackground.layer.masksToBounds = true
        
        passAvatar.layer.cornerRadius = 7
        passAvatar.layer.masksToBounds = true
        
        testResultLabel.layer.cornerRadius = 5
        testResultLabel.layer.masksToBounds = true
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
