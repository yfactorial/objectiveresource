//
//  NSObject+JSONSerializableSupport.h
//  active_resource
//
//  Created by vickeryj on 1/8/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface NSObject (JSONSerializableSupport) <JSONSerializable>

+ (id)fromJSONData:(NSData *)data;
- (NSString *)toJSON;
- (NSString *)toJSONExcluding:(NSArray *)exclusions;
- (NSString *)toJSONAs:(NSString *)rootName;
- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions;
- (NSString *)toJSONAs:(NSString *)rootName withTranslations:(NSDictionary *)keyTranslations;
- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations;

@end
