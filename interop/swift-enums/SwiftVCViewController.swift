//
//  SwiftVCViewController.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit


/**
    An example of passing a Swift enum to Objective-C via a shim (OldStyleViewController.swift)
*/
class SwiftVCViewController: UIViewController {

    var iconView:IconView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.redColor()
        
        if let iconView = self.iconView {
            layout(iconView: iconView)
//            iconView.frame = iconViewFrame()
//            self.view.addSubview(iconView)
        }
        
        title = "A Swift View Controller"
    }
    
    private func layout(iconView iconView: IconView) {
        
        let views:[String: AnyObject] = ["topLayoutGuide": topLayoutGuide,"bottomLayoutGuide": bottomLayoutGuide, "view": view, "iconView": iconView]
        self.view.addSubview(iconView)
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[topLayoutGuide]-[iconView]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraints
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[iconView]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
//    private func iconViewFrame() -> CGRect {
//        return CGRect(origin: CGPointZero, size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height/4.0))
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let myIcon = iconView?.icon else {
            print("iconView?.icon is nil")
            return
        }
        
        if let oldStyleViewController = segue.destinationViewController as? OldStyleViewController {
            if segue.identifier == "showLegacyVC" {
                
                // pass an Icon enum to Objective-C property
                passIconEnumToObjCclassAndBack(oldStyleViewController)
                
                // set instance variable on Objective-C class
                setEnumValueInObjCClass(oldStyleViewController)
                
                // an example of passing a Swift enum to Objective-C via a shim (OldStylrViewController.swift)
                oldStyleViewController.showIconViewWithIcon(myIcon)
            }
        }
    }
    
    private func setEnumValueInObjCClass(oldStyleViewController: OldStyleViewController) {
        
        guard let myIcon = iconView?.icon else {
            print("iconView?.icon is nil")
            return
        }
        
        switch myIcon {
        case let .Color(color):
            oldStyleViewController.iconColor = color
        case let .Image(image):
            oldStyleViewController.iconImage = image
        }
    }
    
    /**
        pass a Swift enum to a Objective-C property and get it back
    */
    private func passIconEnumToObjCclassAndBack(oldStyleViewController: OldStyleViewController){

        guard let myIcon = iconView?.icon else {
            print("iconView?.icon is nil")
            return
        }
        
        oldStyleViewController.icon = myIcon
        print("in Swift, oldStyleViewController.icon. dynamicType = \(oldStyleViewController.icon.dynamicType)")
        switch oldStyleViewController.icon {
        case let .Color(color):
            print("Icon is a color \(color)")
        case let .Image(image):
            print("Icon is an image \(image)")
        }
    }
}
