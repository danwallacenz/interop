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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLeftEnum()

        // Do any additional setup after loading the view.
    }

    func addLeftEnum(){
        let icon = Icon.Color(UIColor(red: 100.0/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0))
        let iconView = IconView(icon: icon)
        layout(iconView: iconView, container: leftEnumContainerView)
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
        
        let views:[String: AnyObject] = ["topLayoutGuide": topLayoutGuide,"bottomLayoutGuide": bottomLayoutGuide, "container": container, "iconView": iconView]
        
        container.addSubview(iconView)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[iconView]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraints
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[iconView]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    
}
