//
//  LululemonChallengeTests.swift
//  LululemonChallengeTests
//
//  Created by Noor Ali on 5/12/23.
//

import XCTest
@testable import LululemonChallenge

class LululemonChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
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
    
    func testListVMFetchAndSaveData() {
        let itemsViewModel = ItemsViewModel()
        let addItemViewModel = AddItemViewModel()
        var originalCount = 0
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        originalCount = itemsViewModel.items.count
        
        addItemViewModel.saveDataToCoreData(name: "testGarment1")
        itemsViewModel.fetchDataFromDatabase(sortIndex: 1)
        XCTAssertEqual(itemsViewModel.getItemName(index: originalCount), "testGarment1")
    }
    
    func testListVMGetCount() {
        let itemsViewModel = ItemsViewModel()
        itemsViewModel.items = [Item(), Item(), Item()]
        XCTAssertEqual(itemsViewModel.getItemsCount(), 3)
    }

}
