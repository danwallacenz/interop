//
//  SwiftBoxedUserViewController.swift
//  interop
//
//  Created by Daniel Wallace on 14/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit

class SwiftBoxedUserViewController: UIViewController {
    
    private var profileView:ProfileView?
    
    private var user:User? {
        didSet {
            print("User = \(user)")
            print("Pause")
        }
    }
    
    func setUser(user: AnyObject?){
        if let user = user as? Box<User> {
            self.user = user.value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = user else { return }
        profileView = ProfileView(user:user)
        
        
        // layout only below
        let views:[String: AnyObject] = ["topLayoutGuide": topLayoutGuide,"bottomLayoutGuide": bottomLayoutGuide, "view": view, "profileView": profileView!]
        self.view.addSubview(profileView!)
        
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
