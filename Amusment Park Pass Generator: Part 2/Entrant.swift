//
//  Entrant.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Protocols
//-----------------------

//Protocol that an entrant has to conform to
protocol Entrant {
    
    var pass: Pass? { get set }
    func swipePass(forArea area: AreaAccess) throws
    func swipePass(forRide ride: RideAccess) throws
    func swipePass(forDiscount discount: DiscountAccess) throws
}

//-----------------------
//MARK: Extension
//-----------------------

//Extend the entrant protocol to create default implementation for swipe methods
extension Entrant {
    
    func swipePass(forArea area: AreaAccess) throws {
        
        //Check if a pass was created for the entrant. If not then throw missing pass error
        guard let pass = pass else { throw Error.MissingPass }
        
        //Create instances of kiosk control and sound
        let kioskControl = KioskControl()
        var sound = Sound()
        
        //Check if pass has access to specified area using the validate area access method
        if kioskControl.validateAreaAccess(forPass: pass, area: area) == true {
            
            print("You have been GRANTED access to: \(area)")
            sound.playSound(withSound: .AccessGranted)
            checkForGuestBirthday()
            
        }else {
            
            print("You have been DENIED access to: \(area)")
            sound.playSound(withSound: .AccessDenied)
            throw Error.DeniedAccess
        }
    }
    
    func swipePass(forRide ride: RideAccess) throws {
        
        guard let pass = pass else { throw Error.MissingPass }
        
        let kioskControl = KioskControl()
        var sound = Sound()
        
        if kioskControl.validateRideAccess(forPass: pass, ride: ride) == true {
            
            print("Success! you have been GRANTED access to: \(ride)")
            sound.playSound(withSound: .AccessGranted)
            checkForGuestBirthday()
            
        }else {
            
            print("You have been DENIED access to: \(ride)")
            sound.playSound(withSound: .AccessDenied)
            throw Error.DeniedAccess
        }
    }
    
    func swipePass(forDiscount discount: DiscountAccess) throws {
        
        guard let pass = pass else { throw Error.MissingPass }
        
        let kioskControl = KioskControl()
        var sound = Sound()
        
        if kioskControl.validateDiscountAccess(forPass: pass, discount: discount) == true {
            
            print("You have been GRANTED access to: \(discount)%")
            sound.playSound(withSound: .AccessGranted)
            checkForGuestBirthday()
            
        }else {
            
            print("You have been DENIED access to: \(discount)%")
            sound.playSound(withSound: .AccessDenied)
            throw Error.DeniedAccess
        }
    }
    
    //Function to compare month and day of date of birth of entrant with current month and day
    func checkBirthday(withBirthday birthday: NSDate) {
        
        let calendar = NSCalendar.currentCalendar()
        let todayComponents = calendar.components([.Month, .Day], fromDate: NSDate())
        let birthdayComponents = calendar.components([.Month, .Day], fromDate: birthday)
        
        if todayComponents.month == birthdayComponents.month && todayComponents.day == birthdayComponents.day {
            print("Happy Birthday!")
        }
    }
    
    //Function that checks birthday switching on the type of entrant
    func checkForGuestBirthday() {
        
        switch self {
            
        case let guest as Guest:
            
            if let birthday: NSDate = guest.dateOfBirth {
                
                checkBirthday(withBirthday: birthday)
            }
            
        case let employee as HourlyEmployee:
            
            if let birthday: NSDate = employee.dateOfBirth {
                
                checkBirthday(withBirthday: birthday)
            }
            
        case let employee as ContractEmployee:
            
            if let birthday: NSDate = employee.dateOfBirth {
                
                checkBirthday(withBirthday: birthday)
            }
            
        case let manager as Manager:
            
            if let birthday: NSDate = manager.dateOfBirth {
                
                checkBirthday(withBirthday: birthday)
            }
            
        case let manager as Vendor:
            
            if let birthday: NSDate = manager.dateOfBirth {
                
                checkBirthday(withBirthday: birthday)
            }
            
        default: break
        }
    }
}