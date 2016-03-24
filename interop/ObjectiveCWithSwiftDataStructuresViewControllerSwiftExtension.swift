//
//  ObjectiveCWithSwiftDataStructuresViewControllerSwiftExtension.swift
//  interop
//
//  Created by Daniel Wallace on 24/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import Foundation

extension ObjectiveCWithSwiftDataStructuresViewController {
    
    // Can store the User struct and pass it on to something else. Not usable in Obj-C code though.
    var user: User {
        get {
            return (_user as! Box<User>).value
        }
        set{
            _user = Box(newValue)
        }
    }
    
    var icon1: Icon {
        get {
            return (_icon1 as! Box<Icon>).value
        }
        set{
            _icon1 = Box(newValue)
        }
    }
    
    var icon2: Icon {
        get {
            return (_icon2 as! Box<Icon>).value
        }
        set{
            _icon2 = Box(newValue)
        }
    }
}
