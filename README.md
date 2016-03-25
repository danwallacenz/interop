# SWIFTY SWIFT in OBJECTIVE-C #

***Often, Swift and Objective code must coexist. Some Swift types are not compatible with Objective-C.
However, we shouldn't avoid using them as they provide convenience and safety. This shows some ways to help out.***

### What is this repository for? ###

* To demonstrate working examples of using Swift-only types such as Swift enumerations and structures with Objective-C.

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



###Passing a Swift-only type in an Objective-C compatible class written in Swift###
For example, passing a UIView subclass written in Swift containing a Swift-only type to an Objective-C UIViewController. You'll have to do the layout yourself, but it's the simplest technique to understand.



###Sending a Swift-only type to Objective-C by employing a shim defined in a Swift extension of an Objective-C class 

For example using:


	struct SwiftStruct {
    	let compatibleValueOne: CompatibleTypeOne
    	let compatibleValueTwo: CompatibleTypeTwo
	}

*In the Swift extension:*
    
	extension ObjectiveCClass
    ...
    func setSwiftStructWith(swiftStruct: SwiftStruct) {
		self.setSwiftStructWithValueOne(swiftStruct.compatibleValueOne,
			 valueTwo:swiftStruct.compatibleValueTwo )
    }
        
*In ObjectiveCClass.h:*

	-(void) setSwiftStructWithValueOne:(CompatibleTypeOne *)compatibleValueOne valueTwo:(CompatibleTypeTwo *)compatibleValueOne;
		// Possibly create a read-only object in the implementation.


*And calling it from a Swift class*

	let myStruct = SwiftStruct(compatibleValueOne: value1, compatibleValueTwo: value2)
	
	let objectiveCClassInstance = ObjectiveCClass()
	
	objectiveCClassInstance.setSwiftStructWith(myStruct)


	
### Creating a Swift object & setting its Swift-only type from Objective-C ###
You can use this technique in setters as well. 


    class SwiftClass {
        
        private let swiftStruct: SwiftStruct
        		
        init(swiftStruct: SwiftStruct) {
        	self.swiftStruct = swiftStruct
    	}
    }
    	
    // preferably in an extension		
    extension SwiftClass {
    
    	@objc convenience init( compatibleValueOne :CompatibleTypeOne, compatibleValueTwo: CompatibleTypeTwo ){
        		
        	let swiftStruct = SwiftStruct(compatibleValueOne: value1, compatibleValueTwo: value2)
        	self.init(swiftStruct)
    	}
    }

		
		
*and calling it from Objective-C by:*
	
	[[SwiftClass alloc] initWithCompatibleTypeOne: compatibleValueOne CompatibleTypeTwo: compatibleValueTwo];  
  

###Passing a Swift-only type between the two languages using the Box Pattern 
You can't use these from within an Objective-C class, but you can pass it to on the a Swift class.

	class Box<T> {
        let value: T    
        init(_ value: T){ self.value = value }
    }

*In ObjectiveCClass.h: (typing by comment :)*
	
		@property (readwrite, strong) id /* Box<SwiftOnlyType> */ _swiftOnlyType;


*In a Swift extension create a computed property:*

		extension ObjectiveCClass
        ...
        var swiftOnlyType: SwiftOnlyType {
        	get {
            	return (_swiftOnlyType as! Box<SwiftOnlyType>).value
        	}
        	set{
            	_swiftOnlyType = Box(newValue)
        	}
    	}

*From a Swift client, set the Boxed property on the receiver like this:*
		
		let objectiveCClass:ObjectiveCClass = ...
		let mySwiftOnlyType:SwiftOnlyType = ...
		...
		objectiveClass.swiftOnlyType = mySwiftOnlyType
		
	
*Send it on to a Swift class which looks like:*
	
		class SwiftBoxedTypesAcceptingClass { 
		...
		private var mySwiftOnlyType: SwiftOnlyType?
		...
		
	    func setSwiftOnlyType(swiftOnlyType: AnyObject?) {
        	if let swiftOnlyType = swiftOnlyType as? Box<SwiftOnlyType> {
            	mySwiftOnlyType = swiftOnlyType.value
        	}
    	}
	
*from Objective-C by:*
	
		@property (readwrite, strong) SwiftBoxedTypesAcceptingClass *swiftBoxedTypesAcceptingClass;
		...
		[swiftBoxedTypesAcceptingClass setSwiftOnlyType:self._swiftOnlyType];
		
Convoluted I know.


### Who do I talk to? ###

* Andy Matuschak haha <https://andymatuschak.org>