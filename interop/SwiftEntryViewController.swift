//
//  SwiftEntryViewController.swift
//  interop
//
//  Created by Daniel Wallace on 19/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit

class SwiftEntryViewController: UIViewController {
    
    @IBOutlet weak var structContainerView: UIView!
    
    @IBOutlet weak var leftEnumContainerView: UIView!
    
    @IBOutlet weak var rightEnumContainerView: UIView!
    
    // Enum
    let leftIcon = Icon.Color(UIColor(red: 100.0/255.0, green: 20/255.0, blue: 10/255.0, alpha: 1.0))
    
    
    // Enum
    var rightIcon: Icon? {
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
        
        addLeftEnum()
        addRightEnum()

        title = "Swifty Swift"
        
//        Experimental
//        addTuple((http404Error))
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        // Show Swift In ObjC
        
        if let objectiveCWithSwiftDataStructuresViewController = segue.destinationViewController as? ObjectiveCWithSwiftDataStructuresViewController {
            if segue.identifier == "Show Swift In ObjC" {
                
                objectiveCWithSwiftDataStructuresViewController.user = user
                objectiveCWithSwiftDataStructuresViewController.icon1 = leftIcon
                if let rightIcon = rightIcon {
                    objectiveCWithSwiftDataStructuresViewController.icon2 = rightIcon
                }
                
                objectiveCWithSwiftDataStructuresViewController.showProfileForUserWithName(
                    user.name,
                    profileImageURL: user.profileImageURL)

                if let rightIcon = rightIcon {
                    objectiveCWithSwiftDataStructuresViewController.showIconViewWithIcon(rightIcon)
                }
                
                objectiveCWithSwiftDataStructuresViewController.showIconViewWithIcon(leftIcon)
            }
        }
    }

    
    // MARK: - Layout
    private func addLeftEnum(){

        let iconView = IconView(icon: leftIcon)
        layout(iconView: iconView, container: leftEnumContainerView)
    }
    
    private func addRightEnum(){
        
        if let rightIcon = rightIcon {
            let iconView = IconView(icon: rightIcon)
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












