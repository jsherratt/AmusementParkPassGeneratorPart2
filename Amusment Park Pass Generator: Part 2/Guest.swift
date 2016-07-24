//
//  Guest.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Protocols
//-----------------------

//Protocol that guest has to conform to
protocol GuestType: Entrant {
    
    var dateOfBirth: NSDate? { get }
    var guestType: Guests { get }
}

//-----------------------
//MARK: Enums
//-----------------------

//Different types of guests
enum Guests {
    
    case Classic
    case VIP
    case FreeChild
}


//-----------------------
//MARK: Structs
//-----------------------
struct Guest: GuestType {
    
    var pass: Pass?
    var guestType: Guests
    var dateOfBirth: NSDate?
    
    init(dateOfbirth: String?, guestType: Guests) throws {
        
        //Function to check if the guest is younger that the age of 5
        func childIsYoungerThanFive (date: NSDate) -> Bool {
            
            let currentDate = NSDate()
            let calender = NSCalendar.currentCalendar()
            let components = calender.components(.Year, fromDate: date, toDate: currentDate, options: .MatchFirst)
            
            if components.year <= 5 {
                return true
            }else {
                return false
            }
        }
        
        switch guestType {
            
        case .FreeChild:
            
            //Check if child has date of birth
            guard let dob = dateOfbirth else { throw Error.MissingDateOfBirth }
            
            //Convert date of birth from string to nsdate
            let convertedDate = try DateFormatter.convertString(toDate: dob)
            self.dateOfBirth = convertedDate
            
            //Check if child is younger than 5
            if childIsYoungerThanFive(convertedDate) == true {
                
                self.guestType = .FreeChild
                print("child is younger than five so is a free child!")
                
            }else {
                
                if let dob = dateOfbirth {
                    let convertedDate = try DateFormatter.convertString(toDate: dob)
                    self.dateOfBirth = convertedDate
                }
                
                self.guestType = .Classic
            }
            
        default:
            
            if let dob = dateOfbirth {
                let convertedDate = try DateFormatter.convertString(toDate: dob)
                self.dateOfBirth = convertedDate
            }
            
            self.guestType = guestType
        }
    }
}