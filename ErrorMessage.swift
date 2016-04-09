//
//  NetworkMessages.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 09/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation

struct ErrorMessage {
    
    struct NetworkResponse {
        static let NetworkingProblem = "There were problems with the networking. Please try again later"
        static let UsernameOrPasswordNotProvided = "Please provide valid credentials"
        static let InvalidCredentials = "Username or password not valid"
        static let Unauthorized = "You are not authorized"
    }
}