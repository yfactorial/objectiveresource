//
//  ObjectiveResourceConfig.h
//  objective_resource
//
//  Created by vickeryj on 1/29/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import "ObjectiveResource.h"

@interface ObjectiveResourceConfig : NSObject 

+ (NSString *)getSite;
+ (void)setSite:(NSString*)siteURL;
+ (NSString *)getUser;
+ (void)setUser:(NSString *)user;
+ (NSString *)getPassword;
+ (void)setPassword:(NSString *)password;
+ (SEL)getParseDataMethod;
+ (void)setParseDataMethod:(SEL)parseMethod;
+ (SEL) getSerializeMethod;
+ (void) setSerializeMethod:(SEL)serializeMethod;
+ (NSString *)protocolExtension;
+ (void)setProtocolExtension:(NSString *)protocolExtension;
+ (void)setResponseType:(ORSResponseFormat) format;
+ (ORSResponseFormat)getResponseType;

@end
