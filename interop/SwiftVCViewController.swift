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

        if let iconView = self.iconView {
            
            iconView.frame = iconViewFrame()
            self.view.addSubview(iconView)
        }
    }
    
    private func iconViewFrame() -> CGRect {
        return CGRect(origin: CGPointZero, size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height/4.0))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let myIcon = iconView?.icon else { return }
        
        if let oldStyleViewController = segue.destinationViewController as? OldStyleViewController {
            if segue.identifier == "showLegacyVC" {
                // an example of passing a Swift enum to Objective-C via a shim (OldStylrViewController.swift)
                oldStyleViewController.showIconViewWithIcon(myIcon)
            }
        }
    }
}
