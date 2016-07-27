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
    
    @IBOutlet var textFieldArray: [TextField]!
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
            
            createEntrantSubTypeStackView(withEntant: .Manger)
            
        case "Contractor":
            
            createEntrantSubTypeStackView(withEntant: .Contractor)
            
        case "Vendor":
            
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
            
            activateTextFieldsForEmployeesAndManagers()
            
        case .Manger:
            
            activateTextFieldsForEmployeesAndManagers()
            
            
        default:
            return
        }
    }
    
    func activateTextFieldsForEmployeesAndManagers() {
        
        dateOfBirthTextField.changeState = true
        firstNameTextField.changeState = true
        lastNameTextField.changeState = true
        addressTextField.changeState = true
        cityTextField.changeState = true
        stateTextField.changeState = true
        zipCodeTextField.changeState = true
        
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
            
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Senior", tag: 0, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "General", tag: 1, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Shift", tag: 2, selector: #selector(selectedEntrantSubType)))
            
        case .Contractor:
            
            removeButtonsFromStackView()
            
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "1001", tag: 0, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "1002", tag: 1, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "1003", tag: 2, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "2001", tag: 2, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "2002", tag: 2, selector: #selector(selectedEntrantSubType)))
            
        case .Vendor:
            
            removeButtonsFromStackView()
            
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Acme", tag: 0, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Orkin", tag: 1, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "Fedex", tag: 2, selector: #selector(selectedEntrantSubType)))
//            entrantSubTypeStackView.addArrangedSubview(createButton(withTitle: "NW Electrical", tag: 2, selector: #selector(selectedEntrantSubType)))
            
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

