//
//  AddNewItemViewController.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//

import UIKit
import Foundation

class AddNewItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var garmentName: UILabel!
    let addViewModel = AddItemViewModel ()
    var completionHandler: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveItemButtonAction(_ sender: Any) {
        if let name = itemNameTextField.text, !(itemNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            addViewModel.saveDataToCoreData(name: name)
            completionHandler?()
        }
        
        self.dismiss(animated: true)
    }
    
}


