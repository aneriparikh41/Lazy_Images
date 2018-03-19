//
//  ResponseParser.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation

class ResponseParser {
    
    //MARK:- Images
    
    class func imagesFromJSON(_ json:JSON) -> [Images] {
        let imagesJson = json["rows"]
        var images = [Images]()
        for image in imagesJson {
            do {
                images.append(try Images(json: image))
            }
            catch ImagesError.imageIDEmpty {
                print("imageIDEmpty")
            }
            catch {}
        }
        return images
}

