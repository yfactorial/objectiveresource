//
//  Connection.h
//  
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@class Response;

@interface Connection : NSObject
+ (void) setTimeout:(float)timeout;
+ (float) timeout;
+ (Response *)post:(NSString *)body to:(NSString *)url;
+ (Response *)post:(NSString *)body to:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password;
+ (Response *)get:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password;
+ (Response *)get:(NSString *)url;
+ (Response *)put:(NSString *)body to:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password;
+ (Response *)delete:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password;

+ (void) cancelAllActiveConnections;

@end
