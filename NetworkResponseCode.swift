//
//  NetworkResponseCode.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 09/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation

struct NetworkResponseCode {
    
    static let Success = 200
    static let Unauthorized = 401
    
    struct Login {
        static let UsernameOrPasswordNotProvided = 460
        static let InvalidCredentials = 461
    }
}