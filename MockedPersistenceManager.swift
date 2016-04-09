//
//  MockedPersistenceManager.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 06/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation

class MockedPersistencyManager: PersistencyManager {
    
    private static let UsernameKey = "usernameKey"
    private static let UserSessionKey = "UserSessionKey"
    
    
    private var userSession: UserSession?
    
    init() {
        loadUserSessionFromUserDefaults()
    }
    
    private var stationArray = [Station]()
    
    func setUsername(username: String) {
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: MockedPersistencyManager.UsernameKey)
    }
    
    func getUsername() -> String? {
        if let username = NSUserDefaults.standardUserDefaults().objectForKey(MockedPersistencyManager.UsernameKey) {
            return username as? String
        }
        return nil
    }
    
    func getUserSession() -> UserSession? {
        return userSession
    }
    
    func saveUserSession(userSession: UserSession) {
        saveUserSessionToUserDefaults(userSession)
        self.userSession = userSession;
    }
    
    func saveStationArray(stationArray: [Station]) {
        self.stationArray = stationArray;
    }
    
    func getSavedStationArray() -> [Station] {
        return stationArray
    }
    
    private func loadUserSessionFromUserDefaults() {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(MockedPersistencyManager.UserSessionKey) as? NSData {
            userSession = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? UserSession
        } else {
            userSession = nil
        }
    }
    
    private func saveUserSessionToUserDefaults(userSession: UserSession) {
        let data  = NSKeyedArchiver.archivedDataWithRootObject(userSession)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: MockedPersistencyManager.UserSessionKey)
    }
}