//
//  ViewController.swift
//  PlayerInfo
//
//  Created by 330Mac on 2019-04-05.
//  Copyright © 2019 Yaxin Yuan. All rights reserved.
//

import UIKit
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

class UserInfoViewController: UIViewController{
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        user = loadJsonForUser()
        firstNameLabel.text = user?.first_name
        lastNameLabel.text = user?.last_name
    }
    
    func loadJsonForUser() -> User?{
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            guard let thejsonResult = jsonResult as? Dictionary<String, AnyObject> else{
                return nil
            }
            
            guard let metaData = thejsonResult["metadata"] as? Dictionary<String, AnyObject> else{
                return nil
            }
            
            if let currentUser = metaData["current_user"] as? Dictionary<String, AnyObject>{
                print("current user exists")
                return User(JSON: currentUser)
            }
        }
        return nil
    }
    
    @IBAction func showTeam(_ sender: UIBarButtonItem) {
        let teamInfoSB = UIStoryboard.init(name: "TeamInfoSB", bundle: nil)
        let teamInfoVC = teamInfoSB.instantiateInitialViewController() as! TeamInfoViewController
        self.navigationController?.pushViewController(teamInfoVC, animated: true)
    }
}


