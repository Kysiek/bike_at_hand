//
//  NetworkManagerImpl.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 06/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkManagerImpl: NetworkManager {
    
    func authenticate(username: String,
                      password: String,
                      successCallback: () -> (),
                      errorCallback: (String) -> (),
                      saveUserSessionCallback: (UserSession) -> ()) {
        Alamofire
            .request(.POST,
                Url.getPath(Url.Login),
                parameters: ["user": username, "pass": password],
                encoding: .JSON)
            
            .responseObject { (response: Response<UserSession, NSError>) in
                if let httpResponce = response.response {
                    switch httpResponce.statusCode {
                    case NetworkResponseCode.Success:
                        saveUserSessionCallback(response.result.value!)
                        successCallback()
                    case NetworkResponseCode.Login.UsernameOrPasswordNotProvided:
                        errorCallback(ErrorMessage.NetworkResponse.UsernameOrPasswordNotProvided)
                    case NetworkResponseCode.Login.InvalidCredentials:
                        errorCallback(ErrorMessage.NetworkResponse.InvalidCredentials)
                    default:
                        errorCallback(ErrorMessage.NetworkResponse.NetworkingProblem)
                    }
                } else {
                    errorCallback(ErrorMessage.NetworkResponse.NetworkingProblem)
                }
            }
    }
    
    func checkIfLogged(userSession: UserSession, success: () -> (), notLoggedCallback: () -> ()) {
        Alamofire
            .request(.GET,
                NSURL(string: Url.getPath(Url.Logged))!,
                parameters: userSession.getParameters())
            .response { request, response, data, error in
                
                if let httpResponce = response {
                    switch httpResponce.statusCode {
                    case NetworkResponseCode.Success:
                        success()
                    case NetworkResponseCode.Unauthorized:
                        notLoggedCallback()
                    default:
                        notLoggedCallback()
                    }
                } else {
                    notLoggedCallback()
                }
                
        }
    }
    
    func getAllStations(userSession: UserSession,
                        successCallback: ([Station]) -> (),
                        errorCallback: (String) -> ()) {
        Alamofire
            .request(.GET,
                NSURL(string:  Url.getPath(Url.AllStations))!,
                parameters: userSession.getParameters())
            .responseArray { (response: Response<[Station], NSError>) in
                if let httpResponce = response.response {
                    switch httpResponce.statusCode {
                    case NetworkResponseCode.Success:
                        successCallback(response.result.value!)
                    case NetworkResponseCode.Unauthorized:
                        errorCallback(ErrorMessage.NetworkResponse.Unauthorized)
                    default:
                        errorCallback(ErrorMessage.NetworkResponse.NetworkingProblem)
                    }
                } else {
                    errorCallback(ErrorMessage.NetworkResponse.NetworkingProblem)
                }
                
            }
    }
    
    func getAvailableBikesForStationNumber(userSession: UserSession,
                                           number: String,
                                           successCallback: ([Bike]) -> (),
                                           errorCallback: (String) -> ()) {
        Alamofire
            .request(.GET,
                NSURL(string: Url.getPathWithParameter(Url.StationsForBikes, parameter: number))!,
                parameters: userSession.getParameters())
            .responseArray { (response: Response<[Bike], NSError>) in
                
                if let httpResponce = response.response {
                    switch httpResponce.statusCode {
                    case NetworkResponseCode.Success:
                        successCallback(response.result.value!)
                    case NetworkResponseCode.Unauthorized:
                        errorCallback(ErrorMessage.NetworkResponse.Unauthorized)
                    default:
                        errorCallback(ErrorMessage.NetworkResponse.NetworkingProblem)
                    }
                } else {
                    errorCallback(ErrorMessage.NetworkResponse.NetworkingProblem)
                }
            }
    }
}

