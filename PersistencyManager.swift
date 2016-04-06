//
//  PersistencyManager.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 15/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

protocol PersistencyManager {
    
    func setUsername(username: String)
    
    func getUsername() -> String?

}
