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
    var availableBikes: Int!
    var bikeRacks: Int!
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
    
    func isEmpty() -> Bool {
        return availableBikes == 0
    }
    
    static func filterStations(stations: [Station], containingText text: String, andMayBeEmpty empty: Bool) -> [Station]{
        var newStationArray = [Station]()
        for station in stations {
            if (text.isEmpty || station.name.containsString(text)) && (!station.isEmpty() || empty) {
                newStationArray.append(station)
            }
        }
        return newStationArray
    }
}
