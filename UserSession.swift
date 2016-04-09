//
//  UserSession.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 09/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation
import ObjectMapper

class UserSession: NSObject, Mappable {
    var username: String!
    var authKey: String!

    init(username: String, authKey: String) {
        self.username = username
        self.authKey = authKey
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        authKey <- map["authKey"]
    }
    
    func getParameters() -> [String:String] {
        return [ "user" : username, "authKey" : authKey]
    }
    
    required init(coder aDecoder: NSCoder) {
        self.username = aDecoder.decodeObjectForKey("username") as! String
        self.authKey = aDecoder.decodeObjectForKey("authKey") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.username, forKey: "username")
        aCoder.encodeObject(self.authKey, forKey: "authKey")
    }
}