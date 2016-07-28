//
//  Errors.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Enums
//-----------------------

//Park errors that could occur
enum Error: ErrorType {
    
    case MissingName
    case MissingAddress
    case MissingSocialSecurityNumber
    case MissingDateOfBirth
    case ChildOlderThanFive
    case MissingType
    case MissingPass
    case MissingCompany
    case MissingDateOfVisit
    case MissingProject
    case DeniedAccess
    case MissingSound
    case IncorrectDateFormat
}