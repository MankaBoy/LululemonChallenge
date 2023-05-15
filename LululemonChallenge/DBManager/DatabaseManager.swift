//
//  DatabaseManager.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//

import Foundation
import UIKit
import CoreData

class DataBaseManager {
    static let shared = DataBaseManager()
    private init(){}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchItems(sort: NSSortDescriptor) -> [Item] {
        var items: [Item] = []
    
        do {
            let request = Item.fetchRequest() as NSFetchRequest<Item>
            request.sortDescriptors = [sort]
            items = try self.context.fetch(request)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return items
    }
    
    func saveItem(name: String) {
        // Create a garment object
        let newItem = Item(context: self.context)
        newItem.name = name
        newItem.time = Date()
        newItem.id = UUID()

        // Save the data
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteItem(item: Item) {
        context.delete(item)
        // Save the data
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    
    func editItem(item: Item, newName: String) {
        item.name = newName
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
}


