//
//  LegacyViewController.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

extension OldStyleViewController {
    
    func showIconViewWithIcon(icon: Icon) {
        switch icon {
        case let .Image(image):
            self.showIconViewWithImage(image)
        case let .Color(color):
            self.showIconViewWithColor(color)
        }
    }
}


