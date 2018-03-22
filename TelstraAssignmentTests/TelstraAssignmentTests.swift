//
//  TelstraAssignmentTests.swift
//  TelstraAssignmentTests
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import XCTest
@testable import TelstraAssignment

class TelstraAssignmentTests: XCTestCase {
    
    var imagesVC: ImagesViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        imagesVC = storyboard.instantiateViewController(withIdentifier: "ImagesViewController") as? ImagesViewController
        XCTAssertNotNil(imagesVC, "ImagesViewController not initiated properly")
        
        imagesVC?.performSelector(onMainThread: #selector(imagesVC?.loadView), with: nil, waitUntilDone: true)
        imagesVC?.performSelector(onMainThread: #selector(imagesVC?.viewDidLoad), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    // MARK: - UITableView Testcases
    func testThatViewConformsToTableViewDelegate() {
        XCTAssertTrue(imagesVC!.conforms(to: UITableViewDelegate.self), "ImagesViewController conforms to UITableViewDelegate")
    }
    
    func testThatViewConformsToTableViewDataSources() {
        XCTAssertTrue(imagesVC!.conforms(to: UITableViewDataSource.self), "ImagesViewController conforms to UITableViewDataSources")
    }
    
    func testThatViewLoads() {
        XCTAssertNotNil(imagesVC, "ImagesViewController View not initiated properly")
    }
    
    
    func testThatTableViewLoads() {
        XCTAssertNotNil(imagesVC?.tableView, "TableView not initiated")
    }
    
}
