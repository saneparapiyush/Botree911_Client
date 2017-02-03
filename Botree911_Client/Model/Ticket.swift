//
//  Ticket.swift
//  Botree911_Client
//
//  Created by piyushMac on 03/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import SwiftyJSON

class Ticket {
    var id: Int?
    var project_id: Int?
    var name: String?
    var description: String?
    var status: String?
    var updated_at: String?
    
    init(json: JSON) {
        id = json.dictionaryObject!["id"] as? Int
        project_id = json.dictionaryObject!["project_id"] as? Int
        name = json.dictionaryObject!["name"] as? String
        description = json.dictionaryObject!["description"] as? String
        status = json.dictionaryObject!["status"] as? String
        updated_at = json.dictionaryObject!["updated_at"] as? String
    }
}
