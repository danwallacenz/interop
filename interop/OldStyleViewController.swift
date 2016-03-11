//
//  LegacyViewController.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//


extension OldStyleViewController {
    
    // Can store the Icon enum and pass it on to something else
    var icon: Icon {
        get {
            return (_icon as! Box<Icon>).value
        }
        set{
            _icon = Box(newValue)
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
}


