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
        
        if let myUser = self.user {
            layoutWithUser(myUser)
        }
        
        backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setUser(user: User){
        self.user = user
        
        if let myUser = self.user {
            layoutWithUser(myUser)
        }
    }
    
    private func layoutWithUser(user: User){
        
        nameLabel.text = user.name
        self.addSubview(nameLabel)
        
        profileImageURLLabel.text = user.profileImageURL.absoluteString
        self.addSubview(profileImageURLLabel)
        
        layout();
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGrayColor().CGColor
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
    
    @objc convenience init(name:String, profileImageURL:NSURL ){
        let user = User(name: name, profileImageURL: profileImageURL)
        self.init(user: user)
    }
    
    //MARK: - Deprecated
    @objc convenience init(name:String, profileImageURLString:String ){
        let user = User(name: name, profileImageURL: NSURL(string: profileImageURLString)!)
        self.init(user: user)
    }
}
