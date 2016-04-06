//
//  MockedUserAPI.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 06/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation

class MockedUserAPI: UserAPI {
    
    var networkManager: NetworkManager
    var persistencyManager: PersistencyManager
    
    init(persistencyManager: PersistencyManager, networkManager: NetworkManager) {
        self.persistencyManager = persistencyManager
        self.networkManager = networkManager
    }
    
    func authenticate(username: String, password: String, complete: (Bool) -> ()) {
        delay(1.0) {
            if !username.isEmpty && !password.isEmpty {
                complete(true)
            } else {
                complete(false)
            }
        }
    }
    
    func getStations(success: ([Station]) -> ()) {
        networkManager.getAllStations(success)
    }
    
    func getPreviousUsername() -> String? {
        return persistencyManager.getUsername()
    }
    
    func setPreviousUsername(username: String) {
        persistencyManager.setUsername(username)
    }
    
    func delay(delayTimeInSeconds: Double, closure: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delayTimeInSeconds * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    
}