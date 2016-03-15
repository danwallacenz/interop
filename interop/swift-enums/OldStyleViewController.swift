//
//  LegacyViewController.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//


extension OldStyleViewController {
    
    // Can store the Icon enum and pass it on to something else. Not usable in Obj-C code though.
    var icon: Icon {
        get {
            return (_icon as! Box<Icon>).value
        }
        set{
            _icon = Box(newValue)
        }
    }
    
    @objc func addIconView() {
        
        let iconView = IconView(icon: icon)
        self.view.addSubview(iconView)
        
        let views:[String: AnyObject] = ["topLayoutGuide": topLayoutGuide,"bottomLayoutGuide": bottomLayoutGuide, "view": view, "iconView": iconView]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[iconView]-(50)-|",
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
    
    /**
     a shim to allow setting an Objective-C property from a Swift enum (Icon.Color)
     */
    @objc var iconColor: UIColor? {
        get {
            switch icon {
            case let .Color(color) : return color
            case .Image : return nil
            }
        }
        set {
            guard newValue != nil else { return }
            icon = .Color(newValue!)
        }
    }
    
    /**
     a shim to allow setting an Objective-C property from a Swift enum (Icon.Image)
     */
    @objc var iconImage: UIImage? {
        get {
            switch icon {
            case let .Image(image) : return image
            case .Color : return nil
            }
        }
        set {
            guard newValue != nil else { return }
            icon = .Image(newValue!)
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


