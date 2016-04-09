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
    
    init(persistencyManager: PersistencyManager, networkManager: NetworkManager)
    
    func authenticate(username: String,
                      password: String,
                      success: () -> (),
                      error: (String) -> ())
    
    func getStations(success: ([Station]) -> (), error: (String) -> ())
    
    func getRecentlyDownloadedStations() -> [Station]
    
    func getPreviousUsername() -> String?
    
    func setPreviousUsername(username: String)
    
    func checkIfLogged(success: () -> (), notLoggedCallback: () -> ())
    
}