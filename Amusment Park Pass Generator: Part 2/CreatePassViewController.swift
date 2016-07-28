//
//  ViewController.swift
//  Amusment Park Pass Generator: Part 2
//
//  Created by Joe Sherratt on 24/07/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class CreatePassViewController: UIViewController, UITextFieldDelegate {
    
    //-----------------------
    //MARK: Enum
    //-----------------------
    enum EntrantType {
        
        case Guest
        case Employee
        case Manger
        case Contractor
        case Vendor
        case None
    }

    //-----------------------
    //MARK: Variables
    //-----------------------
    let kioskControl = KioskControl()
    var guest: Entrant?
    var entrantStackView: EntrantType = .None
    var selectedEntrant: EntrantType = .None
    var selectedEntrantSubtype: PassType = .None

    //-----------------------
    //MARK: Outlets
    //-----------------------
    
    //Stackview
    @IBOutlet weak var entrantSubTypeStackView: UIStackView!
    
    //Text fields
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var ssnTextField: TextField!
    @IBOutlet weak var projectNumberTextField: TextField!
    @IBOutlet weak var dateOfVisitTextField: TextField!
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var companyTextField: TextField!
    @IBOutlet weak var addressTextField: TextField!
    @IBOutlet weak var cityTextField: TextField!
    @IBOutlet weak var stateTextField: TextField!
    @IBOutlet weak var zipCodeTextField: TextField!
    
    //Array of all the text fields
    @IBOutlet var textFieldArray: [TextField]!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the delegate for each text field
        for textField in textFieldArray {
            
            textField.delegate = self
        }
        
        //Add tap gesture recognizer to dismiss the keyboard when the user taps outside of the text field
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    //-----------------------
    //MARK: Button Actions
    //-----------------------
    
    //Generating the stackview of entrant subtypes from the selected entrant
    @IBAction func selectEntrantToPopulateStackView(sender: UIButton) {
        
        let buttonTitle = sender.currentTitle!
        
        switch buttonTitle {
            
        case "Guest":
            
            resetTextFields()
            selectedEntrant = .Guest
            createEntrantSubTypeStackView(withEntant: .Guest)
            
        case "Employee":
            
            resetTextFields()
            selectedEntrant = .Employee
            createEntrantSubTypeStackView(withEntant: .Employee)
            
        case "Manager":
            
            resetTextFields()
            selectedEntrant = .Manger
            createEntrantSubTypeStackView(withEntant: .Manger)
            
        case "Contractor":
            
            resetTextFields()
            selectedEntrant = .Contractor
            createEntrantSubTypeStackView(withEntant: .Contractor)
            
        case "Vendor":
            
            resetTextFields()
            selectedEntrant = .Vendor
            createEntrantSubTypeStackView(withEntant: .Vendor)
            
        default:
            return
        }
    }
    
    @IBAction func generatePass(sender: UIButton) {
        
        switch selectedEntrantSubtype {
            
        case .ChildGuestPass:
            
            do {
                let childGuest = try Guest(dateOfbirth: dateOfBirthTextField.text!, guestType: .FreeChild)
                guest = childGuest
                
            }catch Error.MissingDateOfBirth {
                
                displayAlert("Error", message: "You must enter a date of birth")
                
            }catch Error.ChildOlderThanFive {
                
                displayAlert("Error", message: "Child is older than five. Please select adult guest")
                
            }catch let error {
                print(error)
            }
            
        case .AdultGuestPass:
            
            do {
                let adultGuest = try Guest(dateOfbirth: dateOfBirthTextField.text!, guestType: .Adult)
                guest = adultGuest
                
            }catch Error.MissingDateOfBirth {
                
                displayAlert("Error", message: "You must enter a date of birth")
                
            }catch let error {
                print(error)
            }
            
        case .SeniorGuestPass:
            
            do {
                let seniorGuest = try Guest(firstName: firstNameTextField.text, lastName: lastNameTextField.text, dateOfbirth: dateOfBirthTextField.text, guestType: .Senior)
                guest = seniorGuest
                
            }catch Error.MissingDateOfBirth {
                
                displayAlert("Error", message: "You must enter a date of birth")
                
            }catch Error.MissingName {
                
                displayAlert("Error", message: "You must enter a first and a last name")
                
            }catch let error {
                print(error)
            }
            
        case .VIPGuestPass:
            
            do {
                let vipGuest = try Guest(dateOfbirth: dateOfBirthTextField.text!, guestType: .VIP)
                guest = vipGuest
                
            }catch Error.MissingDateOfBirth {
                
                displayAlert("Error", message: "You must enter a date of birth")
                
            }catch let error {
                print(error)
            }
            
        case .SeasonGuestPass:
            
            do {
                let seasonGuest = try Guest(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: addressTextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: Int(zipCodeTextField.text!), dateOfbirth: dateOfBirthTextField.text, guestType: .SeasonPass)
                guest = seasonGuest
                
            }catch Error.MissingDateOfBirth {
                
                displayAlert("Error", message: "You must enter a date of birth")
                
            }catch Error.MissingName {
                
                displayAlert("Error", message: "You must enter a first and a last name")
                
            }catch Error.MissingAddress {
                
                displayAlert("Error", message: "You must enter an address, city, state and zip code")
                
            }catch let error {
                print(error)
            }
            
        case .FoodServicePass:
            return
            
        case .RideServicePass:
            return
            
        case .MaintenancePass:
            return
            
        case .SeniorManagerPass:
            return
            
        case .GeneralManagerPass:
            return
            
        case .ShiftManagerPass:
            return
            
        case .ContractorPass:
            return
            
        case .VendorPass:
            return
            
        case .None:
            
            displayAlert("Error", message: "You must select and entrant")
        }
        
        if var guest = guest {
            
            let pass = kioskControl.createPass(forEntrant: guest)
            guest.pass = pass
            
            performSegueWithIdentifier("ShowPass", sender: self)
        }
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    func selectedEntrantSubType(sender: UIButton) {
        
        resetTextFields()
        
        dateOfBirthTextField.changeState = true
        
        let buttonTitle = sender.currentTitle!
        
        switch selectedEntrant {
            
        case .Guest:
            
            switch buttonTitle {
                
            case "Child":
                
                selectedEntrantSubtype = .ChildGuestPass
            
            case "Adult":
                
                selectedEntrantSubtype = .AdultGuestPass
                
            case "Senior":
                
                selectedEntrantSubtype = .SeniorGuestPass
                activateTextFieldsForSeniorGuests()
                
            case "VIP":
                
                selectedEntrantSubtype = .VIPGuestPass
                
            case "Season Pass":
                
                selectedEntrantSubtype = .SeasonGuestPass
                activateTextFieldsForSeasonPassGuests()
                
            default:
                return
            }
            
        case .Employee:
            
            switch buttonTitle {
                
            case "Food Services":
                
                selectedEntrantSubtype = .FoodServicePass
                activateTextFieldsForEmployeesAndManagers()
                
            case "Ride Services":
                
                selectedEntrantSubtype = .RideServicePass
                activateTextFieldsForEmployeesAndManagers()
                
            case "Maintenance":
                
                selectedEntrantSubtype = .MaintenancePass
                activateTextFieldsForEmployeesAndManagers()
                
            default:
                return
            }
            
        case .Manger:
            
            switch buttonTitle {
                
            case "Senior":
                
                selectedEntrantSubtype = .SeniorManagerPass
                activateTextFieldsForEmployeesAndManagers()
                
            case "General":
                
                selectedEntrantSubtype = .GeneralManagerPass
                activateTextFieldsForEmployeesAndManagers()
                
            case "Shift":
                
                selectedEntrantSubtype = .ShiftManagerPass
                activateTextFieldsForEmployeesAndManagers()
                
            default:
                return
            }
            
        case .Contractor:
            
            selectedEntrantSubtype = .ContractorPass
            activateTextFieldsForContractors()
            
        case .Vendor:
            
            selectedEntrantSubtype = .VendorPass
            activateTextFieldsForVendors()
            
        default:
            return
        }
    }
    
    func activateTextFieldsForSeasonPassGuests() {
        
        firstNameTextField.changeState = true
        lastNameTextField.changeState = true
        addressTextField.changeState = true
        cityTextField.changeState = true
        stateTextField.changeState = true
        zipCodeTextField.changeState = true
    }
    
    func activateTextFieldsForSeniorGuests() {
        
        firstNameTextField.changeState = true
        lastNameTextField.changeState = true
    }
    
    func activateTextFieldsForEmployeesAndManagers() {
        
        ssnTextField.changeState = true
        firstNameTextField.changeState = true
        lastNameTextField.changeState = true
        addressTextField.changeState = true
        cityTextField.changeState = true
        stateTextField.changeState = true
        zipCodeTextField.changeState = true
    }
    
    func activateTextFieldsForContractors() {
        
        projectNumberTextField.changeState = true
        firstNameTextField.changeState = true
        lastNameTextField.changeState = true
        addressTextField.changeState = true
        cityTextField.changeState = true
        stateTextField.changeState = true
        zipCodeTextField.changeState = true
    }
    
    func activateTextFieldsForVendors() {
        
        dateOfVisitTextField.changeState = true
        firstNameTextField.changeState = true
        lastNameTextField.changeState = true
        companyTextField.changeState = true
    }
    
    func createButton(withTitle title: String, tag: Int, selector: Selector) -> UIButton {
        
        let button = UIButton(type: .System)
        
        button.tag = tag
        button.tintColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(15, weight: UIFontWeightMedium)
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        
        return button
    }
    
    func createEntrantSubTypeStackView(withEntant entrant: EntrantType) {
        
        switch entrant {
            
        case .Guest:
            
            removeButtonsFromStackView()
            
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Child", tag: 0, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Adult", tag: 1, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Senior", tag: 2, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "VIP", tag: 3, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Season Pass", tag: 4, selector: #selector(selectedEntrantSubType)))
            
        case .Employee:
            
            removeButtonsFromStackView()
            
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Food Services", tag: 0, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Ride Services", tag: 1, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Maintenance", tag: 2, selector: #selector(selectedEntrantSubType)))
            
        case .Manger:
            
            removeButtonsFromStackView()
            
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Senior", tag: 0, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "General", tag: 1, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Shift", tag: 2, selector: #selector(selectedEntrantSubType)))
            
        case .Contractor:
            
            removeButtonsFromStackView()
            
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "1001", tag: 0, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "1002", tag: 1, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "1003", tag: 2, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "2001", tag: 2, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "2002", tag: 2, selector: #selector(selectedEntrantSubType)))
            
        case .Vendor:
            
            removeButtonsFromStackView()
            
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Acme", tag: 0, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Orkin", tag: 1, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Fedex", tag: 2, selector: #selector(selectedEntrantSubType)))
            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "NW Electrical", tag: 2, selector: #selector(selectedEntrantSubType)))
            
        case .None:
            
            removeButtonsFromStackView()
        }
    }
    
    //Remove current buttons from stack view
    func removeButtonsFromStackView() {
        
        for button in entrantSubTypeStackView.arrangedSubviews {
            
            entrantSubTypeStackView.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
    }
    
    //Reset all text fields
    func resetTextFields() {
        
        for textField in textFieldArray {
            
            textField.changeState = false
        }
    }
    
    //---------------------------
    //MARK: Prepare For Segue
    //---------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowPass" {
            
            if let vc = segue.destinationViewController as? PassViewController {
                
                vc.guest = guest
            }
        }
    }
    
    //---------------------------
    //MARK: Text Field Delegate
    //---------------------------
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    //Function to set the maximum number of characters for the summoner name text field
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        
        if (textField.text?.characters.count > maxLength) {
            
            textField.deleteBackward()
        }
    }

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //Set the max length for each text field
        checkMaxLength(dateOfBirthTextField, maxLength: 9)
        checkMaxLength(ssnTextField, maxLength: 10)
        checkMaxLength(projectNumberTextField, maxLength: 3)
        checkMaxLength(dateOfVisitTextField, maxLength: 9)
        checkMaxLength(firstNameTextField, maxLength: 16)
        checkMaxLength(lastNameTextField, maxLength: 16)
        checkMaxLength(companyTextField, maxLength: 40)
        checkMaxLength(addressTextField, maxLength: 40)
        checkMaxLength(cityTextField, maxLength: 24)
        checkMaxLength(stateTextField, maxLength: 16)
        checkMaxLength(zipCodeTextField, maxLength: 10)
        
        //Only allow number input to text fields that require numbers only
        if textField == dateOfBirthTextField || textField == ssnTextField || textField == projectNumberTextField || textField == dateOfVisitTextField || textField == zipCodeTextField {
            
            let numberOnly = NSCharacterSet.init(charactersInString: "0123456789/-")
            
            let stringFromTextField = NSCharacterSet.init(charactersInString: string)
            
            let stringValid = numberOnly.isSupersetOfSet(stringFromTextField)
            
            return stringValid
        }
        
        //Only allow character input in text fields that require characters only
        if textField == firstNameTextField || textField == lastNameTextField || textField == companyTextField || textField == cityTextField || textField == stateTextField {
            
            let charactersOnly = NSCharacterSet.init(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
            
            let stringFromTextField = NSCharacterSet.init(charactersInString: string)
            
            let stringValid = charactersOnly.isSupersetOfSet(stringFromTextField)
            
            return stringValid
        }
        
        return true
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

