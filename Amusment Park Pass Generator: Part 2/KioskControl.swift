//
//  KioskControl.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Protocols
//-----------------------

//Protocol that kiosk control has to conform to
protocol Kiosk {
    
    func createPass(forEntrant entrant: Entrant) -> Pass
    func validateAreaAccess(forPass pass: Pass, area areas: AreaAccess) -> Bool
    func validateRideAccess(forPass pass: Pass, ride: RideAccess) -> Bool
    func validateDiscountAccess(forPass pass: Pass, discount: DiscountAccess) -> Bool
}


//-----------------------
//MARK: Structs
//-----------------------
struct KioskControl: Kiosk {
    
    //Function to create a pass for an entrant
    func createPass(forEntrant entrant: Entrant) -> Pass {
        
        return Pass(entrant: entrant)
    }
    
    //Function to validate area access for a pass
    func validateAreaAccess(forPass pass: Pass, area: AreaAccess) -> Bool {
        
        for access in pass.areaAccess {
            
            if access == area {
                
                return true
            }
        }
        return false
    }
    
    //Function to validate ride access for a pass
    func validateRideAccess(forPass pass: Pass, ride: RideAccess) -> Bool {
        
        for access in pass.rideAccess {
            
            if access == ride {
                
                return true
            }
        }
        return false
    }
    
    //Function to validate discount access for a pass
    func validateDiscountAccess(forPass pass: Pass, discount: DiscountAccess) -> Bool {
        
        if let discountAccess = pass.discountAccess {
            
            for discountAcc in discountAccess {
                
                switch (discountAcc, discount) {
                    
                case (let .DiscountOnFood(amount: value1), let .DiscountOnFood(amount: value2)):
                    
                    if value1 == value2 {
                        return true
                    }else {
                        return false
                    }
                    
                case (let .DiscountOnMerchandise(amount: value1), let .DiscountOnMerchandise(amount: value2)):
                    
                    if value1 == value2 {
                        return true
                    }else {
                        return false
                    }
                    
                default:break
                }
            }
        }
        
        return false
    }
}
