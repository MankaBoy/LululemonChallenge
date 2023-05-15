//
//  ItemsViewModel.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//
import Foundation
struct  Items {
    var name:String
}
class ItemsViewModel {
    var items: [Item] = []
    let apiService = APIService.shared
    
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
        
        apiService.fetchDataFromCoreDataBase(sort: sort) { items in
            self.items = items
        }
    }
    
    
    func getItemsCount() -> Int {
        return items.count
    }
    
    func getItemAtIndex(index: Int) -> Item? {
        return items[index]
    }
    
    func deleteItemAtIndex(item: Item) {
        apiService.deleteItem(item: item)
    }
}




