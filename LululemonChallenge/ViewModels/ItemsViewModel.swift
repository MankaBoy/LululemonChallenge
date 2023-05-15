//
//  ItemsViewModel.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//
import Foundation
class ItemsViewModel {
    var items: [Item] = []
    let dbManager =  DataBaseManager.shared
    
    func fetchDataFromDatabase(sortIndex: Int) {
        // define sort rule
        var sort: NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        switch sortIndex {
        case 0:
            sort = NSSortDescriptor(key: "name", ascending: true)
        case 1:
            sort = NSSortDescriptor(key: "time", ascending: false)
        default:
            break
        }
        self.items = dbManager.fetchItems(sort: sort)
    }

    func getItemsCount() -> Int {
        return items.count
    }
    
    func getItemAtIndex(index: Int) -> Item? {
        return items[index]
    }
    
    func deleteItemAtIndex(item: Item) {
        dbManager.deleteItem(item: item)
    }
}




