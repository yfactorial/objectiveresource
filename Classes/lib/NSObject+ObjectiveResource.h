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
+ (NSString *)getORSSite;
+ (void)setORSSite:(NSString*)siteURL;
+ (NSString *)getORSUser;
+ (void)setORSUser:(NSString *)user;
+ (NSString *)getORSPassword;
+ (void)setORSPassword:(NSString *)password;
+ (SEL)getORSParseDataMethod;
+ (void)setORSParseDataMethod:(SEL)parseMethod;
+ (SEL) getORSSerializeMethod;
+ (void) setORSSerializeMethod:(SEL)serializeMethod;
+ (NSString *)getORSProtocolExtension;
+ (void)setORSProtocolExtension:(NSString *)protocolExtension;
+ (void)setORSResponseType:(ORSResponseFormat) format;
+ (ORSResponseFormat)getORSResponseType;


// Finders
+ (NSArray *)findAllORS;
+ (NSArray *)findAllORSWithResponse:(NSError **)aError;
+ (id)findORS:(NSString *)elementId;
+ (id)findORS:(NSString *)elementId withResponse:(NSError **)aError; 

// URL construction accessors
+ (NSString *)getORSElementName;
+ (NSString *)getORSCollectionName;
+ (NSString *)getORSElementPath:(NSString *)elementId;
+ (NSString *)getORSCollectionPath;
+ (NSString *)getORSCollectionPathWithParameters:(NSDictionary *)parameters;
+ (NSString *)populateORSPath:(NSString *)path withParameters:(NSDictionary *)parameters;

// Instance-specific methods
- (id)getORSId;
- (NSString *)getORSClassIdName;
- (BOOL)createORS;
- (BOOL)createORSWithResponse:(NSError **)aError;
- (BOOL)createORSWithParameters:(NSDictionary *)parameters;
- (BOOL)createORSWithParameters:(NSDictionary *)parameters andResponse:(NSError **)aError;
- (BOOL)destroyORS;
- (BOOL)destroyORSWithResponse:(NSError **)aError;
- (BOOL)updateORS;
- (BOOL)updateORSWithResponse:(NSError **)aError;
- (BOOL)saveORS;
- (BOOL)saveORSWithResponse:(NSError **)aError;


- (BOOL)createORSAtPath:(NSString *)path withResponse:(NSError **)aError;
- (BOOL)updateORSAtPath:(NSString *)path withResponse:(NSError **)aError;
- (BOOL)destroyORSAtPath:(NSString *)path withResponse:(NSError **)aError;

// Instance helpers for getting at commonly used class-level values
- (NSString *)getORSCollectionPath;
- (NSString *)convertToORSExpectedType;

@end
