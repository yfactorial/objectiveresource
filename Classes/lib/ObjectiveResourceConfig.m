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
	return [self getRemoteSite];
}
+ (void)setSite:(NSString*)siteURL {
	[self setRemoteSite:siteURL];
}
+ (NSString *)getUser {
	return [self getRemoteUser];
}
+ (void)setUser:(NSString *)user {
	[self setRemoteUser:user];
}
+ (NSString *)getPassword {
	return [self getRemotePassword];
}
+ (void)setPassword:(NSString *)password {
	[self setRemotePassword:password];
}
+ (SEL)getParseDataMethod {
	return [self getRemoteParseDataMethod];
}
+ (void)setParseDataMethod:(SEL)parseMethod {
	[self setRemoteParseDataMethod:parseMethod];
}
+ (SEL) getSerializeMethod {
	return [self getRemoteSerializeMethod];
}
+ (void) setSerializeMethod:(SEL)serializeMethod {
	[self setRemoteSerializeMethod:serializeMethod];
}
+ (NSString *)protocolExtension {
	return [self getRemoteProtocolExtension];
}
+ (void)setProtocolExtension:(NSString *)protocolExtension {
	[self setRemoteProtocolExtension:protocolExtension];
}
+ (void)setResponseType:(ORSResponseFormat) format {
	[self setRemoteResponseType:format];
}
+ (ORSResponseFormat)getResponseType {
	return [self getRemoteResponseType];
}

@end
