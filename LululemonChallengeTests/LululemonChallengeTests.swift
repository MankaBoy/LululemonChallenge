//
//  LululemonChallengeTests.swift
//  LululemonChallengeTests
//
//  Created by Noor Ali on 5/12/23.
//

import XCTest
import CoreData
@testable import LululemonChallenge
class LululemonChallengeTests: XCTestCase {
    
    let itemsViewModel =  ItemsViewModel()
    let addItemViewModel = AddItemViewModel()
    let editItemViewModel = EditItemViewModel()

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        restoreDataBase()
        
    }

    func testFetchAndSaveData() {
        addItemViewModel.saveDataToCoreData(name: "testGarment1")
        itemsViewModel.fetchDataFromDatabase(sortIndex: 0)
        XCTAssertEqual(itemsViewModel.items.last?.name, "testGarment1")
    }
    
    func testViewModelGetCount() {
        let itemsViewModel = ItemsViewModel()
        itemsViewModel.items = [Item(), Item()]
        XCTAssertEqual(itemsViewModel.getItemsCount(), 2)
    }
    
    func testViewModelDeleteData() {
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        var  originalCount = itemsViewModel.getItemsCount()
        addItemViewModel.saveDataToCoreData(name: "testGarment1")
        addItemViewModel.saveDataToCoreData(name: "testGarment2")
        addItemViewModel.saveDataToCoreData(name: "testGarment3")

        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        originalCount += 3
        XCTAssertEqual(itemsViewModel.getItemsCount(), originalCount)
        let item = itemsViewModel.getItemAtIndex(index: 0)
        if let item = item {
            itemsViewModel.deleteItemAtIndex(item: item)
        }
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        XCTAssertEqual(itemsViewModel.getItemsCount(), originalCount - 1)
    }
    
    func testEditItem() {
        addItemViewModel.saveDataToCoreData(name: "testGarment12")
        addItemViewModel.saveDataToCoreData(name: "testGarmnet2")
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        let itemToEdit = itemsViewModel.getItemAtIndex(index: 0)
        if let itemToEdit = itemToEdit {
            editItemViewModel.editItem(item: itemToEdit, newName: "testGarmentNew")
        }
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        XCTAssertEqual(itemsViewModel.getItemAtIndex(index: 0)?.name, "testGarmentNew")
    }
    
    
    func restoreDataBase() {
        let dbManager = DataBaseManager.shared
        let request = Item.fetchRequest() as NSFetchRequest<Item>
        request.predicate = NSPredicate(format: "name BEGINSWITH[c] %@", "test")

        do {
            let results = try dbManager.context.fetch(request)
              for res in results{
                dbManager.context.delete(res)
              }
            try dbManager.context.save()
        } catch let error as NSError {
            print("Could not restore. \(error), \(error.userInfo)")
        }
    }

}
