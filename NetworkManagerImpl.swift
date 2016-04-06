//
//  NetworkManagerImpl.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 06/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkManagerImpl: NetworkManager {
    
    func getAllStations(success: ([Station]) -> ()) {
        Alamofire
            .request(.GET, NSURL(string: "http://localhost:3000/stations/all")!)
            .responseArray { (response: Response<[Station], NSError>) in
                success(response.result.value!)
            }
    }
    
    func getAvailableBikesForStationNumber(number: String, success: ([Bike]) -> ()) {
        Alamofire
            .request(.GET, NSURL(string: "http://localhost:3000/stations/\(number)/bikes")!)
            .responseArray { (response: Response<[Bike], NSError>) in
                success(response.result.value!)
            }
    }
}

