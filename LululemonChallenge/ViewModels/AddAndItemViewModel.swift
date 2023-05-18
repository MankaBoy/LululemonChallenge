//
//  AddItemViewModel.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//

import Foundation
class AddAndEditItemViewModel {
    let dbManager = DataBaseManager.shared
    func saveDataToCoreData(name: String) {
        dbManager.saveItem(name: name)
    }
    func editItem(item: Item, newName: String) {
        dbManager.editItem(item: item, newName: newName)
    }
}
