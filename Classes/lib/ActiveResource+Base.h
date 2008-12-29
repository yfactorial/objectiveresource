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
+ (NSArray *)findAllWithResponse:(NSError **)aError;
+ (id)find:(NSString *)elementId;
+ (id)find:(NSString *)elementId withResponse:(NSError **)aError; 

// URL construction accessors
+ (NSString *)elementName;
+ (NSString *)collectionName;
+ (NSString *)protocolExtension;
+ (NSString *)elementPath:(NSString *)elementId;
+ (NSString *)collectionPath;
+ (NSString *)collectionPathWithParameters:(NSDictionary *)parameters;
+ (NSString *)populatePath:(NSString *)path withParameters:(NSDictionary *)parameters;

// Instance-specific methods
- (id)getId;
- (NSString *)classIdName;
- (BOOL)create;
- (BOOL)createWithResponse:(NSError **)aError;
- (BOOL)createWithParameters:(NSDictionary *)parameters;
- (BOOL)createWithParameters:(NSDictionary *)parameters andResponse:(NSError **)aError;
- (BOOL)destroy;
- (BOOL)destroyWithResponse:(NSError **)aError;
- (BOOL)update;
- (BOOL)updateWithResponse:(NSError **)aError;
- (BOOL)save;
- (BOOL)saveWithResponse:(NSError **)aError;


- (BOOL)createAtPath:(NSString *)path withResponse:(NSError **)aError;
-	(BOOL)updateAtPath:(NSString *)path withResponse:(NSError **)aError;
- (BOOL)destroyAtPath:(NSString *)path withResponse:(NSError **)aError;

// Instance helpers for getting at commonly used class-level values
- (NSString *)collectionPath;

@end
