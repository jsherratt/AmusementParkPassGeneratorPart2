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
    
    case ClassicGuestPass = "Classic Guest Pass"
    case ChildGuestPass = "Child Guest Pass"
    case VIPGuestPass = "VIP Guest Pass"
    case FoodServicePass = "Food Services Pass"
    case RideServicePass = "Ride Services Pass"
    case MaintenancePass = "Maintenance Services Pass"
    case SeniorManagerPass = "Senior Manager Pass"
    case GeneralManagerPass = "General Manager Pass"
    case ShiftManagerPass = "Shift Manager Pass"
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
            
        case let employee as Employee:
            
            switch employee.employeeType {
                
            case .FoodServices: access = [.AmusementAreas, .KitchenAreas]
                
            case .RideServices: access = [.AmusementAreas, .RideControlAreas]
                
            case .Maintenance: access = [.AmusementAreas, .KitchenAreas, .RideControlAreas, .MaintenanceAreas]
                
            }
            
        case is Manager: access = [.AmusementAreas, .KitchenAreas, .RideControlAreas, .MaintenanceAreas, .OfficeAreas]
            
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
            
            switch guest.guestType{
                
            case .Classic, .FreeChild: access = [.AccessAllRides]
            case .VIP: access = [.AccessAllRides, .SkipAllRideLines]
                
            }
            
        case is Employee: access = [.AccessAllRides]
            
        case is Manager: access = [.AccessAllRides]
            
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
                
            case .Classic, .FreeChild: discount = nil
                
            case .VIP: discount = [.DiscountOnFood(amount: 10), .DiscountOnMerchandise(amount: 20)]
                
            }
            
        case is Employee: discount = [.DiscountOnFood(amount: 15), .DiscountOnMerchandise(amount: 25)]
            
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
            
            switch guest.guestType {
                
            case .Classic: self.type = PassType.ClassicGuestPass.rawValue
                
            case .FreeChild: self.type = PassType.ChildGuestPass.rawValue
                
            case .VIP: self.type = PassType.VIPGuestPass.rawValue
                
            }
            
        case let employee as Employee:
            
            switch employee.employeeType {
                
            case .FoodServices: self.type = PassType.FoodServicePass.rawValue
                
            case .RideServices: self.type = PassType.RideServicePass.rawValue
                
            case .Maintenance: self.type = PassType.MaintenancePass.rawValue
                
            }
            
        case let manager as Manager:
            
            switch manager.managerType {
                
            case .SeniorManager: self.type = PassType.SeniorManagerPass.rawValue
                
            case .GeneralManager: self.type = PassType.GeneralManagerPass.rawValue
                
            case .ShiftManager: self.type = PassType.ShiftManagerPass.rawValue
                
            }
            
        default: break
            
        }
        
        self.areaAccess = AreaAccess.validateAreaAccess(forEntrant: entrant)
        self.rideAccess = RideAccess.validateRideAccess(forEntrant: entrant)
        self.discountAccess = DiscountAccess.validateDiscount(forEntrant: entrant)
    }
}
