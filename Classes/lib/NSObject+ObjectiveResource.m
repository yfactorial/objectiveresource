//
//  NSObject+ObjectiveResource.m
//  objectivesync
//
//  Created by vickeryj on 1/29/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import "NSObject+ObjectiveResource.h"
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
static ORSResponseFormat _format;

@implementation NSObject (ObjectiveResource)

#pragma mark configuration methods
+ (NSString *)getORSSite {
	return _activeResourceSite;
}

+ (void)setORSSite:(NSString *)siteURL {
	_activeResourceSite = siteURL;
}

+ (NSString *)getORSUser {
	return _activeResourceUser;
}

+ (void)setORSUser:(NSString *)user {
	_activeResourceUser = user;
}

+ (NSString *)getORSPassword {
	return _activeResourcePassword;
}

+ (void)setORSPassword:(NSString *)password {
	_activeResourcePassword = password;
}

+ (void)setORSResponseType:(ORSResponseFormat) format {
	_format = format;
	switch (format) {
		case JSONResponse:
			[[self class] setORSProtocolExtension:@".json"];
			[[self class] setORSParseDataMethod:@selector(fromJSONData:)];
			[[self class] setORSSerializeMethod:@selector(toJSONExcluding:)];
			break;
		default:
			[[self class] setORSProtocolExtension:@".xml"];
			[[self class] setORSParseDataMethod:@selector(fromXMLData:)];
			[[self class] setORSSerializeMethod:@selector(toXMLElementExcluding:)];
			break;
	}
}

+ (ORSResponseFormat)getORSResponseType {
	return _format;
}

+ (SEL)getORSParseDataMethod {
	return (nil == _activeResourceParseDataMethod) ? @selector(fromXMLData:) : _activeResourceParseDataMethod;
}

+ (void)setORSParseDataMethod:(SEL)parseMethod {
	_activeResourceParseDataMethod = parseMethod;
}

+ (SEL) getORSSerializeMethod {
	return (nil == _activeResourceSerializeMethod) ? @selector(toXMLElementExcluding:) : _activeResourceSerializeMethod;
}

+ (void) setORSSerializeMethod:(SEL)serializeMethod {
	_activeResourceSerializeMethod = serializeMethod;
}

+ (NSString *)getORSProtocolExtension {
	return _activeResourceProtocolExtension;
}

+ (void)setORSProtocolExtension:(NSString *)protocolExtension {
	_activeResourceProtocolExtension = protocolExtension;
}


// Find all items 
+ (NSArray *)findAllORSWithResponse:(NSError **)aError {
	Response *res = [Connection get:[self getORSCollectionPath] withUser:[[self class] getORSUser] andPassword:[[self class]  getORSPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [self performSelector:[self getORSParseDataMethod] withObject:res.body];
}

+ (NSArray *)findAllORS {
	NSError *aError;
	return [self findAllORSWithResponse:&aError];
}

+ (id)findORS:(NSString *)elementId withResponse:(NSError **)aError {
	Response *res = [Connection get:[self getORSElementPath:elementId] withUser:[[self class] getORSUser] andPassword:[[self class]  getORSPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [self performSelector:[self getORSParseDataMethod] withObject:res.body];
}

+ (id)findORS:(NSString *)elementId {
	NSError *aError;
	return [self findORS:elementId withResponse:&aError];
}

+ (NSString *)getORSElementName {
	return [[NSStringFromClass([self class]) stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
			 withString:[[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0,1)] lowercaseString]] underscore];
}

+ (NSString *)getORSCollectionName {
	return [[self getORSElementName] stringByAppendingString:@"s"];
}

+ (NSString *)getORSElementPath:(NSString *)elementId {
	return [NSString stringWithFormat:@"%@%@/%@%@", [self getORSSite], [self getORSCollectionName], elementId, [self getORSProtocolExtension]];
}

+ (NSString *)getORSCollectionPath {
	return [[[self getORSSite] stringByAppendingString:[self getORSCollectionName]] stringByAppendingString:[self getORSProtocolExtension]];
}

+ (NSString *)getORSCollectionPathWithParameters:(NSDictionary *)parameters {
	return [self populateORSPath:[self getORSCollectionPath] withParameters:parameters];
}	

+ (NSString *)populateORSPath:(NSString *)path withParameters:(NSDictionary *)parameters {
	
	// Translate each key to have a preceeding ":" for proper URL param notiation
	NSMutableDictionary *parameterized = [NSMutableDictionary dictionaryWithCapacity:[parameters count]];
	for (NSString *key in parameters) {
		[parameterized setObject:[parameters objectForKey:key] forKey:[NSString stringWithFormat:@":%@", key]];
	}
	return [path gsub:parameterized];
}

- (NSString *)getORSCollectionPath {
	return [[self class] getORSCollectionPath];
}

// Converts the object to the data format expected by the server
- (NSString *)convertToORSExpectedType {
	// exclude id , created_at , updated_at
	NSArray	 *defaultExclusions = [NSArray arrayWithObjects:[self getORSClassIdName],@"createdAt",@"updatedAt",nil];
	return [self performSelector:[[self class] getORSSerializeMethod] withObject:defaultExclusions];
}

#pragma mark default equals methods for id and class based equality
- (BOOL)isEqual:(id)anObject {
	return 	[NSStringFromClass([self class]) isEqualToString:NSStringFromClass([anObject class])] &&
	[anObject respondsToSelector:@selector(getId)] && [[anObject getORSId] isEqualToString:[self getORSId]];
}
- (NSUInteger)hash {
	return [[self getORSId] intValue] + [NSStringFromClass([self class]) hash];
}

#pragma mark Instance-specific methods
- (id)getORSId {
	id result = nil;
	SEL idMethodSelector = NSSelectorFromString([self getORSClassIdName]);
	if ([self respondsToSelector:idMethodSelector]) {
		result = [self performSelector:idMethodSelector];
	}
	return result;
}

- (NSString *)getORSClassIdName {
	
	return [NSString stringWithFormat:@"%@Id",
			[NSStringFromClass([self class]) stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
			 withString:[[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0,1)] lowercaseString]]];
	
}

- (BOOL)createORSAtPath:(NSString *)path withResponse:(NSError **)aError {
	Response *res = [Connection post:[self convertToORSExpectedType] to:path withUser:[[self class]  getORSUser] andPassword:[[self class]  getORSPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	if ([res isSuccess]) {
		NSDictionary *newProperties = [[[self class] performSelector:[[self class] getORSParseDataMethod] withObject:res.body] properties];
		[self setProperties:newProperties];
		return YES;
	}
	else {
		return NO;
	}
}

-(BOOL)updateORSAtPath:(NSString *)path withResponse:(NSError **)aError {	
	Response *res = [Connection put:[self convertToORSExpectedType] to:path 
						   withUser:[[self class]  getORSUser] andPassword:[[self class]  getORSPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	if ([res isSuccess]) {
		if([(NSString *)[res.headers objectForKey:@"Content-Length"] intValue] > 1) {
			NSDictionary *newProperties = [[[self class] performSelector:[[self class] getORSParseDataMethod] withObject:res.body] properties];
			[self setProperties:newProperties];
		}
		return YES;
	}
	else {
		return NO;
	}
	
}

- (BOOL)destroyORSAtPath:(NSString *)path withResponse:(NSError **)aError {
	Response *res = [Connection delete:path withUser:[[self class]  getORSUser] andPassword:[[self class]  getORSPassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [res	isSuccess];
}

- (BOOL)createORSWithResponse:(NSError **)aError {
	return [self createORSAtPath:[self getORSCollectionPath] withResponse:aError];	
}

- (BOOL)createORS {
	NSError *error;
	return [self createORSWithResponse:&error];
}

- (BOOL)createORSWithParameters:(NSDictionary *)parameters andResponse:(NSError **)aError {
	return [self createORSAtPath:[[self class] getORSCollectionPathWithParameters:parameters] withResponse:aError];
}

- (BOOL)createORSWithParameters:(NSDictionary *)parameters {
	NSError *error;
	return [self createORSWithParameters:parameters andResponse:&error];
}


- (BOOL)destroyORSWithResponse:(NSError **)aError {
	id myId = [self getORSId];
	if (nil != myId) {
		return [self destroyORSAtPath:[[self class] getORSElementPath:myId] withResponse:aError];
	}
	else {
		// this should return a error
		return NO;
	}
}

- (BOOL)destroyORS {
	NSError *error;
	return [self destroyORSWithResponse:&error];
}

- (BOOL)updateORSWithResponse:(NSError **)aError {
	id myId = [self getORSId];
	if (nil != myId) {
		return [self updateORSAtPath:[[self class] getORSElementPath:myId] withResponse:aError];
	}
	else {
		// this should return an error
		return NO;
	}
}

- (BOOL)updateORS {
	NSError *error;
	return [self updateORSWithResponse:&error];
}

- (BOOL)saveORSWithResponse:(NSError **)aError {
	id myId = [self getORSId];
	if (nil == myId) {
		return [self createORSWithResponse:aError];
	}
	else {
		return [self updateORSWithResponse:aError];
	}
}

- (BOOL)saveORS {
	NSError *error;
	return [self saveORSWithResponse:&error];
}

@end
