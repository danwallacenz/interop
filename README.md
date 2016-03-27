# SWIFTY SWIFT in OBJECTIVE-C #

***Often, Swift and Objective code must coexist. Some Swift types are not compatible with Objective-C.
However, we shouldn't avoid using them as they provide convenience and safety. This shows some ways to help out.***

### What is this repository for? ###

* To demonstrate working examples of using Swift-only types such as Swift enumerations and structures with Objective-C - and how to mitigate the impedences that exist.

* Based in large part on a 2015 lecture given by Andy Matuschak <https://www.youtube.com/watch?v=q_Y070VAP0c>


### What does it do? ###

Objective-C excludes some Swift types, such as those listed here:

* Generics
* Tuples
* Enumerations defined in Swift without Int raw value type
* Structures defined in Swift
* Top-level functions defined in Swift
* Global variables defined in Swift
* Typealiases defined in Swift
* Swift-style variadics
* Nested types
* Curried functions
 
This app has examples of working with **Swift enumerations and stuctures** in Objective-C. While these are not directly compatible, there are techniques to alleviate this to varying degrees. It demonstrates ***four mechanisms***. They are:



###Passing a Swift-only type in an Objective-C compatible Swift class###
For example, passing a UIView subclass written in Swift containing a Swift-only type to an Objective-C UIViewController. You'll have to do the layout yourself, but it's the simplest technique to understand.



###Creating a Swift-only type within an Objective-C class from anywhere via                                                                 a shim defined in a Swift extension of an Objective-C class 

*For example, using a Swift-only type*


	struct User {
    	let name: String
    	let profileImageURL: NSURL
	}


*and an Objective-C compatible container*

	class ProfileView: UIView {
    	var user:User?
    	
    	init(user: User) {
        	self.user = user
        }
    }
    	

*Create a shim in a Swift extension*
    
	extension ObjectiveCClass

    	func showProfileViewWithUser(user: User) {
        	self.showProfileForUserWithName(user.name, profileImageURL: user.profileImageURL)
    	}
        
*In ObjectiveCClass.h:*

	-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url;


*And calling it from a Swift class*

    let url = NSURLComponents(string:"https://github.com/danwallacenz")?.URL
    let user = User(name: "Daniel Wallace", profileImageURL: url!)
	
	objectiveCClass.showProfileViewWithUser(user)
	
*or from an Objective-C class*

	[objectiveCClass showProfileViewWithName:aName profileImageURL: aURL];


	
### Creating a Swift object & setting its Swift-only type from Objective-C ###
You can use this technique in setters as well. 

    	
    // preferably in an extension		
	extension ProfileView {
    
    	@objc convenience init(name:String, profileImageURL:NSURL ){
        	
        	let user = User(name: name, profileImageURL: profileImageURL)
        	self.init(user: user)
    	}

		
		
*and calling it from Objective-C by:*
	
	self.profileView = [[ProfileView alloc] initWithName: aName profileImageURL: aURL];  
  

###Passing a Swift-only type between the two languages using the Box Pattern      
You can't use these from within an Objective-C class, but you can pass it to on the a Swift class.

	class Box<T> {
        let value: T    
        init(_ value: T){ self.value = value }
    }

*In ObjectiveCClass.h: (typing by comment :)*
	
		// Strong typing using comments
		@property (readwrite, strong) id /* Box<User> */ _user;


*In a Swift extension create a computed property:*


	extension ObjectiveCClass {
		
		// Can store the User struct and pass it on to something else. Not usable in Obj-C code though.
    	var user: User {
        	get {
            	return (_user as! Box<User>).value
       		}
        	set{
           		 _user = Box(newValue)
        	}
    	}
    }

*From a Swift client, set the Boxed property on the receiver like this:*
		
	let user = User(name: "Addy Osmani", profileImageURL: aURL)
     objectiveCClass.user = user
		
	
*Send it on to a Swift class which looks like:*
	
	class MySwiftClass { 
		...
		private var user:User?
		...
		
    func setUser(user: AnyObject?){
        if let user = user as? Box<User> {
            self.user = user.value
        }
    }
	
*from Objective-C:*

	[mySwiftClass setUser:self._user];
	
Inspecting the Boxed User class in Objective-C	you'll see:
	`self._user = interop.Box<interop.User>`

*Using this, you can expose the values of the struct as Objective-C properties:*

TODO: Implement this
	
	extension ObjectiveCClass {
		
		@objc var userName: String {
			get { user.name }
			set {
				user = User(
					name: newValue,
					profileImageURL: user.profileImageURL
				)
			}
		}
		  
	
		
Convoluted I know. Still...we want to use these powerful and safe Swift-only types.

 There are examples of using Swift enums as well as Swift structs in the source.


### Who do I talk to? ###

* <https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/>
* <https://itunes.apple.com/us/book-series/swift-programming-series/id888896989?mt=11>
* <https://developer.apple.com/videos/play/wwdc2015/401/>
* Andy Matuschak haha <https://andymatuschak.org>