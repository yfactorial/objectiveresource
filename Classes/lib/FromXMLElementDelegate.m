//
//  FromXMLElementDelegate.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "FromXMLElementDelegate.h"
#import "XMLSerializableSupport.h"
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

	if ([@"nil-classes" isEqualToString:elementName]) {
		//empty result set, do nothing
	}
	
	//Start of an array type
	else if ([@"array" isEqualToString:[attributeDict objectForKey:@"type"]]) {
    self.parsedObject = [NSMutableArray array];
		[self.unclosedProperties addObject:[NSArray arrayWithObjects:[elementName camelize], self.parsedObject, nil]];
		self.currentPropertyName = [elementName camelize];
	}
	
	//Start of the root object
    else if (parsedObject == nil && [elementName isEqualToString:[self.targetClass xmlElementName]]) {
        self.parsedObject = [[[self.targetClass alloc] init] autorelease];
		[self.unclosedProperties addObject:[NSArray arrayWithObjects:[elementName camelize], self.parsedObject, nil]];
		self.currentPropertyName = [elementName camelize];
    }
	
	else {
		//if we are inside another element and it is not the current parent object, 
		// then create an object for that parent element
		if(self.currentPropertyName != nil && (![self.currentPropertyName isEqualToString:[[self.parsedObject class] xmlElementName]])) {
			Class elementClass = NSClassFromString([currentPropertyName toClassName]);
			if (elementClass != nil) {
				//classname matches, instantiate a new instance of the class and set it as the current parent object
				self.parsedObject = [[[elementClass alloc] init] autorelease];
				[self.unclosedProperties addObject:[NSArray arrayWithObjects:self.currentPropertyName, self.parsedObject, nil]];
			}
		}
		
		// If we recognize an element that corresponds to a known property of the current parent object, or if the
		// current parent is an array then start collecting content for this child element
    
    
		if (([self.parsedObject isKindOfClass:[NSArray class]]) ||
        ([[[self.parsedObject class] propertyNames] containsObject:[[self convertElementName:elementName] camelize]])) {
			self.currentPropertyName = [[self convertElementName:elementName] camelize];
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

//Basic type conversion based on the ObjectiveResource "type" attribute
- (id) convertProperty:(NSString *)propertyValue toType:(NSString *)type {
	if ([type isEqualToString:@"datetime" ]) {
		return [NSDate fromXMLDateTimeString:propertyValue];
	}
	else if ([type isEqualToString:@"date"]) {
		return [NSDate fromXMLDateString:propertyValue];
	}
	else {
		return [NSString fromXmlString:propertyValue];
	}
}

// Converts the Id element to modelNameId
- (NSString *) convertElementName:(NSString *)anElementName {
 
  if([anElementName isEqualToString:@"id"]) {
   
    return [NSString stringWithFormat:@"%@_%@" , [NSStringFromClass([self.parsedObject class]) 
                                                 stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
                                                 withString:[[NSStringFromClass([self.parsedObject class]) 
                                                              substringWithRange:NSMakeRange(0,1)] 
                                                              lowercaseString]], anElementName];
  }
  else {
    
    return anElementName;
    
  }

}

// We're done receiving the value of a particular element, so take the value we've collected and
// set it on the current object
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{    
	if(self.contentOfCurrentProperty != nil && self.currentPropertyName != nil) {
		[self.parsedObject 
		 setValue:[self convertProperty:self.contentOfCurrentProperty toType:self.currentPropertyType]  
		 forKey:self.currentPropertyName];
	}
	else if ([self.currentPropertyName isEqualToString:[self convertElementName:[elementName camelize]]]) {
		//element is closed, pop it from the stack
		[self.unclosedProperties removeLastObject];
		//check for a parent object on the stack
		if ([self.unclosedProperties count] > 0) {
			//handle arrays as a special case
			if ([[[self.unclosedProperties lastObject] objectAtIndex:1] isKindOfClass:[NSArray class]]) {
				[[[self.unclosedProperties lastObject] objectAtIndex:1] addObject:self.parsedObject];
			}
			else {
				[[[self.unclosedProperties lastObject] objectAtIndex:1] setValue:self.parsedObject forKey:[self convertElementName:[elementName camelize]]];
			}
			self.parsedObject = [[self.unclosedProperties lastObject] objectAtIndex:1];
		}
	}
	
	self.contentOfCurrentProperty = nil;
	
	//set the parent object, if one exists, as the current element
	if ([self.unclosedProperties count] > 0) {
		self.currentPropertyName = [[self.unclosedProperties lastObject] objectAtIndex:0];
	}
}


#pragma mark cleanup 

- (void)dealloc {
	[targetClass release];
	[currentPropertyName release];
	[parsedObject release];
	[contentOfCurrentProperty release];
	[unclosedProperties release];
	[currentPropertyType release];
	[super dealloc];
}

@end
