//
//  User.swift
//  PlayerInfo
//
//  Created by 330Mac on 2019-04-05.
//  Copyright © 2019 Yaxin Yuan. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var first_name: String?
    var last_name: String?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        first_name  <- map["first_name"]
        last_name   <- map["last_name"]
    }
}
