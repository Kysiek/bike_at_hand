//
//  NetworkClient.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 14/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

protocol NetworkManager {

    func authenticate(username: String,
                      password: String,
                      successCallback: () -> (),
                      errorCallback: (String) -> (),
                      saveUserSessionCallback: (UserSession) -> ())
    
    func getAllStations(userSession: UserSession,
                        successCallback: ([Station]) -> (),
                        errorCallback: (String) -> ())
    
    func checkIfLogged(userSession: UserSession, success: () -> (), notLoggedCallback: () -> ())
    
    
    func getAvailableBikesForStationNumber(userSession: UserSession,
                                           number: String,
                                           successCallback: ([Bike]) -> (),
                                           errorCallback: (String) -> ())
}