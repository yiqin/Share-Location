//
//  CurrentUserManager.swift
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

class CurrentUserManager: NSObject {

    var hasLoginWithFacebook = false
    
    class var sharedInstance : CurrentUserManager {
        struct Static {
            static let instance = CurrentUserManager()
        }
        return Static.instance
    }
    
    // update later
    func saveCurrentGeopointToParse(){
        
        PFUser.currentUser()["name"] = "test"
        PFUser.currentUser()["screenName"] = "test"
        
        PFUser.currentUser().saveInBackgroundWithBlock { (succeeded:Bool!, error:NSError!) -> Void in
            if((succeeded) != nil){
                println("update pfuser successfully.")
            }
        }
    }

    
}
