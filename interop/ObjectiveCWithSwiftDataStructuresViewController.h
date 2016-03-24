//
//  ObjectiveCWithSwiftDataStructuresViewController.h
//  interop
//
//  Created by Daniel Wallace on 24/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import <UIKit/UIKit.h>
//To avoid cyclical references, don’t import Swift code into an Objective-C header (.h) file. Instead, you can forward declare a Swift class or protocol to reference it in an Objective-C interface.
@class ProfileView;
@class IconView;

@interface ObjectiveCWithSwiftDataStructuresViewController : UIViewController

-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url;

/**
 interfaces of shims to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithColor:(UIColor *)color;
-(void)showIconViewWithImage:(UIImage *)image;


/**
 Can't use this struct in Objective C - but can pass it on to Swift code.
 */
@property (readwrite, strong) id /* Box<User> */ _user;

/**
 Can't use these enums in Objective C - but can pass it on to Swift code.
 */
@property (readwrite, strong) id /* Box<Icon> */ _icon1;
@property (readwrite, strong) id /* Box<Icon> */ _icon2;


// Just pass the enum or struct wrapped in a UIView.
@property (strong,nonatomic) ProfileView *externalProfileView;

@property (strong,nonatomic) IconView *externalColorIconView;
@property (strong,nonatomic) IconView *externalImageIconView;

@end
