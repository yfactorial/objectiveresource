//
//  ObjectiveResource.m
//  
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ObjectiveResource.h"
#import "Connection.h"
#import "Response.h"
#import "CoreSupport.h"
#import "XMLSerializableSupport.h"
#import "JSONSerializableSupport.h"

static NSString *_activeResourceSite = nil;
static NSString *_activeResourceUser = nil;
static NSString *_activeResourcePassword = nil;
static SEL _activeResourceParseDataMethod = nil;
static SEL _activeResourceSerializeMethod = nil;
static NSString *_activeResourceProtocolExtension = @".xml";
static ResponseFormat _format;

@interface ObjectiveResource()
- (NSString *)convertToExpectedType;
@end


@implementation ObjectiveResource

#pragma mark configuration methods
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

+ (void)setResponseType:(ResponseFormat) format {
	_format = format;
	switch (format) {
		case JSONResponse:
			[[self class] setProtocolExtension:@".json"];
			[[self class] setParseDataMethod:@selector(fromJSONData:)];
			[[self class] setSerializeMethod:@selector(toJSONExcluding:)];
			break;
		default:
			[[self class] setProtocolExtension:@".xml"];
			[[self class] setParseDataMethod:@selector(fromXMLData:)];
			[[self class] setSerializeMethod:@selector(toXMLElementExcluding:)];
			break;
	}
}

+ (ResponseFormat)getResponseType {
	return _format;
}

+ (SEL)getParseDataMethod {
	return (nil == _activeResourceParseDataMethod) ? @selector(fromXMLData:) : _activeResourceParseDataMethod;
}

+ (void)setParseDataMethod:(SEL)parseMethod {
	_activeResourceParseDataMethod = parseMethod;
}

+ (SEL) getSerializeMethod {
	return (nil == _activeResourceSerializeMethod) ? @selector(toXMLElementExcluding:) : _activeResourceSerializeMethod;
}

+ (void) setSerializeMethod:(SEL)serializeMethod {
	_activeResourceSerializeMethod = serializeMethod;
}

+ (NSString *)protocolExtension {
	return _activeResourceProtocolExtension;
}

+ (void)setProtocolExtension:(NSString *)protocolExtension {
	_activeResourceProtocolExtension = protocolExtension;
}


// Find all items 
+ (NSArray *)findAllWithResponse:(NSError **)aError {
	Response *res = [Connection get:[self collectionPath] withUser:[[self class] getUser] andPassword:[[self class]  getPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [self performSelector:[self getParseDataMethod] withObject:res.body];
}

+ (NSArray *)findAll {
	NSError *aError;
	return [self findAllWithResponse:&aError];
}

+ (id)find:(NSString *)elementId withResponse:(NSError **)aError {
	Response *res = [Connection get:[self elementPath:elementId] withUser:[[self class] getUser] andPassword:[[self class]  getPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [self performSelector:[self getParseDataMethod] withObject:res.body];
}

+ (id)find:(NSString *)elementId {
	NSError *aError;
	return [self find:elementId withResponse:&aError];
}

+ (NSString *)elementName {
	return [[NSStringFromClass([self class]) stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
			 withString:[[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0,1)] lowercaseString]] underscore];
}

+ (NSString *)collectionName {
	return [[self elementName] stringByAppendingString:@"s"];
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

// Converts the object to the data format expected by the server
- (NSString *)convertToExpectedType {
	// exclude id , created_at , updated_at
	NSArray	 *defaultExclusions = [NSArray arrayWithObjects:[self classIdName],@"createdAt",@"updatedAt",nil];
	return [self performSelector:[[self class] getSerializeMethod] withObject:defaultExclusions];
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

- (BOOL)createAtPath:(NSString *)path withResponse:(NSError **)aError {
	Response *res = [Connection post:[self convertToExpectedType] to:path withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	if ([res isSuccess]) {
		NSDictionary *newProperties = [[[self class] performSelector:[[self class] getParseDataMethod] withObject:res.body] properties];
		[self setProperties:newProperties];
		return YES;
	}
	else {
		return NO;
	}
}

-(BOOL)updateAtPath:(NSString *)path withResponse:(NSError **)aError {	
	Response *res = [Connection put:[self convertToExpectedType] to:path 
						   withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	if ([res isSuccess]) {
		if([(NSString *)[res.headers objectForKey:@"Content-Length"] intValue] > 1) {
			NSDictionary *newProperties = [[[self class] performSelector:[[self class] getParseDataMethod] withObject:res.body] properties];
			[self setProperties:newProperties];
		}
		return YES;
	}
	else {
		return NO;
	}
	
}

- (BOOL)destroyAtPath:(NSString *)path withResponse:(NSError **)aError {
	Response *res = [Connection delete:path withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [res	isSuccess];
}

- (BOOL)createWithResponse:(NSError **)aError {
	return [self createAtPath:[self collectionPath] withResponse:aError];	
}

- (BOOL)create {
	NSError *error;
	return [self createWithResponse:&error];
}

- (BOOL)createWithParameters:(NSDictionary *)parameters andResponse:(NSError **)aError {
	return [self createAtPath:[[self class] collectionPathWithParameters:parameters] withResponse:aError];
}

- (BOOL)createWithParameters:(NSDictionary *)parameters {
	NSError *error;
	return [self createWithParameters:parameters andResponse:&error];
}


- (BOOL)destroyWithResponse:(NSError **)aError {
	id myId = [self getId];
	if (nil != myId) {
		return [self destroyAtPath:[[self class] elementPath:myId] withResponse:aError];
	}
	else {
		// this should return a error
		return NO;
	}
}

- (BOOL)destroy {
	NSError *error;
	return [self destroyWithResponse:&error];
}

- (BOOL)updateWithResponse:(NSError **)aError {
	id myId = [self getId];
	if (nil != myId) {
		return [self updateAtPath:[[self class] elementPath:myId] withResponse:aError];
	}
	else {
		// this should return an error
		return NO;
	}
}

- (BOOL)update {
	NSError *error;
	return [self updateWithResponse:&error];
}

- (BOOL)saveWithResponse:(NSError **)aError {
	id myId = [self getId];
	if (nil == myId) {
		return [self createWithResponse:aError];
	}
	else {
		return [self updateWithResponse:aError];
	}
}

- (BOOL)save {
	NSError *error;
	return [self saveWithResponse:&error];
}


- (void) dealloc
{
	[super dealloc];
}


@end