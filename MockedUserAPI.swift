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
    
    required init(persistencyManager: PersistencyManager, networkManager: NetworkManager) {
        self.persistencyManager = persistencyManager
        self.networkManager = networkManager
    }
    
    func authenticate(username: String,
                      password: String,
                      success: () -> (),
                      error: (String) -> ()) {
        
        networkManager.authenticate(username,
                                    password: password,
                                    successCallback: success,
                                    errorCallback: error,
                                    saveUserSessionCallback: { userSession in
                                        self.persistencyManager.saveUserSession(userSession)
                                    })
        
    }
    func checkIfLogged(success: () -> (), notLoggedCallback: () -> ()) {
        
        if let userSession = persistencyManager.getUserSession() {
            networkManager.checkIfLogged(userSession,
                                         success: success,
                                         notLoggedCallback: notLoggedCallback)
        } else {
            notLoggedCallback()
        }
    }
    func getStations(success: ([Station]) -> (), error: (String) -> ()) {
        networkManager.getAllStations(persistencyManager.getUserSession()!,
                                      successCallback: success,
                                      errorCallback: error)
    }
    
    func getRecentlyDownloadedStations() -> [Station] {
        return persistencyManager.getSavedStationArray()
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