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
    
    //Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var rideAcessLabel: UILabel!
    @IBOutlet weak var foodDiscountLabel: UILabel!
    @IBOutlet weak var merchDiscountLabel: UILabel!
    @IBOutlet weak var testResultLabel: UILabel!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        roundViewCorners()
        
        //
        if let name = guest?.pass?.name {
            
            nameLabel.text = name
            
        }else {
            nameLabel.text = ""
        }
        
        if let passType = guest?.pass?.type {
            
            passTypeLabel.text = passType
            
        }else {
            passTypeLabel.text = ""
        }
       
        if let rideAccess = guest?.pass?.rideAccess {
            
            if rideAccess.isEmpty {
                
                rideAcessLabel.text = "No Ride Access"
            }else {
                
                for access in rideAccess {
                    
                    switch access {
                        
                    case .AccessAllRides:
                        
                        rideAcessLabel.text = "Unlimted Rides"
                    
                    case .SkipAllRideLines:
                        
                        rideAcessLabel.text = "Unlimted Rides and Skip All Ride Lines"
                    }
                }
            }
        }
        
        if let discountAccessess = guest?.pass?.discountAccess {
            for access in discountAccessess {
                switch access {
                case .DiscountOnFood(let discount):
                    if discount != 0 {
                        foodDiscountLabel.text = "\(discount)% discount on Food"
                    } else {
                        foodDiscountLabel.text = "0% discount on Food"
                    }
                case .DiscountOnMerchandise(let discount):
                    if discount != 0 {
                        merchDiscountLabel.text = "\(discount)% on Merchandise"
                    } else {
                        merchDiscountLabel.text = "0% discount on Merchandise"
                    }
                }
            }
        } else {
            foodDiscountLabel.text = "0% discount on Food"
            merchDiscountLabel.text = "0% discount on Merchandise"
        }
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
