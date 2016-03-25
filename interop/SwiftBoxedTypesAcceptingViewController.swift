//
//  SwiftBoxedTypesAcceptingViewController.swift
//  interop
//
//  Created by Daniel Wallace on 25/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit

class SwiftBoxedTypesAcceptingViewController: UIViewController {

    let CONTAINER_BORDER_WIDTH:CGFloat = 1.0
    let CONTAINER_BORDER_COLOR = UIColor.lightGrayColor().colorWithAlphaComponent(0.4).CGColor
    
    @IBOutlet weak var profileContainer: UIView!
    
    @IBOutlet weak var profileView: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProfileViewUserIfPossible()
        
        profileContainer.layer.borderColor = CONTAINER_BORDER_COLOR
        profileContainer.layer.borderWidth = CONTAINER_BORDER_WIDTH
        
        title = "Boxed Swift Types via Objective C"
    }
    
    private var user:User? {
        didSet {
            print("User = \(user)")
            print("Pause")
            setProfileViewUserIfPossible()
        }
    }
    
    func setUser(user: AnyObject?){
        if let user = user as? Box<User> {
            self.user = user.value
        }
    }
    
    private func setProfileViewUserIfPossible() {
        if profileView != nil && user != nil {
            profileView.setUser(user!)
        }
    }
}
