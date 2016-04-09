//
//  Config.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 14/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation

struct Config {
    struct URLStore {
        private static let rootUrl = "http://localhost:3000"
        static let login = "/account/login"
        static let stations = "/account/history"
        
        static func getPath(path: String) -> String {
            return rootUrl + path
        }
    }
    struct RequestKeys {
        static let username = "user"
        static let password = "pass"
    }
    struct NotificationMessages {
        static let UserAuthenticated = "UserAuthenticated"
        static let AuthenticationError = "AuthenticationError"
    }
    struct NotificationDataKeys {
        static let ErrorMessage = "errorMessage"
    }
    struct ErrorMessages {
        static let unauthorized = "Invalid username or password"
        static let defaultMessage = "Something has gone wrong"
    }
    struct AlertMessages {
        static let ErrorTitle = "Error"
        static let DoneButtonTitle = "Done"
    }
    struct NSUserDefaultsKeys {
        static let Username = "username"
    }
}