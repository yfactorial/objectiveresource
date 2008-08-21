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
	[NSStringFromClass(self) lowercaseString];
	return [NSStringFromClass([self class]) lowercaseString];
}

+ (NSString *)collectionName {
	return [[self elementName] stringByAppendingString:@"s"];
}

+ (NSString *)protocolExtension {
	return @".xml";
}

+ (NSString *)elementPath {
	return [[[self getSite] stringByAppendingString:[self elementName]] stringByAppendingString:[self protocolExtension]];
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

- (void)create {
	[Connection post:[self toXMLElement] to:[self collectionPath] withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]];
}

- (void)createWithParameters:(NSDictionary *)parameters {
	[Connection post:[self toXMLElement] to:[[self class] collectionPathWithParameters:parameters] withUser:[[self class]  getUser] andPassword:[[self class]  getPassword]];
}
	
@end