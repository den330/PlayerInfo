//
//  TeamInfoViewController.swift
//  PlayerInfo
//
//  Created by 330Mac on 2019-04-05.
//  Copyright © 2019 Yaxin Yuan. All rights reserved.
//

import UIKit
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

class TeamInfoViewController: UIViewController {
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    var team: Team?
    
    @IBOutlet weak var orgNameLabel: UILabel!
    
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var abbrevLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        team = loadJsonForTeam()
        teamNameLabel.text = team?.name
        leagueNameLabel.text = team?.league_name
        orgNameLabel.text = team?.org_name
        abbrevLabel.text = team?.abbrev
        seasonNameLabel.text = team?.season?.season_name
        
    }
    
    func loadJsonForTeam() -> Team?{
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            guard let thejsonResult = jsonResult as? Dictionary<String, AnyObject> else{
                return nil
            }
            
            guard let result = thejsonResult["result"] as? [Dictionary<String, AnyObject>] else{
                return nil
            }
            if let currentTeam = result.first?["resource"] as? Dictionary<String, AnyObject>{
                return Team(JSON: currentTeam)
            }
        }
        return nil
    }
    
    
    
}
