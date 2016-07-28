//
//  Vendor.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 28/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Protocols
//-----------------------

//Protocol that a vendor has to conform to
protocol VendorType: Entrant {
    
    var firstName: String { get }
    var lastName: String { get }
    var company: Company { get }
    var dateOfBirth: NSDate { get }
    var dateOfVisit: NSDate { get }
}

//-----------------------
//MARK: Enums
//-----------------------

//Different vendor companies
enum Company {
    
    case Acme
    case Orkin
    case Fedex
    case NWElectrical
}

//-----------------------
//MARK: Structs
//-----------------------

struct Vendor: VendorType {
    
    var pass: Pass?
    
    var firstName: String
    var lastName: String
    var company: Company
    var dateOfBirth: NSDate
    var dateOfVisit: NSDate
    
    init(firstName: String?, lastName: String?, company: Company?, dateOfBirth: String?, dateOfVisit: String?) throws {
        
        guard let firstOfName = firstName, let lastOfName = lastName else { throw Error.MissingName }
        
        guard let company = company else { throw Error.MissingCompany }
        
        guard let dob = dateOfBirth else { throw Error.MissingDateOfBirth }
        guard let convertedDateOfBirth = dateFormatter.dateFromString(dob) else { throw Error.MissingDateOfBirth }
        
        guard let dov = dateOfVisit else { throw Error.MissingDateOfVisit }
        guard let convertedDateOfVisit = dateFormatter.dateFromString(dov) else { throw Error.MissingDateOfBirth }
        
        self.firstName = firstOfName
        self.lastName = lastOfName
        self.company = company
        self.dateOfBirth = convertedDateOfBirth
        self.dateOfVisit = convertedDateOfVisit
    }
}
