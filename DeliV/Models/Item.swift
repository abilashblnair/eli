//
//  DeliV.swift
//  DeliV
//
//  Created by Abilash Cumulations on 01/07/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class Item: Equatable {
    
    /// hash value
    var hashValue: Int {
        return id.hashValue
    }
    
    /// Equatable protocol implementation
    ///
    /// - Parameters:
    ///   - lhs: the left object
    ///   - rhs: the right object
    /// - Returns: true - if objects are equal, false - else
    static func == (lhs: Item, rhs: Item) -> Bool {
       return lhs.hashValue == rhs.hashValue
    }
    
    var imageUrl = ""
    var description = ""
    var id = 0
    var location:Location?

    /// Parse JSON into model object
    ///
    /// - Parameter json: the JSON
    /// - Returns: object
    class func fromJson(_ json: JSON) -> Item {
        let object = Item()
        object.id = json["id"].intValue
        object.imageUrl = json["imageUrl"].stringValue
        object.description = json["description"].stringValue
        object.location = Location.fromJson(json["location"])
        return object
    }
    
}
class Location{

    var lat = 0.0
    var long = 0.0
    var address = ""
    
    /// Parse JSON into model object
    ///
    /// - Parameter json: the JSON
    /// - Returns: object
    class func fromJson(_ json: JSON) -> Location {
        let object = Location()
        object.lat = json["lat"].doubleValue
        object.long = json["lng"].doubleValue
        object.address = json["address"].stringValue
        return object
    }
    
}
