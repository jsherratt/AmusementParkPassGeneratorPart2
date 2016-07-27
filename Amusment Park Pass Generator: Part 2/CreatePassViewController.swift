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
    var entrantStackView: EntrantType = .None
    var selectedEntrant: EntrantType = .None

    //-----------------------
    //MARK: Outlets
    //-----------------------
    
    //Stackview
    @IBOutlet weak var entrantSubTypeStackView: UIStackView!
    
    //Text fields
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var ssnTextField: TextField!
    @IBOutlet weak var projectNumberTextField: TextField!
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
                
               return
            
            case "Adult":
                
                return
                
            case "Senior":
                
                return
                
            case "VIP":
                
                return
                
            case "Season Pass":
            
                return
                
            default:
                return
            }
            
        case .Employee:
            
            switch buttonTitle {
                
            case "Food Services":
                
                activateTextFieldsForEmployeesAndManagers()
                
            case "Ride Services":
                
                activateTextFieldsForEmployeesAndManagers()
                
            case "Maintenance":
                
                activateTextFieldsForEmployeesAndManagers()
                
            default:
                return
            }
            
        case .Manger:
            
            switch buttonTitle {
                
            case "Senior":
                
                activateTextFieldsForEmployeesAndManagers()
                
            case "General":
                
                activateTextFieldsForEmployeesAndManagers()
                
            case "Shift":
                
                activateTextFieldsForEmployeesAndManagers()
                
            default:
                return
            }
            
        case .Contractor:
            
            switch buttonTitle {
                
            case "1001":
                
                activateTextFieldsForContractors()
                
            case "1002":
                
                activateTextFieldsForContractors()
                
            case "1003":
                
                activateTextFieldsForContractors()
                
            case "2001":
                
                activateTextFieldsForContractors()
                
            case "2002":
                
                activateTextFieldsForContractors()
                
            default:
                return
            }
            
        case .Vendor:
            
            switch buttonTitle {
                
            case "Acme":
                
                activateTextFieldsForVendors()
                
            case "Orkin":
                
                activateTextFieldsForVendors()
                
            case "Fedex":
                
                activateTextFieldsForVendors()
                
            case "NW Electrical":
                
                activateTextFieldsForVendors()
                
            default:
                return
            }
            
        default:
            return
        }
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
    
    func removeButtonsFromStackView() {
        
        for button in entrantSubTypeStackView.arrangedSubviews {
            
            entrantSubTypeStackView.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
    }
    
    func resetTextFields() {
        
        for textField in textFieldArray {
            
            textField.changeState = false
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
        if textField == dateOfBirthTextField {
            checkMaxLength(textField, maxLength: 9)
            
        }else if textField == ssnTextField {
            checkMaxLength(textField, maxLength: 10)
            
        }else if textField == projectNumberTextField {
            checkMaxLength(textField, maxLength: 3)
            
        }else if textField == companyTextField {
            checkMaxLength(textField, maxLength: 40)
            
        }else if textField == addressTextField {
            checkMaxLength(textField, maxLength: 40)
            
        }else if textField == cityTextField {
            checkMaxLength(textField, maxLength: 16)
            
        }else if textField == stateTextField {
            checkMaxLength(textField, maxLength: 24)
            
        }else if textField == zipCodeTextField {
            checkMaxLength(textField, maxLength: 16)
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

