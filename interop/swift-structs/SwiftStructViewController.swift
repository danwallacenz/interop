//
//  SwiftStructViewController.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit

class SwiftStructViewController: UIViewController {

    var profileView:ProfileView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Swift Struct set from Objective-C"
        
        view.backgroundColor = UIColor.redColor()
        
//        testing
//        let user = User(name: "Dan", profileImageURL: NSURL(string:"www.google.com")!)
//        self.profileView = ProfileView(user: user)
        
        if let profileView = self.profileView {
            
            let views:[String: AnyObject] = ["topLayoutGuide": topLayoutGuide,"bottomLayoutGuide": bottomLayoutGuide, "view": view, "profileView": profileView]
            self.view.addSubview(profileView)
            
            var allConstraints = [NSLayoutConstraint]()
            
            let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[topLayoutGuide]-[profileView]",
                options: [],
                metrics: nil,
                views: views)
            allConstraints += verticalConstraints
        
            let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-[profileView]-|",
                options: [],
                metrics: nil,
                views: views)
            allConstraints += horizontalConstraints
            
            NSLayoutConstraint.activateConstraints(allConstraints)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let legacyStructViewController = segue.destinationViewController as? ObjCStructViewController {
            if segue.identifier == "showLegacyVCWithStuct" {
                legacyStructViewController.showProfileForUserWithName(
                                                profileView?.user?.name,
                                                profileImageURL: profileView?.user?.profileImageURL)
            }
        }
    }
}
