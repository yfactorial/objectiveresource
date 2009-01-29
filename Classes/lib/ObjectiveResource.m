//
//  ObjectiveResource.m
//  
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ObjectiveResource.h"

@implementation ObjectiveResource
#pragma mark Resource configuration
+ (NSString *)getSite {
	return [self getORSSite];
}
+ (void)setSite:(NSString*)siteURL {
	[self setORSSite:siteURL];
}
+ (NSString *)getUser {
	return [self getORSUser];
}
+ (void)setUser:(NSString *)user {
	[self setORSUser:user];
}
+ (NSString *)getPassword {
	return [self getORSPassword];
}
+ (void)setPassword:(NSString *)password {
	[self setORSPassword:password];
}
+ (SEL)getParseDataMethod {
	return [self getORSParseDataMethod];
}
+ (void)setParseDataMethod:(SEL)parseMethod {
	[self setORSParseDataMethod:parseMethod];
}
+ (SEL) getSerializeMethod {
	return [self getORSSerializeMethod];
}
+ (void) setSerializeMethod:(SEL)serializeMethod {
	[self setORSSerializeMethod:serializeMethod];
}
+ (NSString *)protocolExtension {
	return [self getORSProtocolExtension];
}
+ (void)setProtocolExtension:(NSString *)protocolExtension {
	[self setORSProtocolExtension:protocolExtension];
}
+ (void)setResponseType:(ORSResponseFormat) format {
	[self setORSResponseType:format];
}
+ (ORSResponseFormat)getResponseType {
	return [self getORSResponseType];
}


// Finders
+ (NSArray *)findAll {
	return [self findAllORS];
}
+ (NSArray *)findAllWithResponse:(NSError **)aError {
	return [self findAllORSWithResponse:aError];
}
+ (id)find:(NSString *)elementId {
	return [self findORS:elementId];
}
+ (id)find:(NSString *)elementId withResponse:(NSError **)aError {
	return [self findORS:elementId withResponse:aError];
}

// URL construction accessors
+ (NSString *)elementName {
	return [self getORSElementName];
}
+ (NSString *)collectionName {
	return [self getORSCollectionName];
}
+ (NSString *)elementPath:(NSString *)elementId {
	return [self getORSElementPath:elementId];
}
+ (NSString *)collectionPath {
	return [self getORSCollectionPath];
}
+ (NSString *)collectionPathWithParameters:(NSDictionary *)parameters {
	return [self getORSCollectionPathWithParameters:parameters];
}
+ (NSString *)populatePath:(NSString *)path withParameters:(NSDictionary *)parameters {
	return [self populateORSPath:path withParameters:parameters];
}

// Instance-specific methods
- (id)getId {
	return [self getORSId];
}
- (NSString *)classIdName {
	return [self getORSClassIdName];
}
- (BOOL)create {
	return [self createORS];
}
- (BOOL)createWithResponse:(NSError **)aError {
	return [self createORSWithResponse:aError];
}
- (BOOL)createWithParameters:(NSDictionary *)parameters {
	return [self createORSWithParameters:parameters];
}
- (BOOL)createWithParameters:(NSDictionary *)parameters andResponse:(NSError **)aError {
	return [self createORSWithParameters:parameters andResponse:aError];
}
- (BOOL)destroy {
	return [self destroyORS];
}
- (BOOL)destroyWithResponse:(NSError **)aError {
	return [self destroyORSWithResponse:aError];
}
- (BOOL)update {
	return [self updateORS];
}
- (BOOL)updateWithResponse:(NSError **)aError {
	return [self updateORSWithResponse:aError];
}
- (BOOL)save {
	return [self saveORS];
}
- (BOOL)saveWithResponse:(NSError **)aError {
	return [self saveORSWithResponse:aError];
}
- (BOOL)createAtPath:(NSString *)path withResponse:(NSError **)aError {
	return [self createORSAtPath:path withResponse:aError];
}
- (BOOL)updateAtPath:(NSString *)path withResponse:(NSError **)aError {
	return [self updateORSAtPath:path withResponse:aError];
}
- (BOOL)destroyAtPath:(NSString *)path withResponse:(NSError **)aError {
	return [self destroyORSAtPath:path withResponse:aError];
}
@end