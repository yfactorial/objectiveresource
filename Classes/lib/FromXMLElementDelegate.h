//
//  FromXMLElementDelegate.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@interface FromXMLElementDelegate : NSObject {
	Class targetClass;
  id parsedObject;
	NSString *currentPropertyName;
  NSMutableString *contentOfCurrentProperty;
	NSMutableArray *unclosedProperties;
	NSString *currentPropertyType;
}

@property (nonatomic, retain) Class targetClass;
@property (nonatomic, retain) id parsedObject;
@property (nonatomic, retain) NSString *currentPropertyName;
@property (nonatomic, retain) NSMutableString *contentOfCurrentProperty;
@property (nonatomic, retain) NSMutableArray *unclosedProperties;
@property (nonatomic, retain) NSString *currentPropertyType;

+ (FromXMLElementDelegate *)delegateForClass:(Class)targetClass;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (NSString *)convertElementName:(NSString *)anElementName;

@end
