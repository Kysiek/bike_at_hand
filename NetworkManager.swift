//
//  NetworkClient.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 14/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

protocol NetworkManager {

    func getAllStations(success: ([Station]) -> ())
    func getAvailableBikesForStationNumber(number: String, success: ([Bike]) -> ())
    
    
//    func authenticate(username: String, password: String, successCallback: (Void) -> (Void), failureCallback: (String) -> (Void)) {
//        let parameters = [
//            Config.RequestKeys.username : username,
//            Config.RequestKeys.password : password
//        ]
//        Alamofire.request(.POST, Config.URLStore.getPath(Config.URLStore.login), parameters: parameters, encoding: .JSON)
//            .validate(statusCode: [200])
//            .response { request, response, data, error in
//                if error != nil {
//                    let statusCode = response?.statusCode
//                    switch statusCode {
//                        case let statusCode where statusCode == 401:
//                            failureCallback(Config.ErrorMessages.unauthorized)
//                        default:
//                            failureCallback(Config.ErrorMessages.defaultMessage)
//                    }
//                } else {
//                    successCallback()
//                }
//            }
//    }
//    func getStations() {
//        Alamofire.request(.GET, Config.URLStore.getPath(Config.URLStore.stations))
//            .responseJSON { response in
//                debugPrint(response)
//        }
//    }
}