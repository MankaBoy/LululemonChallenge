//
//  EditItemViewModel.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/15/23.
//

class EditItemViewModel {
    let dbManager = DataBaseManager.shared
    func editItem(item: Item, newName: String) {
        dbManager.editItem(item: item, newName: newName)
    }
}
