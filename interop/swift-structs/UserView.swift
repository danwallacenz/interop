//
//  UserView.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

struct User {
    let name: String
    let profileImageURL: NSURL
}

class ProfileView: UIView {
    
    private(set) var user:User?
    
    init(user: User) {
        self.user = user
        super.init(frame: CGRectZero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.6)
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = self.user?.name
        self.addSubview(nameLabel)
        
        let profileImageURLLabel = UILabel()
        profileImageURLLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageURLLabel.text = user.profileImageURL.path
        self.addSubview(profileImageURLLabel)
        
        // layout
        var allConstraints = [NSLayoutConstraint]()
        let views = ["nameLabel": nameLabel, "profileImageURLLabel": profileImageURLLabel]
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[nameLabel]-[profileImageURLLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraints
        
        let nameLabelHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[nameLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += nameLabelHorizontalConstraints
        
        let profileImageURLLabelHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[profileImageURLLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += profileImageURLLabelHorizontalConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

/**
 shim for initializing a Swift struct from Obj-C
 */
extension ProfileView {
    
    @objc convenience init(name:String, profileImageURL:String ){
        let user = User(name: name, profileImageURL: NSURL(string: profileImageURL)!)
        self.init(user: user)
    }
}
