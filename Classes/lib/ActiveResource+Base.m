//
//  ActiveResourceBase.m
//  medaxion
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ActiveResource+Base.h"
#import "Connection.h"
#import "Response.h"
#import "CoreSupport.h"
#import "XMLSerializableSupport.h"

static NSString *_activeResourceSite = nil;
static NSString *_activeResourceUser = nil;
static NSString *_activeResourcePassword = nil;

@implementation ActiveResource (Base)


+ (NSString *)getSite {
	return _activeResourceSite;
}

+ (void)setSite:(NSString *)siteURL {
	_activeResourceSite = siteURL;
}

+ (NSString *)getUser {
	return _activeResourceUser;
}

+ (void)setUser:(NSString *)user {
	_activeResourceUser = user;
}

+ (NSString *)getPassword {
	return _activeResourcePassword;
}

+ (void)setPassword:(NSString *)password {
	_activeResourcePassword = password;
}


// Find all items 
+ (NSArray *)findAll {
	Response *res = [Connection get:[self collectionPath] withUser:[[self class] getUser] andPassword:[[self class]  getPassword]];
	return [self allFromXMLData:res.body];
}

+ (NSString *)elementName {
	return [[NSStringFromClass([self class]) stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
			withString:[[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0,1)] lowercaseString]] underscore];
}

+ (NSString *)collectionName {
	return [[self elementName] stringByAppendingString:@"s"];
}

+ (NSString *)protocolExtension {
	return @".xml";
}

+ (NSString *)elementPath:(NSString *)elementId {
	return [NSString stringWithFormat:@"%@%@/%@%@", [self getSite], [self collectionName], elementId, [self protocolExtension]];
}

+ (NSString *)collectionPath {
	return [[[self getSite] stringByAppendingString:[self collectionName]] stringByAppendingString:[self protocolExtension]];
}

+ (NSString *)collectionPathWithParameters:(NSDictionary *)parameters {
	return [self populatePath:[self collectionPath] withParameters:parameters];
}	

+ (NSString *)populatePath:(NSString *)path withParameters:(NSDictionary *)parameters {
	
	// Translate each key to have a preceeding ":" for proper URL param notiation
	NSMutableDictionary *parameterized = [NSMutableDictionary dictionaryWithCapacity:[parameters count]];
	for (NSString *key in parameters) {
		[parameterized setObject:[parameters objectForKey:key] forKey:[NSString stringWithFormat:@":%@", key]];
	}
	return [path gsub:parameterized];
}

- (NSString *)collectionPath {
	return [[self class] collectionPath];
}

#pragma mark default equals methods for id and class based equality
- (BOOL)isEqual:(id)anObject {
	return 	[NSStringFromClass([self class]) isEqualToString:NSStringFromClass([anObject class])] &&
		[anObject respondsToSelector:@selector(getId)] && [[anObject getId] isEqualToString:[self getId]];
}
- (NSUInteger)hash {
	return [[self getId] intValue] + [NSStringFromClass([self class]) hash];
}

#pragma mark Instance-specific methods
- (id)getId {
	id result = nil;
	SEL idMethodSelector = NSSelectorFromString([self classIdName]);
	if ([self respondsToSelector:idMethodSelector]) {
		result = [self performSelector:idMethodSelector];
	}
	return result;
}

- (NSString *)classIdName {
  
  return [NSString stringWithFormat:@"%@Id",
          [NSStringFromClass([self class]) stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
           withString:[[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0,1)] lowercaseString]]];
  
}

- (BOOL)createAtPath:(NSString *)path {
	Response *res = [Connection post:[self toXMLElement] to:path withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]];
	if ([res isSuccess]) {
		NSDictionary *newProperties = [[[self class] fromXMLData:res.body] properties];
		[self setProperties:newProperties];
		return YES;
	}
	else {
		return NO;
	}
}

- (BOOL)create {
	return [self createAtPath:[self collectionPath]];
}

- (BOOL)createWithParameters:(NSDictionary *)parameters {
	return [self createAtPath:[[self class] collectionPathWithParameters:parameters]];
}

- (BOOL)destroy {
	id myId = [self getId];
	if (nil != myId) {
		return [[Connection delete:[[self class] elementPath:myId] withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]] isSuccess];
	}
	else {
		return NO;
	}
}

- (BOOL)update {
	id myId = [self getId];
	if (nil != myId) {
		return [[Connection put:[self toXMLElementExcluding:[NSArray arrayWithObject:[self classIdName]]] 
					  to:[[self class] elementPath:myId] 
					   withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]] isSuccess];
	}
	else {
		return NO;
	}
}

- (BOOL)save {
	id myId = [self getId];
	if (nil == myId) {
		return [self create];
	}
	else {
		return [self update];
	}
}

- (void) dealloc
{
  [createdAt release];
	[updatedAt release];
	[super dealloc];
}

	
@end