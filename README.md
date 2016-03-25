# SWIFTY SWIFT in OBJECTIVE-C #


### What is this repository for? ###

* To demonstrate working examples of using Swift-only types such as Swift enummerations and structures with Objective-C.

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
 
This app has examples of working with **Swift enumerations and stuctures** in Objective-C. While these are not directly compatible, there are techniques to overcome this to varying degrees. It demonstrates ***three mechanisms***. They are:



1. ***Passing a Swift-only type in an Objective-C compatible class written in Swift***, For example, passing a UIView subclass written in Swift containing a Swift-only type to an Objective-C UIViewController. You'll have to do the layout yourself, but it's the simplest technique to understand.



2.  ***Using a shim defined in a Swift extension of an Objective-C class***. 

	For example:

	In the Swift extension:
    
        extension ObjectiveCClass
        ...
        func setSwiftStructWith(swiftStruct: Struct) {
            self.setSwiftStructWithValueOne( swiftStruct.compatibleValueOne, valueTwo: swiftStruct.compatibleValueTwo )
        }

	In ObjectiveCClass.h:

        -(void) setSwiftStructWithValueOne: (CompatibleTypeOne *) compatibleValueOne 
                                  valueTwo: (CompatibleTypeTwo *) compatibleValueOne;
    
	In ObjectiveCClass.m:

	    -(void)setSwiftStructWithValueOne: (CompatibleTypeOne *) compatibleValueOne
	                             valueTwo: (CompatibleTypeTwo *) compatibleValueTwo {
    
    	    self.valueOne = compatibleValueOne;
    	    self.valueTwo = compatibleValueTwo;
	    }



3. ***Wrapping a Swift-only type using the Box Pattern***. You can't use it from within an Objective-C class, but you can pass it to on the a Swift class.

       class Box<T> {
           let value: T    
           init(_ value: T){ self.value = value }
       }

	In ObjectiveCClass.h: (typing by comment :)
	
		@property (readwrite, strong) id /* Box<SwiftOnlyType> */ _swiftOnlyType;


	In a Swift extension create a computed property:

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

	From a Swift client, set the Boxed property on the receiver like this:
		
		let objectiveCClass:ObjectiveCClass = ...
		let mySwiftOnlyType:SwiftOnlyType = ...
		...
		objectiveClass.swiftOnlyType = mySwiftOnlyType
		
	
	Send it on to a Swift class which looks like:
	
		class SwiftBoxedTypesAcceptingClass { 
		...
		private var mySwiftOnlyType: SwiftOnlyType?
		...
		
	    func setSwiftOnlyType(swiftOnlyType: AnyObject?) {
        	if let swiftOnlyType = swiftOnlyType as? Box<SwiftOnlyType> {
            	mySwiftOnlyType = swiftOnlyType.value
        	}
    	}
	
	from Objective-C by:
	
		@property (readwrite, strong) SwiftBoxedTypesAcceptingClass *swiftBoxedTypesAcceptingClass;
		...
		[swiftBoxedTypesAcceptingClass setSwiftOnlyType:self._swiftOnlyType];
		
	Convoluted I know.


### Who do I talk to? ###

* Andy Matuschak haha <https://andymatuschak.org>