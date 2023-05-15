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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        restoreDB()
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchAndSaveData() {
        let itemsViewModel = ItemsViewModel()
        let addItemViewModel = AddItemViewModel()
        var originalCount = 0
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        originalCount = itemsViewModel.items.count
        
        addItemViewModel.saveDataToCoreData(name: "testGarment1")
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        XCTAssertEqual(itemsViewModel.getItemAtIndex(index: originalCount)?.name, "testGarment1")
    }
    
    func testViewModelGetCount() {
        let itemsViewModel = ItemsViewModel()
        itemsViewModel.items = [Item(), Item()]
        XCTAssertEqual(itemsViewModel.getItemsCount(), 2)
    }
    
    func testViewModelDeleteData() {
        let itemsViewModel =  ItemsViewModel()
        let addItemViewModel = AddItemViewModel()
        addItemViewModel.saveDataToCoreData(name: "testGarment1")
        addItemViewModel.saveDataToCoreData(name: "testGarment2")
        addItemViewModel.saveDataToCoreData(name: "testGarment3")

        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        XCTAssertEqual(itemsViewModel.getItemsCount(), 3)
        let item = itemsViewModel.getItemAtIndex(index: 0)
        if let item = item {
            itemsViewModel.deleteItemAtIndex(item: item)
        }
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        XCTAssertEqual(itemsViewModel.getItemsCount(), 2)
    }
    
    func testEditItem() {
        let itemsViewModel = ItemsViewModel()
        let addItemViewModel = AddItemViewModel()
        addItemViewModel.saveDataToCoreData(name: "testGarment12")
        addItemViewModel.saveDataToCoreData(name: "testGarmnet2")
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        let editItemViewModel = EditItemViewModel()
        let itemToEdit = itemsViewModel.getItemAtIndex(index: 0)
        if let itemToEdit = itemToEdit {
            editItemViewModel.editItem(item: itemToEdit, newName: "TestGarmentNew")
        }
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        XCTAssertEqual(itemsViewModel.getItemAtIndex(index: 0)?.name, "TestGarmentNew")
    }
    
    func restoreDB() {
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
