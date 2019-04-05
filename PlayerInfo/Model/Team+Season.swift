//
//  Team+Season.swift
//  PlayerInfo
//
//  Created by 330Mac on 2019-04-05.
//  Copyright © 2019 Yaxin Yuan. All rights reserved.
//

import Foundation
import ObjectMapper

class Team: Mappable{
    var name: String?
    var league_name: String?
    var season: Season?
    var org_name: String?
    var abbrev: String?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        league_name <- map["league_name"]
        org_name <- map["organization_name"]
        abbrev <- map["abbrev"]
        season <- map["current_subseason"]
    }
}

class Season: Mappable{
    var season_name: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        season_name <- map["season_name"]
    }
}
