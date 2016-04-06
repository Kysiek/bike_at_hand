//
//  APIFactory.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 06/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation


/*
 This class is for creating appropriate instance of class conforming protocol UserAPI.
 It acts like dependency injection manager
 */
class APIFactory {
    
    
    static func getAPIWithMockedUserAPIAndPersistencyManagerAndNetworkManagerImpl() -> UserAPI {
        return MockedUserAPI(persistencyManager: MockedPersistencyManager(), networkManager: NetworkManagerImpl())
    }
    
    static func getAPIWithMockedUserAPIAndPersistencyManager() -> UserAPI {
        return MockedUserAPI(persistencyManager: MockedPersistencyManager(), networkManager: NetworkManagerImpl())
    }
    
    
}