//
//  EditItemViewController.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/15/23.
//

import UIKit

class EditItemViewController: UIViewController {
    var completionHandler: (() -> Void)?
    let viewModel = EditItemViewModel()
    var itemName: String?
    var item: Item?
    private var label: UILabel =  {
        let label = UILabel()
        label.text = "Edit Garment Name"
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
        self.view.addSubview(label)
        self.view.addSubview(itemNameTextField)
        itemNameTextField.text = itemName!
        setUpLayoutConstraints()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(finishEditing))


        
    }
    @objc func finishEditing() {
        if let name = itemNameTextField.text, !(itemNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            viewModel.editItem(item: self.item!, newName: name)
            completionHandler?()
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            itemNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            itemNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            itemNameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            itemNameTextField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -600)
        ])
    }
    

}
