//
//  ObjectiveCWithSwiftDataStructuresViewController.h
//  interop
//
//  Created by Daniel Wallace on 24/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectiveCWithSwiftDataStructuresViewController : UIViewController

-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url;


/**
 Can't use this struct in Objective C - but can pass it on to Swift code.
 */
@property (readwrite, strong) id /* Box<User> */ _user;

/**
 Can't use these enums in Objective C - but can pass it on to Swift code.
 */
@property (readwrite, strong) id /* Box<Icon> */ _icon1;
@property (readwrite, strong) id /* Box<Icon> */ _icon2;

@end
