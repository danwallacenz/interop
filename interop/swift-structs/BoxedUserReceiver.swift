//
//  BoxedUserReceiver.swift
//  interop
//
//  Created by Daniel Wallace on 14/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import Foundation

@objc class BoxedUserReceiver:NSObject {
    
    func setUser(user: AnyObject?){
        if let user = user as? Box<User> {
            self.user = user.value
        }
    }
    
    private var user:User? {
        didSet {
            print("User = \(user)")
            print("Pause")
        }
    }
}
