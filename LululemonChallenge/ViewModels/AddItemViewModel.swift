//
//  AddItemViewModel.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//

import Foundation
class AddItemViewModel {
    let apiService = APIService.shared
    func saveDataToCoreData(name: String) {
        apiService.saveItem(name: name)
    }
}
