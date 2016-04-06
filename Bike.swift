//
//  Bike.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 17/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit
import ObjectMapper

class Bike: Mappable {
    var number: Int!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        number <- map["number"]
    }
}
