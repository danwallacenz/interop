//
//  MyEnum.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import Foundation
import UIKit

enum Icon {
    case Color(UIColor)
    case Image(UIImage)
}

class IconView: UIView {
    
    private(set) var icon:Icon?
    
    init(icon:Icon) {
        self.icon = icon
        super.init(frame: CGRectZero)
        
        switch icon {
        case let .Color(color):
            let colorView = UIView()
            colorView.backgroundColor = color
            layout(colorView)
        case let .Image(image):
            let imageView = UIImageView(image: image)
            imageView.contentMode = .ScaleAspectFill
            layout(imageView)
        }
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGrayColor().CGColor
        backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setIcon(icon: Icon){
        self.icon = icon
        
        switch icon {
        case let .Color(color):
            let colorView = UIView()
            colorView.backgroundColor = color
            layout(colorView)
        case let .Image(image):
            let imageView = UIImageView(image: image)
            imageView.contentMode = .ScaleAspectFill
            layout(imageView)
        }
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    private func layout(view: UIView){
        
        addSubview(view)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        let views = ["view": view, "self":self]
        
        var verticalConstraintString:String?
        var horizontalConstraintString:String?
        
        switch icon! {
        case .Color:
            verticalConstraintString = "V:|-[view(30)]-|"
            horizontalConstraintString = "H:|-[view(30)]-|"
        case .Image:
            verticalConstraintString = "V:|-[view]-|"
            horizontalConstraintString = "H:|-[view]-|"
        }
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            verticalConstraintString!,
            options: [],
            metrics: nil,
            views: views)

        allConstraints += verticalConstraints
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            horizontalConstraintString!,
            options: [],
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}

/**
 shims for initializing a Swift enum from Obj-C
*/
extension IconView {
    
    @objc convenience init(color: UIColor){
        let icon = Icon.Color(color)
        self.init(icon: icon)
    }
    
    @objc convenience init(image: UIImage){
        let icon = Icon.Image(image)
        self.init(icon: icon)
    }
}
