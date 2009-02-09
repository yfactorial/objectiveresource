//
//  NSObject+ObjectiveResource.h
//  objectivesync
//
//  Created by vickeryj on 1/29/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ObjectiveResource)


// Response Formats
typedef enum {
	XmlResponse = 0,
	JSONResponse,
} ORSResponseFormat;

// Resource configuration
+ (NSString *)getRemoteSite;
+ (void)setRemoteSite:(NSString*)siteURL;
+ (NSString *)getRemoteUser;
+ (void)setRemoteUser:(NSString *)user;
+ (NSString *)getRemotePassword;
+ (void)setRemotePassword:(NSString *)password;
+ (SEL)getRemoteParseDataMethod;
+ (void)setRemoteParseDataMethod:(SEL)parseMethod;
+ (SEL) getRemoteSerializeMethod;
+ (void) setRemoteSerializeMethod:(SEL)serializeMethod;
+ (NSString *)getRemoteProtocolExtension;
+ (void)setRemoteProtocolExtension:(NSString *)protocolExtension;
+ (void)setRemoteResponseType:(ORSResponseFormat) format;
+ (ORSResponseFormat)getRemoteResponseType;


// Finders
+ (NSArray *)findAllRemote;
+ (NSArray *)findAllRemoteWithResponse:(NSError **)aError;
+ (id)findRemote:(NSString *)elementId;
+ (id)findRemote:(NSString *)elementId withResponse:(NSError **)aError; 

// URL construction accessors
+ (NSString *)getRemoteElementName;
+ (NSString *)getRemoteCollectionName;
+ (NSString *)getRemoteElementPath:(NSString *)elementId;
+ (NSString *)getRemoteCollectionPath;
+ (NSString *)getRemoteCollectionPathWithParameters:(NSDictionary *)parameters;
+ (NSString *)populateRemotePath:(NSString *)path withParameters:(NSDictionary *)parameters;

// Instance-specific methods
- (id)getRemoteId;
- (void)setRemoteId:(id)orsId;
- (NSString *)getRemoteClassIdName;
- (BOOL)createRemote;
- (BOOL)createRemoteWithResponse:(NSError **)aError;
- (BOOL)createRemoteWithParameters:(NSDictionary *)parameters;
- (BOOL)createRemoteWithParameters:(NSDictionary *)parameters andResponse:(NSError **)aError;
- (BOOL)destroyRemote;
- (BOOL)destroyRemoteWithResponse:(NSError **)aError;
- (BOOL)updateRemote;
- (BOOL)updateRemoteWithResponse:(NSError **)aError;
- (BOOL)saveRemote;
- (BOOL)saveRemoteWithResponse:(NSError **)aError;


- (BOOL)createRemoteAtPath:(NSString *)path withResponse:(NSError **)aError;
- (BOOL)updateRemoteAtPath:(NSString *)path withResponse:(NSError **)aError;
- (BOOL)destroyRemoteAtPath:(NSString *)path withResponse:(NSError **)aError;

// Instance helpers for getting at commonly used class-level values
- (NSString *)getRemoteCollectionPath;
- (NSString *)convertToRemoteExpectedType;

//Equality test for remote enabled objects based on class name and remote id
- (BOOL)isEqualToRemote:(id)anObject;
- (NSUInteger)hashForRemote;

@end
