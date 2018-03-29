//
//  Constants.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation

/*You can define all your constants with in this structure. You can use an constant by calling Constants.Define.YourConstantName
 - remark: You should use nested structure.
 */

struct Constants {
    
    /**
     Define your network related constants.
     */
    struct URL {
        fileprivate static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        
        static var path: Foundation.URL? {
            if let pathURL = Foundation.URL(string: URL.baseURL) {
                return pathURL
            }
            return nil
        }
    }
    
    /**
     Define your blocks here.
     */
    struct Blocks {
        typealias Error = (String) -> Void
        typealias Completion = (Bool) -> Void
        typealias NetworkResponseDictionary = ([String: AnyObject]) -> Void
    }
    
    struct MagicNumbers {
        static let rowHeight = 200.0
    }
    /**
     Define your messages here.
     */
    struct Messages {
        static let unexpectedError = "Sorry! Unexpected error"
        static let title = "About Canada"
        static let networkError = "No Network Found!"
    }
}
