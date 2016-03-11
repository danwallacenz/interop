//
//  SwiftStructViewController.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import UIKit

class SwiftStructViewController: UIViewController {

    var profileView:ProfileView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // testing
//        let user = User(name: "Dan", profileImageURL: NSURL(string:"www.google.com")!)
//        self.profileView = ProfileView(user: user)
        
        if let profileView = self.profileView {
            profileView.frame = view.frame
            self.view.addSubview(profileView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
