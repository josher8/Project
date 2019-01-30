//
//  File.swift
//  Event
//
//  Created by Josh Slebodnik on 1/29/19.
//  Copyright © 2019 Josh Slebodnik. All rights reserved.
//

import Foundation
import Alamofire

public enum EventRouter: URLRequestConvertible {
    
    enum EventConstants {
        //Base URL Path. Gets configuration variables. Would be different base url for Dev and Prod
        static let baseURLPath = Bundle.main.infoDictionary!["base_url"] as! String
    }
    
    case events
    case eventsID(String)
    case speakers(String)
    
    var method: HTTPMethod {
        
        switch self {
        case .events, .eventsID, .speakers:
            return .get
        }
        
    }
    
    var path: String {
        
        switch self {
        case .events:
            return "/events"
        case .eventsID:
            return "/events"
        case .speakers:
            return "/speakers"
        }
        
    }
    
    var parameters: [String : Any] {
        
        switch self {
        case .eventsID(let id):
            return ["id":id]
        case .speakers(let id):
            return ["id":id]
        default:
            return [:]
        }
        
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try EventConstants.baseURLPath.asURL()
        
        //Gets token from user defaults.
        var token = ""
        if UserDefaults.standard.object(forKey: "token") != nil{
            token = UserDefaults.standard.object(forKey: "token") as! String
        }
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        return try URLEncoding.default.encode(request, with: parameters)
        
    }
    
}
