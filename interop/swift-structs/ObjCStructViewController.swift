//
//  ObjCStructViewController.swift
//  interop
//
//  Created by Daniel Wallace on 14/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import Foundation

extension ObjCStructViewController {
    
    // Can store the User struct and pass it on to something else. Not usable in Obj-C code though.
    var user: User {
        get {
            return (_user as! Box<User>).value
        }
        set{
            _user = Box(newValue)
        }
    }
}