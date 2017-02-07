//
//  ComunicateService.swift
//  GenericWebServiceCall
//
//  Created by piyushMac on 04/01/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import Foundation
import Alamofire


struct ComunicateService {
//    static let KeyName1 = "page"
//    static let KeyName2 = "KeyName2"
    
    enum Router: URLRequestConvertible {
        static let baseURLString = "http://192.168.0.150:3000/"
        static var OAuthToken: String?
        
        case SignIn(Parameters)
        case ProjectList()
        case StatusList()
        case TicketList(Parameters)
        case CreateTicket(Parameters)
        
        
        var method: Alamofire.HTTPMethod {
            switch self {
                case .SignIn( _):
                    return .post
                case .ProjectList(_):
                    return .get
                case .StatusList():
                    return .get
                case .TicketList(_):
                    return .get
                case .CreateTicket(_):
                    return .post
            }
        }
        
        var path: String {
            switch self {
                case .SignIn( _):
                    return "users/sign_in"
                case .ProjectList( _):
                    return "projects/list"
                case .StatusList( _):
                    return "tickets/status_list"
                case .TicketList(_):
                    return "tickets/list"
                case .CreateTicket(_):
                    return "tickets"
            }
        }

        
        func asURLRequest() throws -> URLRequest {
            let url = URL(string: Router.baseURLString)!
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if let user = UserDefaults.standard.value(forKey: "user") {
                print((user as AnyObject)["access_token"] as! String)
                urlRequest.addValue((user as AnyObject)["access_token"] as! String, forHTTPHeaderField: "access_token")
            }
            
            if let token = Router.OAuthToken {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            switch self {
            case .SignIn(let params):
                return try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)///JSONEncoding if request Parameter in JSON Format
                ///URLEncoding For GET
            case .ProjectList():
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
            
            case .StatusList():
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
                
            case .TicketList(let param):
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: param)
                
            case .CreateTicket(let params):
                return try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)
                
            default:
                return urlRequest
            }
        }
    }
}


extension Request {
    public func debugLog() -> Self {
        do {
            /*let string = try JSONSerialization.jsonObject(with: (request?.httpBody)!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(string)*/
            debugPrint(self)
        } catch {
            print("error")
        }
        return self
    }
}
