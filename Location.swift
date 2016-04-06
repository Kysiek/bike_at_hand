//
//  Location.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 17/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit
import ObjectMapper

class Location: Mappable {
    
    var latitude: Double!
    var longitude: Double!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
    
}
