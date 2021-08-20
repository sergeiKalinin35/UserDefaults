//
//  NewContactViewController.swift
//  UserDefaults
//
//  Created by Sergey on 20.08.2021.
//



import UIKit

protocol NewContactViewControllerDelegate {
    func saveContact(_ contact: String)
}

class NewContactViewController: UIViewController {

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var delegate: NewContactViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameTextField.addTarget(
            self,
            action: #selector(firstNameTextFieldDidChanged),
            for: .editingChanged
        )
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        saveAndExit()
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
       dismiss(animated: true)
    }
    
    @objc private func firstNameTextFieldDidChanged() {
        guard let firstName = firstNameTextField.text  else { return }
        doneButton.isEnabled = !firstName.isEmpty ? true : false 
    }

    private func  saveAndExit() {
        guard let firstName = firstNameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        delegate.saveContact("\(firstName) \(lastName)")
        dismiss(animated: true)
    }
    
    
}
