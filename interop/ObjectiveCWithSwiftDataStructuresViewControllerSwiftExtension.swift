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
    
    var colorIcon: Icon {
        get {
            return (_colorIcon as! Box<Icon>).value
        }
        set{
            _colorIcon = Box(newValue)
        }
    }
    
    var imageIcon: Icon {
        get {
            return (_imageIcon as! Box<Icon>).value
        }
        set{
            _imageIcon = Box(newValue)
        }
    }
    
    /**
     a shim to allow passing a Swift enum to an Objective-C class
     */
    func showIconViewWithIcon(icon: Icon) {
        switch icon {
        case let .Image(image):
            self.showIconViewWithImage(image)
        case let .Color(color):
            self.showIconViewWithColor(color)
        }
    }
    
    /**
     a shim to allow passing a Swift struct to an Objective-C class
     */
    func showProfileViewWithUser(user: User) {
        self.showProfileForUserWithName(user.name, profileImageURL: user.profileImageURL)
    }
    
    
    /**
        Update the user name from Objective-C or Swift via a 'partial' computed property.
    */
    @objc var userName: String {
        get { return user.name }
        set {
            user = User(
                name: newValue,
                profileImageURL: user.profileImageURL
            )
        }
    }
}
