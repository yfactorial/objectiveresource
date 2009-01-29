//
//  ObjectiveResourceConfig.m
//  objective_resource
//
//  Created by vickeryj on 1/29/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import "ObjectiveResourceConfig.h"

@implementation ObjectiveResourceConfig

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

@end
