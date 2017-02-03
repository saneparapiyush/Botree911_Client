//
//  Project.swift
//  Botree911_Client
//
//  Created by piyushMac on 03/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import SwiftyJSON

class Project {
    var id: Int?
    var name: String?
    var description: String?
    var total_member:Int?
    var client:[Client]?
    var project_manager:[ProjectManager]?
    var team_leader:[TeamLeader]?
    var team_member:[TeamMember]?
    
    init(json: JSON) {
        id = json.dictionaryObject!["id"] as? Int
        name = json.dictionaryObject!["name"] as? String
        description = json.dictionaryObject!["description"] as? String
        total_member = json.dictionaryObject!["total_member"] as? Int
        client = json.dictionaryObject!["client"] as? [Client]
        project_manager = json.dictionaryObject!["project_manager"] as? [ProjectManager]
        team_leader = json.dictionaryObject!["team_leader"] as? [TeamLeader]
        team_member = json.dictionaryObject!["team_member"] as? [TeamMember]
    }
}

class Client {
    var client_name: String?
    
    init(name: String) {
        client_name = name
    }
}


class ProjectManager {
    var project_manager_name: String?
    
    init(name: String) {
        project_manager_name = name
    }
}

class TeamLeader {
    var team_leader_name: String?
    
    init(name: String) {
        team_leader_name = name
    }
}

class TeamMember {
    var team_member_name: String?
    
    init(name: String) {
        team_member_name = name
    }
}

