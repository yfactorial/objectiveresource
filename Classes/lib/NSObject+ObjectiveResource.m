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
+ (NSString *)getRemoteSite {
	return _activeResourceSite;
}

+ (void)setRemoteSite:(NSString *)siteURL {
	_activeResourceSite = siteURL;
}

+ (NSString *)getRemoteUser {
	return _activeResourceUser;
}

+ (void)setRemoteUser:(NSString *)user {
	_activeResourceUser = user;
}

+ (NSString *)getRemotePassword {
	return _activeResourcePassword;
}

+ (void)setRemotePassword:(NSString *)password {
	_activeResourcePassword = password;
}

+ (void)setRemoteResponseType:(ORSResponseFormat) format {
	_format = format;
	switch (format) {
		case JSONResponse:
			[[self class] setRemoteProtocolExtension:@".json"];
			[[self class] setRemoteParseDataMethod:@selector(fromJSONData:)];
			[[self class] setRemoteSerializeMethod:@selector(toJSONExcluding:)];
			break;
		default:
			[[self class] setRemoteProtocolExtension:@".xml"];
			[[self class] setRemoteParseDataMethod:@selector(fromXMLData:)];
			[[self class] setRemoteSerializeMethod:@selector(toXMLElementExcluding:)];
			break;
	}
}

+ (ORSResponseFormat)getRemoteResponseType {
	return _format;
}

+ (SEL)getRemoteParseDataMethod {
	return (nil == _activeResourceParseDataMethod) ? @selector(fromXMLData:) : _activeResourceParseDataMethod;
}

+ (void)setRemoteParseDataMethod:(SEL)parseMethod {
	_activeResourceParseDataMethod = parseMethod;
}

+ (SEL) getRemoteSerializeMethod {
	return (nil == _activeResourceSerializeMethod) ? @selector(toXMLElementExcluding:) : _activeResourceSerializeMethod;
}

+ (void) setRemoteSerializeMethod:(SEL)serializeMethod {
	_activeResourceSerializeMethod = serializeMethod;
}

+ (NSString *)getRemoteProtocolExtension {
	return _activeResourceProtocolExtension;
}

+ (void)setRemoteProtocolExtension:(NSString *)protocolExtension {
	_activeResourceProtocolExtension = protocolExtension;
}


// Find all items 
+ (NSArray *)findAllRemoteWithResponse:(NSError **)aError {
	Response *res = [Connection get:[self getRemoteCollectionPath] withUser:[[self class] getRemoteUser] andPassword:[[self class]  getRemotePassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [self performSelector:[self getRemoteParseDataMethod] withObject:res.body];
}

+ (NSArray *)findAllRemote {
	NSError *aError;
	return [self findAllRemoteWithResponse:&aError];
}

+ (id)findRemote:(NSString *)elementId withResponse:(NSError **)aError {
	Response *res = [Connection get:[self getRemoteElementPath:elementId] withUser:[[self class] getRemoteUser] andPassword:[[self class]  getRemotePassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [self performSelector:[self getRemoteParseDataMethod] withObject:res.body];
}

+ (id)findRemote:(NSString *)elementId {
	NSError *aError;
	return [self findRemote:elementId withResponse:&aError];
}

+ (NSString *)getRemoteElementName {
	return [[NSStringFromClass([self class]) stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
			 withString:[[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0,1)] lowercaseString]] underscore];
}

+ (NSString *)getRemoteCollectionName {
	return [[self getRemoteElementName] stringByAppendingString:@"s"];
}

+ (NSString *)getRemoteElementPath:(NSString *)elementId {
	return [NSString stringWithFormat:@"%@%@/%@%@", [self getRemoteSite], [self getRemoteCollectionName], elementId, [self getRemoteProtocolExtension]];
}

+ (NSString *)getRemoteCollectionPath {
	return [[[self getRemoteSite] stringByAppendingString:[self getRemoteCollectionName]] stringByAppendingString:[self getRemoteProtocolExtension]];
}

+ (NSString *)getRemoteCollectionPathWithParameters:(NSDictionary *)parameters {
	return [self populateRemotePath:[self getRemoteCollectionPath] withParameters:parameters];
}	

+ (NSString *)populateRemotePath:(NSString *)path withParameters:(NSDictionary *)parameters {
	
	// Translate each key to have a preceeding ":" for proper URL param notiation
	NSMutableDictionary *parameterized = [NSMutableDictionary dictionaryWithCapacity:[parameters count]];
	for (NSString *key in parameters) {
		[parameterized setObject:[parameters objectForKey:key] forKey:[NSString stringWithFormat:@":%@", key]];
	}
	return [path gsub:parameterized];
}

- (NSString *)getRemoteCollectionPath {
	return [[self class] getRemoteCollectionPath];
}

// Converts the object to the data format expected by the server
- (NSString *)convertToRemoteExpectedType {
	// exclude id , created_at , updated_at
	NSArray	 *defaultExclusions = [NSArray arrayWithObjects:[self getRemoteClassIdName],@"createdAt",@"updatedAt",nil];
	return [self performSelector:[[self class] getRemoteSerializeMethod] withObject:defaultExclusions];
}

#pragma mark default equals methods for id and class based equality
- (BOOL)isEqualToRemote:(id)anObject {
	return 	[NSStringFromClass([self class]) isEqualToString:NSStringFromClass([anObject class])] &&
	[anObject respondsToSelector:@selector(getRemoteId)] && [[anObject getRemoteId]isEqualToString:[self getRemoteId]];
}
- (NSUInteger)hashForRemote {
	return [[self getRemoteId] intValue] + [NSStringFromClass([self class]) hash];
}

#pragma mark Instance-specific methods
- (id)getRemoteId {
	id result = nil;
	SEL idMethodSelector = NSSelectorFromString([self getRemoteClassIdName]);
	if ([self respondsToSelector:idMethodSelector]) {
		result = [self performSelector:idMethodSelector];
		if ([result respondsToSelector:@selector(stringValue)]) {
			result = [result stringValue];
		}
	}
	return result;
}
- (void)setRemoteId:(id)orsId {
	SEL setter = NSSelectorFromString([NSString stringWithFormat:@"set%@Id:",[self className]]);
	if ([self respondsToSelector:setter]) {
		[self performSelector:setter withObject:orsId];
	}
}


- (NSString *)getRemoteClassIdName {
	
	return [NSString stringWithFormat:@"%@Id",
			[NSStringFromClass([self class]) stringByReplacingCharactersInRange:NSMakeRange(0, 1) 
			 withString:[[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0,1)] lowercaseString]]];
	
}

- (BOOL)createRemoteAtPath:(NSString *)path withResponse:(NSError **)aError {
	Response *res = [Connection post:[self convertToRemoteExpectedType] to:path withUser:[[self class]  getRemoteUser] andPassword:[[self class]  getRemotePassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	if ([res isSuccess]) {
		NSDictionary *newProperties = [[[self class] performSelector:[[self class] getRemoteParseDataMethod] withObject:res.body] properties];
		[self setProperties:newProperties];
		return YES;
	}
	else {
		return NO;
	}
}

-(BOOL)updateRemoteAtPath:(NSString *)path withResponse:(NSError **)aError {	
	Response *res = [Connection put:[self convertToRemoteExpectedType] to:path 
						   withUser:[[self class]  getRemoteUser] andPassword:[[self class]  getRemotePassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	if ([res isSuccess]) {
		if([(NSString *)[res.headers objectForKey:@"Content-Length"] intValue] > 1) {
			NSDictionary *newProperties = [[[self class] performSelector:[[self class] getRemoteParseDataMethod] withObject:res.body] properties];
			[self setProperties:newProperties];
		}
		return YES;
	}
	else {
		return NO;
	}
	
}

- (BOOL)destroyRemoteAtPath:(NSString *)path withResponse:(NSError **)aError {
	Response *res = [Connection delete:path withUser:[[self class]  getRemoteUser] andPassword:[[self class]  getRemotePassword]];
	if([res isError] && aError) {
		*aError = res.error;
	}
	return [res	isSuccess];
}

- (BOOL)createRemoteWithResponse:(NSError **)aError {
	return [self createRemoteAtPath:[self getRemoteCollectionPath] withResponse:aError];	
}

- (BOOL)createRemote {
	NSError *error;
	return [self createRemoteWithResponse:&error];
}

- (BOOL)createRemoteWithParameters:(NSDictionary *)parameters andResponse:(NSError **)aError {
	return [self createRemoteAtPath:[[self class] getRemoteCollectionPathWithParameters:parameters] withResponse:aError];
}

- (BOOL)createRemoteWithParameters:(NSDictionary *)parameters {
	NSError *error;
	return [self createRemoteWithParameters:parameters andResponse:&error];
}


- (BOOL)destroyRemoteWithResponse:(NSError **)aError {
	id myId = [self getRemoteId];
	if (nil != myId) {
		return [self destroyRemoteAtPath:[[self class] getRemoteElementPath:myId] withResponse:aError];
	}
	else {
		// this should return a error
		return NO;
	}
}

- (BOOL)destroyRemote {
	NSError *error;
	return [self destroyRemoteWithResponse:&error];
}

- (BOOL)updateRemoteWithResponse:(NSError **)aError {
	id myId = [self getRemoteId];
	if (nil != myId) {
		return [self updateRemoteAtPath:[[self class] getRemoteElementPath:myId] withResponse:aError];
	}
	else {
		// this should return an error
		return NO;
	}
}

- (BOOL)updateRemote {
	NSError *error;
	return [self updateRemoteWithResponse:&error];
}

- (BOOL)saveRemoteWithResponse:(NSError **)aError {
	id myId = [self getRemoteId];
	if (nil == myId) {
		return [self createRemoteWithResponse:aError];
	}
	else {
		return [self updateRemoteWithResponse:aError];
	}
}

- (BOOL)saveRemote {
	NSError *error;
	return [self saveRemoteWithResponse:&error];
}

@end
