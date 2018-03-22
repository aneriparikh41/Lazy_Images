//
//  NetworkTestCases.swift
//  TelstraAssignment
//
//  Created by Yash on 22/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//


import XCTest
@testable import TelstraAssignment

class NetworkTestCases: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func testFetchingImages() {
        let expectation = self.expectation(description: "images")
        
        NetworkManager.shared.fetch(completion: { 
            XCTAssertNotNil(DataManager.sharedInstance.images.count > 0)
            expectation.fulfill()
        }) { (message) in
            XCTAssertNil(message, "Error should be nil")
        }
            waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, "Request timeout")
        }
    }
    

    
}
