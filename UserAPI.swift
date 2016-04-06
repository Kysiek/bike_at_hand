//
//  UserAPI.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 06/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation

protocol UserAPI {
    
    var persistencyManager: PersistencyManager {get set}
    var networkManager: NetworkManager {get set}
    
    func authenticate(username: String, password: String, complete: (Bool) -> ())
    
    func getStations(success: ([Station]) -> ())
    
    func getPreviousUsername() -> String?
    
    func setPreviousUsername(username: String)
}