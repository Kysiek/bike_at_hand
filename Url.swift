//
//  Url.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 09/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation

struct Url {
    private static let rootUrl = "http://localhost:3000"
    private static let parameterKey = "__XXXParameterXXX___"
    
    static let Login = "/account/login"
    static let Logout = "/account/logout"
    static let Logged = "/account/logged"
    static let StationsForBikes = "/stations/\(parameterKey)/bikes"
    static let AllStations = "/stations/all"
    
    static func getPath(path: String) -> String {
        return rootUrl + path
    }
    
    static func getPathWithParameter(path: String, parameter: String) -> String {
        return rootUrl + path.stringByReplacingOccurrencesOfString(parameterKey, withString: parameter)
    }
}