//
//  Station.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 17/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit
import ObjectMapper

class Station: Mappable {
    var name: String!
    var number: Int!
    var availableBikes: String!
    var bikeRacks: String!
    var location: Location!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["stationName"]
        number <- map["stationNumber"]
        availableBikes <- map["numberOfAvailableBikes"]
        bikeRacks <- map["bikeRacks"]
        location <- map["location"]
    }
}
