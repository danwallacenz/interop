//
//  ObjCStructViewController.h
//  interop
//
//  Created by Daniel Wallace on 12/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjCStructViewController : UIViewController

-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url;

@property (readwrite, strong) id /* Box<User> */ _user;

@end
