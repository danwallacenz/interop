//
//  SwiftVCViewController.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit

class SwiftVCViewController: UIViewController {

    var showImage:Bool = false
    private var myIcon:Icon?
    var iconView:IconView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let iconView = self.iconView {
            
            iconView.frame = self.view.frame
            self.view.addSubview(iconView)
            
        } else {
        
            if showImage {
                if let image = UIImage(named: "iconImage") {
                    myIcon = Icon.Image(image)
                } else {
                    myIcon = Icon.Color(UIColor.redColor())
                }
            } else {
                 myIcon = Icon.Color(UIColor.redColor())
            }
            
            if let icon = myIcon {
                let iconView = IconView(icon: icon)
                iconView.frame = self.view.frame
                self.view.addSubview(iconView)
            }
        }
    }
}
