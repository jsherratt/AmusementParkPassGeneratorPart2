//
//  ParkPass.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

//-----------------------
//MARK: Protocols
//-----------------------

//Protocol that a park pass has to conform to
protocol ParkPassType {
    
    var image: UIImage? { get }
    var name: String? { get }
    var type: String? { get }
    var areaAccess: [AreaAccess] { get }
    var rideAccess: [RideAccess] { get }
    var discountAccess: [DiscountAccess]? { get }
}

//-----------------------
//MARK: Enums
//-----------------------

//Enum for different pass types
enum PassType: String {
    
    case ChildGuestPass = "Child Guest Pass"
    case AdultGuestPass = "Adult Guest Pass"
    case SeniorGuestPass = "Senior Guest Pass"
    case VIPGuestPass = "VIP Guest Pass"
    case SeasonGuestPass = "Season Guest Pass"
    case FoodServicePass = "Food Services Pass"
    case RideServicePass = "Ride Services Pass"
    case MaintenancePass = "Maintenance Services Pass"
    case SeniorManagerPass = "Senior Manager Pass"
    case GeneralManagerPass = "General Manager Pass"
    case ShiftManagerPass = "Shift Manager Pass"
    case ContractorPass = "Contractor Pass"
    case VendorPass = "Vendor Pass"
    case None
}

//Enum for different access areas and a function to validate what areas different entrants can access
enum AreaAccess {
    
    case AmusementAreas
    case KitchenAreas
    case RideControlAreas
    case MaintenanceAreas
    case OfficeAreas
    
    static func validateAreaAccess(forEntrant entrant: Entrant) -> [AreaAccess] {
        
        var access = [AreaAccess]()
        
        switch entrant {
            
        case is Guest: access = [.AmusementAreas]
            
        case let employee as HourlyEmployee:
            
            switch employee.workType {
                
            case .FoodServices: access = [.AmusementAreas, .KitchenAreas]
                
            case .RideServices: access = [.AmusementAreas, .RideControlAreas]
                
            case .Maintenance: access = [.AmusementAreas, .KitchenAreas, .RideControlAreas, .MaintenanceAreas]
                
            }
        case let employee as ContractEmployee:
            
            switch employee.projectNumber {
                
            case .oneThousandOne: access = [.AmusementAreas, .RideControlAreas]
                
            case .oneThousandTwo: access = [.AmusementAreas, .RideControlAreas, .MaintenanceAreas]
                
            case .oneThousandThree: access = [.AmusementAreas, .RideControlAreas, .KitchenAreas, .MaintenanceAreas, .OfficeAreas]
                
            case .twoThousandOne: access = [.OfficeAreas]
                
            case .twoThousandTwo: access = [.KitchenAreas, .MaintenanceAreas]
                
            }
            
        case is Manager: access = [.AmusementAreas, .KitchenAreas, .RideControlAreas, .MaintenanceAreas, .OfficeAreas]
            
        case let vendor as Vendor:
            
            switch vendor.company {
                
            case .Acme: access = [.KitchenAreas]
                
            case .Orkin: access = [.AmusementAreas, .RideControlAreas, .KitchenAreas]
                
            case .Fedex: access = [.MaintenanceAreas, .OfficeAreas]
                
            case .NWElectrical: access = [.AmusementAreas, .RideControlAreas, .KitchenAreas, .MaintenanceAreas, .OfficeAreas]
                
            }
            
        default: break
            
        }
        return access
    }
}

//Enum for ride access and a function to validate if entrants has access to all rides and/or can skip all ride lines
enum RideAccess {
    
    case AccessAllRides
    case SkipAllRideLines
    
    static func validateRideAccess(forEntrant entrant: Entrant) -> [RideAccess] {
        
        var access = [RideAccess]()
        
        switch entrant {
            
        case let guest as Guest:
            
            switch guest.guestType {
                
            case .Adult, .FreeChild: access = [.AccessAllRides]
            case .Senior, .VIP, .SeasonPass: access = [.AccessAllRides, .SkipAllRideLines]
                
            }
            
        case is HourlyEmployee: access = [.AccessAllRides]
        
        case let employee as ContractEmployee:
            
            switch employee.projectNumber {
                
            case .oneThousandOne: access = [.AccessAllRides]
                
            case .oneThousandTwo: access = [.AccessAllRides]
                
            case .oneThousandThree: access = [.AccessAllRides]
                
            default: break
                
            }
            
        case is Manager: access = [.AccessAllRides]
            
        case let vendor as Vendor:
            
            switch vendor.company {
                
            case .Orkin: access = [.AccessAllRides]
            case .NWElectrical: access = [.AccessAllRides]
                
            default: break
                
            }
            
        default: break
            
        }
        return access
    }
}

//Enum for discount access and a function to validate what entrants receive what type of discount
enum DiscountAccess {
    
    case DiscountOnFood(amount: Int)
    case DiscountOnMerchandise(amount: Int)
    
    static func validateDiscount(forEntrant entrant: Entrant) -> [DiscountAccess]? {
        
        var discount = [DiscountAccess]?()
        
        switch entrant {
            
        case let guest as Guest:
            
            switch guest.guestType {
                
            case .Adult, .FreeChild: discount = nil
                
            case .Senior: discount = [.DiscountOnFood(amount: 10), .DiscountOnMerchandise(amount: 10)]
                
            case .VIP, .SeasonPass: discount = [.DiscountOnFood(amount: 10), .DiscountOnMerchandise(amount: 20)]
                
            }
            
        case is HourlyEmployee: discount = [.DiscountOnFood(amount: 15), .DiscountOnMerchandise(amount: 25)]
            
        case is Manager: discount = [.DiscountOnFood(amount: 25), .DiscountOnMerchandise(amount: 25)]
            
        default: break
            
        }
        return discount
    }
}

//-----------------------
//MARK: Structs
//-----------------------
struct Pass: ParkPassType {
    
    var image: UIImage?
    var name: String?
    var type: String?
    var areaAccess: [AreaAccess]
    var rideAccess: [RideAccess]
    var discountAccess: [DiscountAccess]?
    
    init(entrant: Entrant) {
        
        switch entrant {
            
        case let guest as Guest:
            
            if let firstName = guest.firstName, let lastName = guest.lastName {
                
                self.name = "\(firstName) \(lastName)"
            }else {
                self.name = nil
            }
            
            switch guest.guestType {
                
            case .Adult: self.type = PassType.AdultGuestPass.rawValue
                
            case .FreeChild: self.type = PassType.ChildGuestPass.rawValue
                
            case .Senior: self.type = PassType.SeniorGuestPass.rawValue
                
            case .VIP: self.type = PassType.VIPGuestPass.rawValue
                
            case .SeasonPass: self.type = PassType.SeasonGuestPass.rawValue
                
            }
            
        case let employee as HourlyEmployee:
            
            self.name = "\(employee.firstName) \(employee.lastName)"
            
            switch employee.workType {
                
            case .FoodServices: self.type = PassType.FoodServicePass.rawValue
                
            case .RideServices: self.type = PassType.RideServicePass.rawValue
                
            case .Maintenance: self.type = PassType.MaintenancePass.rawValue
                
            }
            
        case let employee as ContractEmployee:
            
            self.name = "\(employee.firstName) \(employee.lastName)"
            
            self.type = PassType.ContractorPass.rawValue
            
        case let manager as Manager:
            
            self.name = "\(manager.firstName) \(manager.lastName)"
            
            switch manager.managerType {
                
            case .SeniorManager: self.type = PassType.SeniorManagerPass.rawValue
                
            case .GeneralManager: self.type = PassType.GeneralManagerPass.rawValue
                
            case .ShiftManager: self.type = PassType.ShiftManagerPass.rawValue
                
            }
            
        case let vendor as Vendor:
            
            self.name = "\(vendor.firstName) \(vendor.lastName)"
            
            self.type = PassType.VendorPass.rawValue
            
        default: break
            
        }
        
        self.areaAccess = AreaAccess.validateAreaAccess(forEntrant: entrant)
        self.rideAccess = RideAccess.validateRideAccess(forEntrant: entrant)
        self.discountAccess = DiscountAccess.validateDiscount(forEntrant: entrant)
    }
}
