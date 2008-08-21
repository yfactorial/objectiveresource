//
//  ActiveResourceBase.h
//  medaxion
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ActiveResource.h"

@interface ActiveResource (Base)

// Resource configuration
+ (NSString *)getSite;
+ (void)setSite:(NSString*)siteURL;
+ (NSString *)getUser;
+ (void)setUser:(NSString *)user;
+ (NSString *)getPassword;
+ (void)setPassword:(NSString *)password;


// Finders
+ (NSArray *)findAll;

// URL construction accessors
+ (NSString *)elementName;
+ (NSString *)collectionName;
+ (NSString *)protocolExtension;
+ (NSString *)elementPath;
+ (NSString *)collectionPath;
+ (NSString *)collectionPathWithParameters:(NSDictionary *)parameters;
+ (NSString *)populatePath:(NSString *)path withParameters:(NSDictionary *)parameters;

// Instance-specific methods
- (void)create;
- (void)createWithParameters:(NSDictionary *)parameters;

// Instance helpers for getting at commonly used class-level values
- (NSString *)collectionPath;

@end
