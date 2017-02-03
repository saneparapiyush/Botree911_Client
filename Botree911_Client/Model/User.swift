//
//  User.swift
//  Botree911_Client
//
//  Created by piyushMac on 02/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import SwiftyJSON

class User: NSCoder {
    var firstName: String?
    var lastName: String?
    var email: String?
    var accessToken : String?
    
    init(json: JSON) {
        self.firstName = json.dictionaryObject!["first_name"] as? String
        self.lastName = json.dictionaryObject!["last_name"] as? String
        self.email = json.dictionaryObject!["email"] as? String
        self.accessToken = json.dictionaryObject!["access_token"] as? String
    }
    
    init(coder aDecoder: NSCoder!) {
        self.firstName = aDecoder.decodeObject(forKey: "first_name") as? String
        self.lastName = aDecoder.decodeObject(forKey: "last_name") as! String?
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.accessToken = aDecoder.decodeObject(forKey: "access_token") as! String?
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encode(firstName, forKey: "first_name")
        aCoder.encode(lastName, forKey: "last_name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(accessToken, forKey: "access_token")
    }
}
