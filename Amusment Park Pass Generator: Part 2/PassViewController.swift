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
    var foodDiscount = 0
    var merchDiscount = 0

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
        
        //Round corners of views
        roundViewCorners()
        
        //Set the label text from the type of guest pass
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
                        foodDiscount = discount
                    } else {
                        foodDiscountLabel.text = "0% discount on Food"
                    }
                    
                case .DiscountOnMerchandise(let discount):
                    
                    if discount != 0 {
                        merchDiscountLabel.text = "\(discount)% on Merchandise"
                        merchDiscount = discount
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
    
    //Go back to the create pass view controller
    @IBAction func createNewPass(sender: Button) {
        
        // TODO: Rest guest back to nil on dismiss
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Test pass access
    
    //Test ride access
    @IBAction func testRideAccess(sender: UIButton) {
        
        do {
            if try guest?.swipePass(forRide: .AccessAllRides) == true {
                
                showAccessGranted()
                
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    @IBAction func testLineSkip(sender: UIButton) {
        
        do {
            if try guest?.swipePass(forRide: .SkipAllRideLines) == true {
                
                showAccessGranted()
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    //Test discount access
    @IBAction func testFoodDiscount(sender: UIButton) {

        do {
            if try guest?.swipePass(forDiscount: .DiscountOnFood(amount: foodDiscount)) == true {
                
                showAccessGranted()
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    @IBAction func testMerchDiscount(sender: UIButton) {
        
        do {
            if try guest?.swipePass(forDiscount: .DiscountOnMerchandise(amount: merchDiscount)) == true {
                
                showAccessGranted()
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    //Test area access
    @IBAction func testKitchenAccess(sender: UIButton) {
        
        do {
            if try guest?.swipePass(forArea: .KitchenAreas) == true {
                
                showAccessGranted()
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    @IBAction func testRideControlAccess(sender: UIButton) {
        
        do {
            if try guest?.swipePass(forArea: .RideControlAreas) == true {
                
                showAccessGranted()
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    @IBAction func testOfficeAccess(sender: UIButton) {
        
        do {
            if try guest?.swipePass(forArea: .OfficeAreas) == true {
                
                showAccessGranted()
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    @IBAction func testMaintenanceAccess(sender: UIButton) {
        
        do {
            if try guest?.swipePass(forArea: .MaintenanceAreas) == true {
                
                showAccessGranted()
            }else {
                showAccessDenied()
            }
            
        }catch {
            print(error)
        }
    }
    
    //Change test results label based on whether access is granted or denied
    func showAccessGranted() {
        
        testResultLabel.text = "Access Granted"
        testResultLabel.textColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        testResultLabel.backgroundColor = UIColor(red: 41/255.0, green: 188/255.0, blue: 148/255.0, alpha: 1.0)
    }
    
    func showAccessDenied() {
        
        testResultLabel.text = "Access Denied"
        testResultLabel.textColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        testResultLabel.backgroundColor = UIColor(red: 218/255.0, green: 75/255.0, blue: 75/255.0, alpha: 1.0)
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    
    //Round the corners of the pass hole at the top, the avatar and the pass background
    func roundViewCorners() {
        
        passHole.layer.cornerRadius = 4
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
