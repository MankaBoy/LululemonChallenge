//
//  APIService.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//

import Foundation
class APIService {
    static let shared = APIService()
    private init(){}
    
    let db = DataBaseManager.shared
    
    func fetchDataFromCoreDataBase(sort: NSSortDescriptor, completionHandler: @escaping ([Item])->()) {
        let items = db.fetchItems(sort: sort)
        completionHandler(items)
    }
    
    func saveItem(name: String) {
        db.saveItem(name: name)
    }
    
    func deleteItem(item: Item) {
        db.deleteItem(item: item)
    }
    
    func editItem(item: Item, newName: String) {
        db.editItem(item: item, newName: newName)
    }
   
}

