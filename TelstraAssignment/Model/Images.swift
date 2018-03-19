//
//  Images.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation
/* Class is used to store information for all the Images
 */
class Images
{
    var title : String = ""
    var description : String = ""
    var imageURL : String = ""
    
    convenience init(json :JSON) throws{
        self.init()
      
        if let title = json["title"].string {
            self.title  = title
        }
        
        if let description = json["description"].string {
            self.description  = description
        }
        
        if let imageURL = json["imageHref"].string {
            self.imageURL  = imageURL
        }
    }
}

//Error Type
enum ImagesError: Error {
    case imageIDEmpty
}
