//
//  Hasura.swift
//  iOS-app
//
//  Created by Jaison on 03/11/17.
//  Copyright © 2017 Hasura. All rights reserved.
//

import Foundation
import Alamofire

class Hasura {
    
    public enum URL: String {
        case auth = "auth"
        case filestore = "filestore"
        case data = "data"
        
        func getURL() -> String {
            let clusterName = "h34-nylon80-stg"
            return "https://" + self.rawValue + "." + clusterName + ".hasura-app.io/"
        }
    }
    
    static func saveAuthToken(authToken: String) {
        UserDefaults.standard.set(authToken, forKey: "auth_token")
    }
    
    static func getSavedAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: "auth_token")
    }
    
}
