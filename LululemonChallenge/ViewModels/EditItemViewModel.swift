//
//  EditItemViewModel.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/15/23.
//

class EditItemViewModel {
    let apiShared = APIService.shared
    
    func editItem(item: Item, newName: String) {
        apiShared.editItem(item: item, newName: newName)
    }
}
