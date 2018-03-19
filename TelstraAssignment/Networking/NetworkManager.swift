//
//  NetworkManager.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation
import UIKit
import GZIP


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
            if let json = json as? [String: AnyObject] {
                self.images = ResponseParser.imagesFromJSON(json)
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
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data as? NSData {
                do{
                    let decompressedData: Data
                    if data.isGzippedData() {
                        decompressedData = try data.gunzipped()!
                    } else {
                        decompressedData = data as Data
                    }
                    let json = try? JSONSerialization.jsonObject(with: decompressedData, options: [])
                    if let rootDictionary = json as? [String: Any] {
                        completion(rootDictionary["rows"])
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



