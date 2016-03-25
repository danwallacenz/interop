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
    @IBOutlet weak var colorIconContainer: UIView!
    @IBOutlet weak var imageIconContainer: UIView!
    
    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var colorIconView: IconView!
    @IBOutlet weak var imageIconView: IconView!
    
    private var user:User? {
        didSet {
            setProfileViewUserIfPossible()
        }
    }
    
    private var colorIcon:Icon? {
        didSet {
            setColorIconViewUserIfPossible()
            print("colorIcon=\(colorIcon)")
            print("Pause")
        }
    }
    
    private var imageIcon:Icon? {
        didSet {
            setImageIconViewUserIfPossible()
            print("colorIcon=\(imageIcon)")
            print("Pause")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProfileViewUserIfPossible()
        setColorIconViewUserIfPossible()
        setImageIconViewUserIfPossible()
        
        profileContainer.layer.borderColor = CONTAINER_BORDER_COLOR
        profileContainer.layer.borderWidth = CONTAINER_BORDER_WIDTH
        colorIconContainer.layer.borderColor = CONTAINER_BORDER_COLOR
        colorIconContainer.layer.borderWidth = CONTAINER_BORDER_WIDTH
        imageIconContainer.layer.borderColor = CONTAINER_BORDER_COLOR
        imageIconContainer.layer.borderWidth = CONTAINER_BORDER_WIDTH
        
        title = "Boxed Swift Types via Objective C"
    }
    
    func setUser(user: AnyObject?){
        if let user = user as? Box<User> {
            self.user = user.value
        }
    }
    
    func setColorIcon(icon: AnyObject?){
        if let icon = icon as? Box<Icon> {
            self.colorIcon = icon.value
        }
    }
    
    func setImageIcon(icon: AnyObject?){
        if let icon = icon as? Box<Icon> {
            self.imageIcon = icon.value
        }
    }
    
    private func setProfileViewUserIfPossible() {
        if profileView != nil && user != nil {
            profileView.setUser(user!)
        }
    }
    
    private func setColorIconViewUserIfPossible() {
        if colorIconView != nil && colorIcon != nil {
            colorIconView.setIcon(colorIcon!)
        }
    }
    
    private func setImageIconViewUserIfPossible() {
        if imageIconView != nil && imageIcon != nil {
            imageIconView.setIcon(imageIcon!)
        }
    }
}
