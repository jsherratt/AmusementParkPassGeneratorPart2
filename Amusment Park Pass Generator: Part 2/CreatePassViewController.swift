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
    var selectedContractProjectNumber: ProjectNumber?
    var selectedVendorCompany: Company?

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
    //MARK: Views
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        guest = nil
        selectedEntrant = .None
        selectedEntrantSubtype = .None
        selectedContractProjectNumber = nil
        selectedVendorCompany = nil
        resetTextFields()
        removeButtonsFromStackView()
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
            
            createHourlyEmployeeGuest(withWorkType: .FoodServices)
            
        case .RideServicePass:
            
            createHourlyEmployeeGuest(withWorkType: .RideServices)
            
        case .MaintenancePass:
            
            createHourlyEmployeeGuest(withWorkType: .Maintenance)
            
        case .SeniorManagerPass:
            
            createManagerGuest(withManagerType: .SeniorManager)
            
        case .GeneralManagerPass:
            
            createManagerGuest(withManagerType: .GeneralManager)
            
        case .ShiftManagerPass:
            
            createManagerGuest(withManagerType: .ShiftManager)
            
        case .ContractorPass:
            
            if let projectNumber = selectedContractProjectNumber {
                
                createContractEmployeeGuest(withProjectNumber: projectNumber)
            }
            
        case .VendorPass:
            
            if let vendorCompany = selectedVendorCompany {
                
                createVendorGuest(withCompany: vendorCompany)
            }
            
        case .None:
            
            displayAlert("Error", message: "You must select an entrant")
        }
        
        if var entrant = guest {
            
            let pass = kioskControl.createPass(forEntrant: entrant)
            entrant.pass = pass
            guest = entrant
            
            performSegueWithIdentifier("ShowPass", sender: self)
        }
    }
    
    @IBAction func populateData(sender: UIButton) {
        
        switch selectedEntrant {
            
        case .Guest:
            
            switch selectedEntrantSubtype {
                
            case .ChildGuestPass:
                
                dateOfBirthTextField.text = "05/15/2014"
                
            case .AdultGuestPass, .VIPGuestPass:
                
                dateOfBirthTextField.text = "05/15/1995"
                
            case .SeniorGuestPass:
                
                dateOfBirthTextField.text = "05/15/1985"
                firstNameTextField.text = "John"
                lastNameTextField.text = "Appleseed"
                
            case .SeasonGuestPass:
                
                dateOfBirthTextField.text = "05/15/1995"
                firstNameTextField.text = "John"
                lastNameTextField.text = "Appleseed"
                addressTextField.text = "1 Infinte Loop"
                cityTextField.text = "Cupertino"
                stateTextField.text = "CA"
                zipCodeTextField.text = "95014"
                
            default:
                return
            }
            
        case .Employee:
            return
            
        case .Manger:
            return
            
        case .Contractor:
            return
            
        case .Vendor:
            return
            
        case .None:
            
            displayAlert("Error", message: "You must select an entrant")
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
            
            switch buttonTitle {
                
            case "1001":
                selectedContractProjectNumber = .oneThousandOne
                projectNumberTextField.text = "1001"
            case "1002":
                selectedContractProjectNumber = .oneThousandTwo
                projectNumberTextField.text = "1002"
            case "1003":
                selectedContractProjectNumber = .oneThousandThree
                projectNumberTextField.text = "1003"
            case "2001":
                selectedContractProjectNumber = .twoThousandOne
                projectNumberTextField.text = "2001"
            case "2002":
                selectedContractProjectNumber = .twoThousandTwo
                projectNumberTextField.text = "2002"
            default:
                return
            }
            
        case .Vendor:
            
            selectedEntrantSubtype = .VendorPass
            activateTextFieldsForVendors()
            
            switch buttonTitle {
                
            case "Acme":
                selectedVendorCompany = .Acme
                companyTextField.text = "Acme"
            case "Orkin":
                selectedVendorCompany = .Orkin
                companyTextField.text = "Orkin"
            case "Fedex":
                selectedVendorCompany = .Fedex
                companyTextField.text = "Fedex"
            case "NW Electrical":
                selectedVendorCompany = .NWElectrical
                companyTextField.text = "NW Electrical"
            default:
                return
            }
            
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
        
        ssnTextField.changeState = true
        projectNumberTextField.changeState = true
        projectNumberTextField.enabled = false
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
        companyTextField.enabled = false
    }
    
    
    func createHourlyEmployeeGuest(withWorkType workType: WorkType) {
        
        do {
            let hourlyEmployeeGuest = try HourlyEmployee(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: addressTextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: Int(zipCodeTextField.text!), socialSecurityNumber: Int(ssnTextField.text!), dateOfBirth: dateOfBirthTextField.text, workType: workType)
            guest = hourlyEmployeeGuest
            
        }catch Error.MissingDateOfBirth {
            
            displayAlert("Error", message: "You must enter a date of birth")
            
        }catch Error.MissingSocialSecurityNumber {
            
            displayAlert("Error", message: "You must enter a social security number")
            
        }catch Error.MissingName {
            
            displayAlert("Error", message: "You must enter a first and a last name")
            
        }catch Error.MissingAddress {
            
            displayAlert("Error", message: "You must enter an address, city, state and zip code")
            
        }catch let error {
            print(error)
        }
    }
    
    func createContractEmployeeGuest(withProjectNumber projectNumber: ProjectNumber) {
        
        do {
            let contractEmployeeGuest = try ContractEmployee(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: addressTextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: Int(zipCodeTextField.text!), socialSecurityNumber: Int(ssnTextField.text!), dateOfBirth: dateOfBirthTextField.text, projectNumber: projectNumber)
            guest = contractEmployeeGuest
            
        }catch Error.MissingDateOfBirth {
            
            displayAlert("Error", message: "You must enter a date of birth")
            
        }catch Error.MissingSocialSecurityNumber {
            
            displayAlert("Error", message: "You must enter a social security number")
            
        }catch Error.MissingName {
            
            displayAlert("Error", message: "You must enter a first and a last name")
            
        }catch Error.MissingAddress {
            
            displayAlert("Error", message: "You must enter an address, city, state and zip code")
            
        }catch let error {
            print(error)
        }
    }
    
    func createManagerGuest(withManagerType manager: Managers) {
        
        do {
            let managerGuest = try Manager(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: addressTextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: Int(zipCodeTextField.text!), socialSecurityNumber: Int(ssnTextField.text!), dateOfBirth: dateOfBirthTextField.text, managerType: manager)
            guest = managerGuest
            
        }catch Error.MissingDateOfBirth {
            
            displayAlert("Error", message: "You must enter a date of birth")
            
        }catch Error.MissingSocialSecurityNumber {
            
            displayAlert("Error", message: "You must enter a social security number")
            
        }catch Error.MissingName {
            
            displayAlert("Error", message: "You must enter a first and a last name")
            
        }catch Error.MissingAddress {
            
            displayAlert("Error", message: "You must enter an address, city, state and zip code")
            
        }catch let error {
            print(error)
        }
    }
    
    func createVendorGuest(withCompany company: Company) {
        
        do {
            let vendorGuest = try Vendor(firstName: firstNameTextField.text, lastName: lastNameTextField.text, company: company, dateOfBirth: dateOfBirthTextField.text, dateOfVisit: dateOfVisitTextField.text)
            guest = vendorGuest
            
        }catch Error.MissingDateOfBirth {
            
            displayAlert("Error", message: "You must enter a date of birth")
            
        }catch Error.MissingSocialSecurityNumber {
            
            displayAlert("Error", message: "You must enter a social security number")
            
        }catch Error.MissingName {
            
            displayAlert("Error", message: "You must enter a first and a last name")
            
        }catch Error.MissingAddress {
            
            displayAlert("Error", message: "You must enter an address, city, state and zip code")
            
        }catch let error {
            print(error)
        }
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
        
        selectedContractProjectNumber = nil
        selectedVendorCompany = nil
        
        for textField in textFieldArray {
            
            textField.changeState = false
            textField.text = nil
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
    
    //Dismiss the keyboard
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    //As the user is active in the text field
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //Set the max length for each text field
        let setMaxLength = (textField.text?.characters.count)! + string.characters.count - range.length
        
        if textField == dateOfBirthTextField {
            return setMaxLength <= 10
        
        }else if textField == ssnTextField {
            return setMaxLength <= 11
        
        }else if textField == projectNumberTextField {
            return setMaxLength <= 4
        
        }else if textField == dateOfVisitTextField {
            return setMaxLength <= 10
        
        }else if textField == firstNameTextField {
            
            return setMaxLength <= 16
            
        }else if textField == lastNameTextField {
            
            return setMaxLength <= 16
            
        }else if textField == companyTextField {
            return setMaxLength <= 16
        
        }else if textField == addressTextField {
            return setMaxLength <= 48
            
        }else if textField == cityTextField {
            return setMaxLength <= 20
        
        }else if textField == stateTextField {
            return setMaxLength <= 2
        
        }else if textField ==  zipCodeTextField {
            return setMaxLength <= 5
        
        }
        
        //Only allow number input to text fields that require numbers only
        if textField == dateOfBirthTextField || textField == ssnTextField || textField == projectNumberTextField || textField == dateOfVisitTextField || textField == zipCodeTextField {
            
            let numberOnly = NSCharacterSet.init(charactersInString: "0123456789/-")
            
            let stringFromTextField = NSCharacterSet.init(charactersInString: string)
            
            let stringValid = numberOnly.isSupersetOfSet(stringFromTextField)
            
            return stringValid
        }
        
        //Only allow character input in text fields that require characters only
        if textField == firstNameTextField || textField == lastNameTextField || textField == companyTextField || textField == cityTextField || textField == stateTextField {
            
            let charactersOnly = NSCharacterSet.init(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
            
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

