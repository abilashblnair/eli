//
//  Application.swift
//  RRD Camera Blocker
//
//  Created by Abilash Cumulations on 03/01/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit


class Application: NSObject {


    private static var sharedApplicationInstance: Application = {
        let applicationInstance = Application()
        return applicationInstance
    }()
    
    @objc class func sharedInstance () -> Application {
        return sharedApplicationInstance
    }
    
  
}
