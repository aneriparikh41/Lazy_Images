//
//  NetworkManager.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation
import UIKit


class NetworkManager: NSObject {
    /**
     You obtain the global instance from a singleton class through a factory method.
     */
    static let shared = NetworkManager()
    var images = DataManager.sharedInstance.images
    
    /**
     fetch(for:completion:error:) will fetch Images data. URL will be supplied from Constants.URL structure.
     
     - parameters:
     - for: A url to fetch the data.
     - completion: Handle the fetched list. Output will be a [String : AnyObject]
     - error: Handle errors which may come from API.
     */
    func fetch(completion: @escaping Constants.Blocks.Completion, error: @escaping Constants.Blocks.Error) {
        guard let url = Constants.URL.path else {
            return
        }
        GET(url, completion: { (json) in
            if let data = json as? [String: Any], let imageData = data["rows"] as? [[String: AnyObject]] {
                  self.images = ResponseParser.imagesFromJSON(imageData)
                  DataManager.sharedInstance.images = self.images
                  completion()
            }
        }, error: error)
    }
    
    /**
     Privately used by NetworkManager for generate a get request for the given url.
     
     - parameters:
     - url: URL instance of image url.
     - completion: Handle the fetched data.
     - error: Handle errors which may come from API.
     */
    fileprivate func GET(_ url: URL, completion: @escaping (Any) -> Void, error errorBlock: Constants.Blocks.Error?) {
        print(url)
        var request = URLRequest(url: url)
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")  // the request is JSON
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do{
                    if let strData = NSString(data: data, encoding: String.Encoding.isoLatin1.rawValue), let finalData = strData.data(using: String.Encoding.utf8.rawValue) {
                        let json = try? JSONSerialization.jsonObject(with: finalData, options: [])
                        if let rootDictionary = json {
                            completion(rootDictionary)
                        }
                    }
                } catch {
                    if let errorBlock = errorBlock {
                        errorBlock(Constants.Messages.unexpectedError)
                    }
                    completion(error)
                }
            } else {
                completion(error!)
            }
            }.resume()
        
    }
}



