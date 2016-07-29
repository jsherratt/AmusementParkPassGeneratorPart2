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
    
    case FreeChild
    case Adult
    case Senior
    case VIP
    case SeasonPass
}


//-----------------------
//MARK: Structs
//-----------------------
struct Guest: GuestType {
    
    var pass: Pass?
    
    var guestType: Guests
    var dateOfBirth: NSDate?
    var firstName: String?
    var lastName: String?
    var streetAddress: String? = nil
    var city: String? = nil
    var state: String? = nil
    var zipCode: Int? = nil

    
    init(firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: Int? = nil, dateOfbirth: String?, guestType: Guests) throws {
        
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
            guard let convertedDateOfBirth = dateFormatter.dateFromString(dob) else { throw Error.MissingDateOfBirth }
            self.dateOfBirth = convertedDateOfBirth
            
            //Check if child is younger than 5
            if childIsYoungerThanFive(convertedDateOfBirth) == true {
                
                self.guestType = .FreeChild
                print("child is younger than five so is a free child!")
                
            }else {
                
                throw Error.ChildOlderThanFive
            }
            
        case .Senior:
            
            guard let firstOfName = firstName, let lastOfName = lastName else { throw Error.MissingName }
            guard let dob = dateOfbirth else { throw Error.MissingDateOfBirth }
            
            guard let convertedDateOfBirth = dateFormatter.dateFromString(dob) else { throw Error.MissingDateOfBirth }
            
            self.firstName = firstOfName
            self.lastName = lastOfName
            self.dateOfBirth = convertedDateOfBirth
            self.guestType = guestType
            
        case .SeasonPass:
            
            guard let firstOfName = firstName, let lastOfName = lastName else { throw Error.MissingName }
            guard let street = streetAddress, let city = city, let state = state, let zipCode = zipCode else { throw Error.MissingAddress }
            guard let dob = dateOfbirth else { throw Error.MissingDateOfBirth }
            
            guard let convertedDateOfBirth = dateFormatter.dateFromString(dob) else { throw Error.MissingDateOfBirth }
            
            self.firstName = firstOfName
            self.lastName = lastOfName
            self.streetAddress = street
            self.city = city
            self.state = state
            self.zipCode = zipCode
            self.dateOfBirth = convertedDateOfBirth
            self.guestType = guestType
            
        default:
            
            if let dob = dateOfbirth {
                
                guard let convertedDateOfBirth = dateFormatter.dateFromString(dob) else { throw Error.MissingDateOfBirth }
                self.dateOfBirth = convertedDateOfBirth
            }
            
            self.guestType = guestType
        }
    }
}