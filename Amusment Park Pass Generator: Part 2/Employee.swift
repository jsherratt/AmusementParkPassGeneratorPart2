//
//  Employee.swift
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
protocol EmployeeType: Entrant {
    
    var firstName: String { get }
    var lastName: String { get }
    var streetAddress: String { get }
    var city: String { get }
    var state: String { get }
    var zipCode: Int { get }
    var socialSecurityNumber: Int { get }
    var dateOfBirth: NSDate { get }
    var employeeType: Employees { get }
}

//-----------------------
//MARK: Enums
//-----------------------

//Different type of hourly employees
enum Employees {
    
    case Hourly
    case Contract
}

enum WorkType {
    
    case FoodServices
    case RideServices
    case Maintenance
}

enum ProjectNumber {
    
    case oneThousandOne
    case oneThousandTwo
    case oneThousandThree
    case twoThousandOne
    case twoThousandTwo
}

//-----------------------
//MARK: Structs
//-----------------------
struct HourlyEmployee: EmployeeType {
    
    var pass: Pass?
    
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: Int
    var socialSecurityNumber: Int
    var dateOfBirth: NSDate
    var workType: WorkType
    var employeeType: Employees
    
    //Init parameters are optional so they can throw errors when information is not complete
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: Int?, socialSecurityNumber: Int?, dateOfBirth: String?, workType: WorkType?) throws {
        
        guard let firstOfName = firstName, let lastOfName = lastName else { throw Error.MissingName }
        
        guard let street = streetAddress, let city = city, let state = state, let zipCode = zipCode else { throw Error.MissingAddress }
        
        guard let ssn = socialSecurityNumber else { throw Error.MissingSocialSecurityNumber }
        
        guard let dob = dateOfBirth else { throw Error.MissingDateOfBirth }
        guard let convertedDateOfBirth = dateFormatter.dateFromString(dob) else { throw Error.MissingDateOfBirth }
        
        guard let work = workType else { throw Error.MissingType}
        
        self.firstName = firstOfName
        self.lastName = lastOfName
        self.streetAddress = street
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = ssn
        self.dateOfBirth = convertedDateOfBirth
        self.workType = work
        self.employeeType = .Hourly
    }
}

struct ContractEmployee: EmployeeType {
    
    var pass: Pass?
    
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: Int
    var socialSecurityNumber: Int
    var dateOfBirth: NSDate
    var projectNumber: ProjectNumber
    var employeeType: Employees
    
    //Init parameters are optional so they can throw errors when information is not complete
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: Int?, socialSecurityNumber: Int?, dateOfBirth: String?, projectNumber: ProjectNumber?) throws {
        
        guard let firstOfName = firstName, let lastOfName = lastName else { throw Error.MissingName }
        
        guard let street = streetAddress, let city = city, let state = state, let zipCode = zipCode else { throw Error.MissingAddress }
        
        guard let ssn = socialSecurityNumber else { throw Error.MissingSocialSecurityNumber }
        
        guard let dob = dateOfBirth else { throw Error.MissingDateOfBirth }
        guard let convertedDateOfBirth = dateFormatter.dateFromString(dob) else { throw Error.MissingDateOfBirth }
        
        guard let project = projectNumber else { throw Error.MissingProject}
        
        self.firstName = firstOfName
        self.lastName = lastOfName
        self.streetAddress = street
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = ssn
        self.dateOfBirth = convertedDateOfBirth
        self.projectNumber = project
        self.employeeType = .Contract
    }
}
