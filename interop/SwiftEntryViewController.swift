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
    
    @IBOutlet weak var bottomView: UIView!
    
    let leftIcon = Icon.Color(UIColor(red: 100.0/255.0, green: 20/255.0, blue: 10/255.0, alpha: 1.0))
    
    var rightIcon: Icon? {
    get {
        if let image = UIImage(named: "ic_motorcycle") {
            return Icon.Image(image)
        }
        return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProfile()
        
        addLeftEnum()
        addRightEnum()

        addTuple()
    }

    func addLeftEnum(){

        let iconView = IconView(icon: leftIcon)
        layout(iconView: iconView, container: leftEnumContainerView)
    }
    
    func addRightEnum(){
        
        if let rightIcon = rightIcon {
            let iconView = IconView(icon: rightIcon)
            layout(iconView: iconView, container: rightEnumContainerView)
        } else {
            print("image not found")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        
        let url = NSURLComponents(string:"https://github.com/danwallacenz")?.URL
        
        let user = User(name: "Daniel Wallace", profileImageURL: url!)
//        let user = User(name: "Daniel Wallace", profileImageURL:
//        NSURL(scheme: "https", host: "github.com", path: "danwallacenz")!)
        
        
        let profileView = ProfileView(user: user)
        structContainerView.addSubview(profileView)
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        structContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        let views = ["profileView" : profileView, "structContainerView" : structContainerView]
        
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[profileView]-|", options:[] , metrics: nil, views: views)
        allConstraints += vConstraints
        
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[profileView]-|", options:[] , metrics: nil, views: views)
        allConstraints += hConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
        
    }
    
    private func addTuple(){
        
        let tupleView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        tupleView.backgroundColor = UIColor.purpleColor()
        tupleView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(tupleView)
        
        var allConstraints = [NSLayoutConstraint]()
        let views = ["tupleView" : tupleView, "bottomView" : bottomView]
        
        // size
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[tupleView(40)]", options:[] , metrics: nil, views: views)
        allConstraints += vConstraints
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[tupleView(40)]", options:[] , metrics: nil, views: views)
        allConstraints += hConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
        
        // center
        let xConstraint = NSLayoutConstraint(item: tupleView, attribute: .CenterX, relatedBy: .Equal, toItem: bottomView, attribute: .CenterX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: tupleView, attribute: .CenterY, relatedBy: .Equal, toItem: bottomView, attribute: .CenterY, multiplier: 1, constant: 0)
        
        bottomView.addConstraint(xConstraint)
        bottomView.addConstraint(yConstraint)
    }
}












