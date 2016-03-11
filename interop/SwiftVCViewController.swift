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
            
            iconView.frame = iconViewFrame()
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
                iconView.frame = iconViewFrame()
                self.view.addSubview(iconView)
            }
        }
    }
    
    private func iconViewFrame() -> CGRect {
        return CGRect(origin: CGPointZero, size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height/4.0))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let myIcon = myIcon else { return }
        
        print("\(segue.destinationViewController.dynamicType)")
        
        if let oldStyleViewController = segue.destinationViewController as? OldStyleViewController {
            if segue.identifier == "showLegacyVC" {
                
                oldStyleViewController.showIconViewWithIcon(myIcon)
            }
        }
        
//        if segue.destinationViewController.isKindOfClass(LegacyViewController){
//            let legacyViewController = segue.destinationViewController as! LegacyViewController
//
//            if segue.identifier == "showLegacyVC" {
//                
//            }
//        }
    }
}
