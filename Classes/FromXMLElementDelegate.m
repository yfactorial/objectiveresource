//
//  FromXMLElementDelegate.m
//  medaxion
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "FromXMLElementDelegate.h"
#import "NSObject+XMLSerializableSupport.h"
#import "NSDate+XMLSerializableSupport.h"
#import "CoreSupport.h"

@implementation FromXMLElementDelegate

@synthesize targetClass, parsedObject, currentPropertyName, contentOfCurrentProperty, unclosedProperties, currentPropertyType;

+ (FromXMLElementDelegate *)delegateForClass:(Class)targetClass {
	FromXMLElementDelegate *delegate = [[[self alloc] init] autorelease];
	[delegate setTargetClass:targetClass];
	return delegate;
}


- (id)init {
	super;
	self.unclosedProperties = [NSMutableArray array];
	return self;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	//start of a collection of objects,
	if ([elementName isEqualToString:[[self.targetClass xmlElementName] stringByAppendingString:@"s"]]) {
		self.parsedObject = [NSMutableArray array];
		[self.unclosedProperties addObject:self.parsedObject];
		self.currentPropertyName = [elementName camelize];
	}
	
	// We're at the beginning of an object definition, so create an instance as the current
	// parent object
    else if ([elementName isEqualToString:[self.targetClass xmlElementName]]) {
        self.parsedObject = [[[self.targetClass alloc] init] autorelease];
		[self.unclosedProperties addObject:self.parsedObject];
		self.currentPropertyName = [elementName camelize];
    }
	
	else {
		//if we are inside another element and it is not the current parent object, 
		// then create an object for that parent element
		if(self.currentPropertyName != nil && (![self.currentPropertyName isEqualToString:[[self.parsedObject class] xmlElementName]])) {
			Class elementClass = NSClassFromString([self.currentPropertyName stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
													withString:[[self.currentPropertyName substringWithRange:NSMakeRange(0,1)] uppercaseString]]);
			if (elementClass != nil) {
				//classname matches, instantiate a new instance of the class and set it as the current parent object
				self.parsedObject = [[[elementClass alloc] init] autorelease];
				[self.unclosedProperties addObject:self.parsedObject];
			}
		}
		
		// If we recognize an element that corresponds to a known property of the current parent object, or if the
		// current parent is an array then start collecting content for this child element
		if (([self.parsedObject isKindOfClass:[NSArray class]]) ||
			([[[self.parsedObject class] propertyNames] containsObject:[elementName camelize]])) {
			self.currentPropertyName = [elementName camelize];
			self.contentOfCurrentProperty = [NSMutableString string];
			self.currentPropertyType = [attributeDict objectForKey:@"type"];
		} else {
			// The element isn't one that we care about, so set the property that holds the 
			// character content of the current element to nil. That way, in the parser:foundCharacters:
			// callback, the string that the parser reports will be ignored.
			self.currentPropertyName = nil;
			self.contentOfCurrentProperty = nil;
		}
	}
}

// Characters (i.e. an element value - retarded, I know) are given to us in chunks,
// so we need to append them onto the current property value.
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	
	// If the current property is nil, then we know we're currently at
	// an element that we don't know about or don't care about
    if (self.contentOfCurrentProperty) {
		
		// Append string value on since we're given them in chunks
        [self.contentOfCurrentProperty appendString:string];
    }
}

//Basic type conversion based on the ActiveResource "type" attribute
- (id) convertProperty:(NSString *)propertyValue toType:(NSString *)type {
	if ([type isEqualToString:@"datetime" ]) {
		return [NSDate fromXMLString:propertyValue];
	}
	else {
		return propertyValue;
	}
}

// We're done receiving the value of a particular element, so take the value we've collected and
// set it on the current object
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{    
	if(self.contentOfCurrentProperty != nil && self.currentPropertyName != nil) {
		
		[self.parsedObject setValue:
		 [self convertProperty:self.contentOfCurrentProperty toType:self.currentPropertyType]  
		 forKey:self.currentPropertyName];
	}
	else if ([self.currentPropertyName isEqualToString:[elementName camelize]]) {
		//element is closed, pop it from the stack
		[self.unclosedProperties removeLastObject];
		//check for a parent object on the stack
		if ([self.unclosedProperties count] > 0) {
			//handle arrays as a special case
			if ([[self.unclosedProperties lastObject] isKindOfClass:[NSArray class]]) {
				[[self.unclosedProperties lastObject] addObject:self.parsedObject];
			}
			else {
				[[self.unclosedProperties lastObject] setValue:self.parsedObject forKey:[elementName camelize]];
			}
			self.parsedObject = [self.unclosedProperties lastObject];
		}
	}
	
	self.contentOfCurrentProperty = nil;
	
	//set the parent object, if one exists, as teh current element
	if ([self.unclosedProperties count] > 0) {
		if ([[self.unclosedProperties lastObject] isKindOfClass:[NSArray class]]) {
			self.currentPropertyName = [[self.targetClass xmlElementName] stringByAppendingString:@"s"];
		}
		else {
			self.currentPropertyName = [[self.parsedObject class] xmlElementName];
		}
	}
}


#pragma mark cleanup 

- (void)dealloc {
	[targetClass release];
	[parsedObject release];
	[currentPropertyName release];
	[contentOfCurrentProperty release];
	[unclosedProperties release];
	[super dealloc];
}

@end
