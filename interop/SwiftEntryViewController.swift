//
//  SwiftEntryViewController.swift
//  interop
//
//  Created by Daniel Wallace on 19/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit

class SwiftEntryViewController: UIViewController {
    
    let CONTAINER_BORDER_WIDTH:CGFloat = 1.0
    let CONTAINER_BORDER_COLOR = UIColor.lightGrayColor().colorWithAlphaComponent(0.4).CGColor
    
    @IBOutlet weak var structContainerView: UIView!
    
    @IBOutlet weak var leftEnumContainerView: UIView!
    
    @IBOutlet weak var rightEnumContainerView: UIView!
    
    // Enum
    let colorIcon = Icon.Color(UIColor(red: 100.0/255.0, green: 20/255.0, blue: 10/255.0, alpha: 1.0))
    
    
    // Enum
    var imageIcon: Icon? {
        get {
            if let image = UIImage(named: "ic_motorcycle") {
                return Icon.Image(image)
            }
            return nil
        }
    }
    
    
    // Struct
    var user: User {
        get {
            let url = NSURLComponents(string:"https://github.com/danwallacenz")?.URL
            return User(name: "Daniel Wallace", profileImageURL: url!)
        }
    }
    
    
    // Tuples
    let http404Error = (statusCode: 404, description:"Not Found")
    let http200Status = (statusCode: 200, description: "OK")

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProfile()
        
        addColorEnum()
        addImageEnum()

        title = "Swifty Swift"
        
        structContainerView.layer.borderColor = CONTAINER_BORDER_COLOR
        structContainerView.layer.borderWidth = CONTAINER_BORDER_WIDTH
        leftEnumContainerView.layer.borderColor = CONTAINER_BORDER_COLOR
        leftEnumContainerView.layer.borderWidth = CONTAINER_BORDER_WIDTH
        rightEnumContainerView.layer.borderColor = CONTAINER_BORDER_COLOR
        rightEnumContainerView.layer.borderWidth = CONTAINER_BORDER_WIDTH
        
//        Experimental
//        addTuple((http404Error))
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        // Show Swift In ObjC
        
        if let objectiveCWithSwiftDataStructuresViewController = segue.destinationViewController as? ObjectiveCWithSwiftDataStructuresViewController {
            if segue.identifier == "Show Swift In ObjC" {
                
                // Send Boxed Swift-only types to receiver
                if let url = NSURLComponents(string:"https://addyosmani.com")?.URL {
                    let boxedUser = User(name: "Addy Osmani", profileImageURL: url)
                    objectiveCWithSwiftDataStructuresViewController.user = boxedUser
                }
                
                let boxedColorIcon = Icon.Color(UIColor(red: 10.0/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0))
                objectiveCWithSwiftDataStructuresViewController.icon1 = boxedColorIcon
                
                if let image = UIImage(named: "ic_music_video") {
                    objectiveCWithSwiftDataStructuresViewController.icon2 = Icon.Image(image)
                }
                
                // Call shims on receiver
                objectiveCWithSwiftDataStructuresViewController.showProfileViewWithUser(user)
                
                if let imageIcon = imageIcon {
                    objectiveCWithSwiftDataStructuresViewController.showIconViewWithIcon(imageIcon)
                }
                
                objectiveCWithSwiftDataStructuresViewController.showIconViewWithIcon(colorIcon)
                
                
                // Send 'external' views wrapping Swift-only types to receiver
                if let externalProfileView = createExternalProfileView() {
                    objectiveCWithSwiftDataStructuresViewController.externalProfileView = externalProfileView
                }
                
                objectiveCWithSwiftDataStructuresViewController.externalColorIconView = createExternalColorIconView()
                
                if let externalImageIconView = createExternalImageIconView() {
                    objectiveCWithSwiftDataStructuresViewController.externalImageIconView = externalImageIconView
                }
            }
        }
    }

    // MARK: - 'External' view creation
    
    private func createExternalProfileView() -> ProfileView? {
        guard let url = NSURLComponents(string:"https://andymatuschak.org")?.URL else { return nil }
        let user = User(name: "Andy Matuschak", profileImageURL:url)
        let externalProfileView = ProfileView(user: user)
        return externalProfileView
    }
    
    private func createExternalColorIconView() -> IconView {
        let icon = Icon.Color(UIColor(red: 40.0/255.0, green: 140/255.0, blue: 200/255.0, alpha: 1.0))
        let iconView = IconView(icon: icon)
        return iconView
    }
    
    private func createExternalImageIconView() -> IconView? {
        if let image = UIImage(named: "ic_pan_tool") {
            let icon = Icon.Image(image)
            let iconView = IconView(icon: icon)
            return iconView
        }
        return nil
    }
    
    // MARK: - Layout
    private func addColorEnum(){

        let iconView = IconView(icon: colorIcon)
        layout(iconView: iconView, container: leftEnumContainerView)
    }
    
    private func addImageEnum(){
        
        if let imageIcon = imageIcon {
            let iconView = IconView(icon: imageIcon)
            layout(iconView: iconView, container: rightEnumContainerView)
        } else {
            print("image not found")
        }
    }

    private func layout(iconView iconView: IconView, container: UIView) {
        
        container.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(iconView)

        let horizontalConstraint = NSLayoutConstraint(item: container,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: iconView,
            attribute: .CenterX,
            multiplier: 1,
            constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: container,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: iconView,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)
        view.addConstraint(verticalConstraint)
    }
    
    private func addProfile(){

        let profileView = ProfileView(user: user)
        structContainerView.addSubview(profileView)
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        structContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        let views = ["profileView" : profileView, "structContainerView" : structContainerView]
        
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[profileView]", options:[] , metrics: nil, views: views)
        allConstraints += vConstraints
        
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[profileView]-|", options:[] , metrics: nil, views: views)
        allConstraints += hConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    /**
        Experimental: Note  mandatory label for first parameter.
             call
                ```let tuple = (statusCode: 200, description: "OK")
                addTuple((tuple))```
            Note the double parentheses.
     */
    private func addTuple(statusCode statusCode: Int, description:String){
        
        print("\(statusCode):\(description)")
        
        let _ = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
    }
}












