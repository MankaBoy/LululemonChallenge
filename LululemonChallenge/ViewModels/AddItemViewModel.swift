//
//  AddItemViewModel.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//

import Foundation
class AddItemViewModel {
    let dbManager = DataBaseManager.shared
    func saveDataToCoreData(name: String) {
        dbManager.saveItem(name: name)
    }
}
