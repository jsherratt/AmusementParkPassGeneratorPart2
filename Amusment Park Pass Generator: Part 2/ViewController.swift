//
//  ViewController.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //-----------------------
    //MARK: Variables
    //-----------------------
    var kioskControl = KioskControl()
    var entrant: Entrant?
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //----------------------------------------------------------------------------------------------------------------------------------------------------------//
        //Uncomment individual entrants and swipe methods below to test creating different types of entrants and swiping their passes for areas, rides and discounts//
        //----------------------------------------------------------------------------------------------------------------------------------------------------------//
        
        //------------------------------------------------------//
        //Use marks for quick access for different swipe methods//
        //------------------------------------------------------//
        
        //-----------------------
        //MARK: Entrants
        //-----------------------
        
        //Classic guest
        /*
         do {
         let classicGuest = try Guest(dateOfbirth: nil, guestType: .Classic)
         entrant = classicGuest
         
         }catch {
         print(error)
         }
         */
        
        //Classic guest - Set month and day to current days date for entrant birthday. Format is MM/dd/yy
        /*
         do {
         let classicGuest = try Guest(dateOfbirth: "07/07/98", guestType: .Classic)
         entrant = classicGuest
         
         }catch {
         print(error)
         }
         */
        
        //VIP guest
        /*
         do {
         let vipGuest = try Guest(dateOfbirth: nil, guestType: .Classic)
         entrant = vipGuest
         
         }catch {
         print(error)
         }
         */
        
        //Free child
        /*
         do {
         let freeChild = try Guest(dateOfbirth: "05/08/14", guestType: .FreeChild)
         entrant = freeChild
         
         }catch {
         print(error)
         }
         */
        
        //Food services employee
        /*
         do {
         let foodServicesEmployee = try Employee(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", employeeType: .FoodServices)
         entrant = foodServicesEmployee
         
         }catch {
         print(error)
         }
         */
        
        //Ride services employee
        /*
         do {
         let rideServicesEmployee = try Employee(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", employeeType: .RideServices)
         entrant = rideServicesEmployee
         
         }catch {
         print(error)
         }
         */
        
        //Maintenance employee
        /*
         do {
         let maintenanceEmployee = try Employee(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", employeeType: .Maintenance)
         entrant = maintenanceEmployee
         
         }catch {
         print(error)
         }
         */
        
        //Senior manager
        /*
         do {
         let seniorManager = try Manager(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", managerType: .SeniorManager)
         entrant = seniorManager
         
         }catch {
         print(error)
         }
         */
        
        //General manager
        /*
         do {
         let generalManager = try Manager(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", managerType: .GeneralManager)
         entrant = generalManager
         
         }catch {
         print(error)
         }
         */
        
        //Shift manager
        /*
         do {
         let shiftManager = try Manager(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", managerType: .ShiftManager)
         entrant = shiftManager
         
         }catch {
         print(error)
         }
         */
        
        //--------------------------------
        //MARK: Entrants throwing errors
        //--------------------------------
        
        //Free child missing date of birth
        /*
         do {
         let freeChild = try Guest(dateOfbirth: nil, guestType: .FreeChild)
         entrant = freeChild
         
         }catch Error.MissingDateOfBirth {
         print("Missing date of birth")
         }catch {
         print(error)
         }
         */
        
        //Food services employee missing last name
        /*
         do {
         let foodServicesEmployee = try Employee(firstName: "John", lastName: nil, streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", employeeType: .FoodServices)
         entrant = foodServicesEmployee
         
         }catch Error.MissingName {
         print("Missing name")
         }catch {
         print(error)
         }
         */
        
        //Shift manager missing address
        /*
         do {
         let shiftManager = try Manager(firstName: "John", lastName: "Smith", streetAddress: nil, city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", managerType: .ShiftManager)
         entrant = shiftManager
         
         }catch Error.MissingAddress {
         print("Missing address")
         }catch {
         print(error)
         }
         */
        
        //Senior manager missing social security number
        /*
         do {
         let seniorManager = try Manager(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: nil, dateOfBirth: "04/02/98", managerType: .SeniorManager)
         entrant = seniorManager
         
         }catch Error.MissingSocialSecurityNumber {
         print("Missing social security number")
         }catch {
         print(error)
         }
         */
        
        //Manager missing type of manager
        /*
         do {
         let seniorManager = try Manager(firstName: "John", lastName: "Smith", streetAddress: "123 Apple Drive", city: "Los Angeles", state: "California", zipCode: 90001, socialSecurityNumber: 264-61-2353, dateOfBirth: "04/02/98", managerType: nil)
         entrant = seniorManager
         
         }catch Error.MissingType {
         print("Missing type")
         }catch {
         print(error)
         }
         */
        
        
        //---------------------------
        //MARK: Swipe passes - Area
        //---------------------------
        
        //Create pass and check if entrant has access to an area, rides, or discounts. All swipes will also throw errors if an entrant tries to access an area, ride or discount the entrant does not have access to.
        //For example - An error will throw if a classic guest tries to access the ride control areas or receive a 25% discount on food.
        
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forArea: .AmusementAreas)
         
         }catch {
         print(error)
         }
         }
         */
        
        //Kitchen areas
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forArea: .KitchenAreas)
         
         }catch {
         print(error)
         }
         }
         */
        
        //Ride control areas
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forArea: .RideControlAreas)
         
         }catch {
         print(error)
         }
         }
         */
        
        //Maintenance areas
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forArea: .MaintenanceAreas)
         
         }catch {
         print(error)
         }
         }
         */
        
        //Office areas
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forArea: .OfficeAreas)
         
         }catch {
         print(error)
         }
         }
         */
        
        //---------------------------
        //MARK: Swipe passes - Ride
        //---------------------------
        
        //All rides
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forRide: .AccessAllRides)
         
         }catch {
         print(error)
         }
         }
         */
        
        //Skip all ride line
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forRide: .SkipAllRideLines)
         
         }catch {
         print(error)
         }
         }
         */
        
        //-------------------------------
        //MARK: Swipe passes - Discount
        //-------------------------------
        
        //10% discount on food
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forDiscount: .DiscountOnFood(amount: 10))
         
         }catch {
         print(error)
         }
         }
         */
        
        //15% discount on food
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forDiscount: .DiscountOnFood(amount: 15))
         
         }catch {
         print(error)
         }
         }
         */
        
        //25% discount on food
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forDiscount: .DiscountOnFood(amount: 25))
         
         }catch {
         print(error)
         }
         }
         */
        
        //20% discount on merchandise
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forDiscount: .DiscountOnMerchandise(amount: 20))
         
         }catch {
         print(error)
         }
         }
         */
        
        //25% discount on merchandise
        /*
         if var person = self.entrant {
         
         let pass = kioskControl.createPass(forEntrant: person)
         person.pass = pass
         
         do {
         try person.swipePass(forDiscount: .DiscountOnMerchandise(amount: 25))
         
         }catch {
         print(error)
         }
         }
         */
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

