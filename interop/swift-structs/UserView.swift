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
    
    private let nameLabel = UILabel();
    private let profileImageURLLabel = UILabel();
    
    init(user: User) {
        
        self.user = user
        super.init(frame: CGRectZero)

        self.backgroundColor = UIColor.yellowColor()
        
        nameLabel.text = self.user?.name
        self.addSubview(nameLabel)
        
        profileImageURLLabel.text = user.profileImageURL.path
        self.addSubview(profileImageURLLabel)
        
        layout();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func layout(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageURLLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        let views = ["nameLabel": nameLabel, "profileImageURLLabel": profileImageURLLabel]
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[nameLabel]-[profileImageURLLabel]-|",
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
