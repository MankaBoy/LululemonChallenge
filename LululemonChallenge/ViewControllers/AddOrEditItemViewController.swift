//
//  EditItemViewController.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/15/23.
//

import UIKit

class AddOrEditItemViewController: UIViewController {
    var completionHandler: (() -> Void)?
    let viewModel = AddAndEditItemViewModel()
    var selectedItem: Item?
    var actionType:ActionType?
    private var descriptionLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray

        return label
    }()
    
    private var itemNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(itemNameTextField)
        self.actionType == .addType ? (self.descriptionLabel.text = "Add Garment Name") : (self.descriptionLabel.text = "Edit Garment Name")
        if let selectedItem = selectedItem {
            itemNameTextField.text = selectedItem.name
        }
        else {
            itemNameTextField.placeholder = "Please Enter a garment name:"
        }
        setUpLayoutConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(finishEditing))
    }
    
    @objc func finishEditing() {
        if let name = itemNameTextField.text, !(itemNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            if let actionType = actionType {
                if actionType == .addType {
                    viewModel.saveDataToCoreData(name: name)
                }
                else {
                    viewModel.editItem(item: self.selectedItem!, newName: name)
                }
                completionHandler?()
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            descriptionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            itemNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            itemNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            itemNameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            itemNameTextField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -600)
        ])
    }
    
}
