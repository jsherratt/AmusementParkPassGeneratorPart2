//
//  Manager.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Protocols
//-----------------------

//Protocol that an employee has to conform to
protocol ManagerType: Entrant {
    
    var firstName: String { get }
    var lastName: String { get }
    var streetAddress: String { get }
    var city: String { get }
    var state: String { get }
    var zipCode: Int { get }
    var socialSecurityNumber: Int { get }
    var dateOfBirth: NSDate { get }
    var managerType: Managers { get }
}

//-----------------------
//MARK: Enums
//-----------------------

//Different type of hourly employees
enum Managers {
    
    case SeniorManager
    case GeneralManager
    case ShiftManager
}

//-----------------------
//MARK: Structs
//-----------------------
struct Manager: ManagerType {
    
    var pass: Pass?
    
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: Int
    var socialSecurityNumber: Int
    var dateOfBirth: NSDate
    var managerType: Managers
    
    //Init parameters are optional so they can throw errors when information is not complete
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: Int?, socialSecurityNumber: Int?, dateOfBirth: String?, managerType: Managers?) throws {
        
        guard let firstOfName = firstName, let lastOfName = lastName else { throw Error.MissingName }
        
        guard let street = streetAddress, let city = city, let state = state, let zipCode = zipCode else { throw Error.MissingAddress }
        
        guard let ssn = socialSecurityNumber else { throw Error.MissingSocialSecurityNumber }
        
        guard let dob = dateOfBirth else { throw Error.MissingDateOfBirth }
        
        guard let employee = managerType else { throw Error.MissingType}
        
        self.firstName = firstOfName
        self.lastName = lastOfName
        self.streetAddress = street
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = ssn
        self.dateOfBirth = try DateFormatter.convertString(toDate: dob)
        self.managerType = employee
    }
}